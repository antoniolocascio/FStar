module FStar.ConstantTime.Integers

(**
    This module provides a refinement of FStar.IFC providing an
    interface restricted only to constant-time operations on integers.

    In contrast, FStar.IFC provides a general monadic information-flow
    control framework, which need not be restricted to constant-time
    operations.
*)

open FStar.IFC
open FStar.Integers


/// `sw`: signedness and width of machine integers excluding
///       FStar.[U]Int128, which does not provide constant-time
///       operations.
let sw =
    s:signed_width{width_of_sw s <> Winfinite /\ width_of_sw s <> W128}

/// A `secret_int l s` is a machine-integer at secrecy level `l` and
/// signedness/width `s`.
val secret_int (#a:Type)
               (#sl:semi_lattice a)
               (l:lattice_element sl)
               (s:sw) : Type0

/// A `secret_int l s` can be seen as an int in spec
val reveal (#a: Type)
           (#sl:semi_lattice a)
           (#l:lattice_element sl)
           (#s:sw)
           (x:secret_int l s)
   : GTot (y:int{within_bounds s y})

/// A `secret_int l s` can be also be seen as an machine integer in spec
let m #a #l (#t:lattice_element #a l) #s (x:secret_int t s)
  : GTot (int_t s)
  = u (reveal x)

/// `hide` is the inverse of `reveal`, proving that `secret_int` is injective
val hide (#a:Type)
         (#sl:semi_lattice a)
         (#l:lattice_element sl)
         (#s:sw)
         (x:int{within_bounds s x})
  : GTot (secret_int l s)

val reveal_hide (#a:Type)
                (#sl:semi_lattice a)
                (#l:lattice_element #a sl)
                (#s:sw)
                (x:int{within_bounds s x})
  : Lemma (reveal (hide #a #sl #l #s x) == x)

val hide_reveal (#a:Type)
                (#sl:semi_lattice a)
                (#l:lattice_element sl)
                (#s:sw)
                (x:secret_int l s)
  : Lemma (hide (reveal x) == x)
          [SMTPat (reveal x)]

/// `promote x l` allows increasing the confidentiality classification of `x`
///  This can easily be programmed using the FStar.IFC interface
val promote (#a:Type)
            (#sl:semi_lattice a)
            (#l0:lattice_element sl)
            (#s:sw)
            (x:secret_int l0 s)
            (l1:lattice_element sl)
  : Tot (y:secret_int (l0 `lub` l1) s{reveal y == reveal x})

//////////////////////////////////////////////////////////////////////////////////////////
/// The remainder of this module provides liftings of specific integers operations
/// to work on secret integers, i.e., only those that respect the constant time guarantees
/// and do not break confidentiality.
///
/// Note, with our choice of representation, it is impossible to
/// implement functions that break basic IFC guarantees, e.g., we
/// cannot implement a boolean comparison function on secret_ints
val addition (#a:Type)
             (#sl:semi_lattice a)
             (#l:lattice_element #a sl)
             (#s:sw)
             (x : secret_int l s)
             (y : secret_int l s {ok ( + ) (m x) (m y)})
    : Tot (z:secret_int l s{m z == m x + m y})

val addition_mod (#a:Type)
                 (#sl:semi_lattice a)
                 (#l:lattice_element sl)
                 (#sw: _ {Unsigned? sw /\ width_of_sw sw <> W128})
                 (x : secret_int l sw)
                 (y : secret_int l sw)
    : Tot (z:secret_int l sw { m z == m x +% m y } )

/// If we like this style, I will proceed to implement a lifting of
/// the rest of the constant-time integers over secret integers

////////////////////////////////////////////////////////////////////////////////
//Now, a multiplexing layer to overload operators over int_t and secret_int
////////////////////////////////////////////////////////////////////////////////
noeq
type qual a =
  | Secret: #sl:semi_lattice a
          -> l:lattice_element sl
          -> sw:sw
          -> qual a
  | Public: sw:signed_width
          -> qual a

[@mark_for_norm]
let t #a (q:qual a) =
  match q with
  | Secret l s -> secret_int l s
  | Public s -> int_t s

[@mark_for_norm]
let q2s #a (q:qual a) : signed_width =
  match q with
  | Secret _ s -> s
  | Public s -> s

[@mark_for_norm]
let i #a (#q:qual a) (x:t q) : GTot (int_t (q2s q)) =
  match q with
  | Public s -> x
  | Secret l s -> m (x <: secret_int l s)

[@mark_for_norm]
let as_secret #a (#q:qual a{Secret? q}) (x:t q)
  : secret_int (Secret?.l q) (Secret?.sw q)
  = x

[@mark_for_norm]
let as_public #a (#q:qual a{Public? q}) (x:t q)
  : int_t (Public?.sw q)
  = x

[@mark_for_norm]
unfold
let ( + ) #a (#q:qual a) (x:t q) (y:t q{ok (+) (i x) (i y)})
    : Tot (t q)
    = match q with
      | Public s -> as_public x + as_public y
      | Secret l s -> as_secret x `addition` as_secret y

[@mark_for_norm]
unfold
let ( +% ) #a (#q:qual a{norm (Unsigned? (q2s q) /\ width_of_sw (q2s q) <> W128)})
              (x:t q)
              (y:t q)
    : Tot (t q)
    = match q with
      | Public s -> as_public x +% as_public y
      | Secret l s -> as_secret x `addition_mod` as_secret y

let test (x:int) (y:int) = x + y

let two_point_lattice = {
  top = true;
  lub = ( || )
}
let lo : lattice_element two_point_lattice = false
let hi : lattice_element two_point_lattice = true
let test2 (x:t (Secret lo (Unsigned W32))) (y:t (Secret lo (Unsigned W32))) = x +% y
let test3 (x:t (Secret hi (Unsigned W32))) (y:t (Secret lo (Unsigned W32))) = x +% promote y hi
let test4 (x:t (Secret lo (Unsigned W32))) (y:t (Secret hi (Unsigned W32)) { ok ( + ) (i x) (i y) }) = promote x hi + y

let hacl_lattice = {
  top = ();
  lub = (fun _ _ -> ());
}
let s_uint32 = t (Secret #_ #hacl_lattice () (Unsigned W32))
let test5 (x:s_uint32) (y:s_uint32) = x +% y
let test6 (x:s_uint32) (y:s_uint32{ok (+) (i x) (i y)}) = x + y
