module GenericPartialDM4A_2

open FStar.Tactics
open FStar.Calc
open FStar.FunctionalExtensionality
module F = FStar.FunctionalExtensionality
module W = FStar.WellFounded
module T = FStar.Tactics
open FStar.Preorder

// m is a monad.
assume val m (a : Type u#a) : Type u#a
assume val m_return (#a : Type) : a -> m a
assume val m_bind (#a #b : Type) : m a -> (a -> m b) -> m b

// w is an ordered monad
[@@erasable]
assume val w (a : Type u#a) : Type u#(1 + a)
assume val w_return (#a : Type) : a -> w a
assume val w_bind (#a #b : Type) : w a -> (a -> w b) -> w b
assume val stronger : (#a:Type) -> preorder (w a)

let equiv #a (w1 w2 : w a) = w1 `stronger` w2 /\ w2 `stronger` w1

assume val bind_is_monotonic
  (#a #b : Type)
  (w1 w2 : w a) 
  (f1 f2 : a -> w b)
  : Lemma (requires (w1 `stronger` w2 /\ (forall x. f1 x `stronger` f2 x)))
          (ensures (w_bind w1 f1 `stronger` w_bind w2 f2))

let (<<=) = stronger

// a morphism between them, satisfying appropriate laws
assume val interp (#a : Type) : m a -> w a

assume val interp_ret (#a:Type) (x:a)
  : Lemma (interp (m_return x) `equiv` w_return x)
  
assume val interp_bind (#a #b:Type)
  (c : m a) (f : a -> m b)
  : Lemma (interp (m_bind c f) `equiv` w_bind (interp c) (fun x -> interp (f x)))

let repr (a : Type) (w: w a) =
  ( pre : Type0 & (squash pre -> c:(m a){w `stronger` interp c}) )

let return (a:Type) (x:a) : repr a (w_return x) =
  (|True, (fun _ ->
          interp_ret x;
          m_return x) |)

let bind (a : Type) (b : Type)
  (wp_v : w a) (wp_f: (a -> w b))
  (v : repr a wp_v) (f : (x:a -> repr b (wp_f x)))
  : repr b (w_bind wp_v wp_f)
  = let wp = w_bind wp_v wp_f in
    let pre = dfst v /\ (forall x. dfst (f x)) in
    (| pre, (fun (_ : squash pre) ->
               let bm = dsnd v () in
               let bf x = dsnd (f x) () in
               bind_is_monotonic wp_v (interp bm) wp_f (fun x -> interp (bf x));
               interp_bind bm bf;
               m_bind bm bf) |)

let subcomp (a:Type)
  (w1 : w a)
  (w2 : w a)
  (f : repr a w1)
  : Pure (repr a w2)
         (requires (w2 `stronger` w1))
         (ensures fun _ -> True)
  = (| dfst f, dsnd f |)

let if_then_else (a : Type)
  (w1 : w a)
  (w2 : w a)
  (f : repr a w1)
  (g : repr a w2)
  (b : bool)
  : Type
  = repr a (if b then w1 else w2)

total
reifiable
reflectable
layered_effect {
  DM4A : a:Type -> w a -> Effect
  with repr         = repr;
       return       = return;
       bind         = bind;
       subcomp      = subcomp; 
       if_then_else = if_then_else
}

assume val lift_wp : #a:_ -> (wp : pure_wp a) -> w a

(* Some properties on lifting *)
assume val lift_wp_mono : #a:Type -> wp1:pure_wp a -> wp2:pure_wp a ->
  Lemma (requires (forall p. wp1 p ==> wp2 p))
        (ensures lift_wp wp1 `stronger` lift_wp wp2)
assume val lift_ret : #a:Type -> x:a ->
  Lemma (lift_wp (pure_return _ x) <<= w_return x)

let lift_pure_dm4a (a:Type) (wp : pure_wp a) (f:(eqtype_as_type unit -> PURE a wp))
  : Tot (repr a (lift_wp wp))
  = (| wp (fun _ -> True), (fun (_ : squash (wp (fun _ -> True))) ->
                        let x = Common.elim_pure f (fun _ -> True) in
                        assume (Common.pure_monotonic wp);
                        lift_wp_mono wp (pure_return _ x);
                        lift_ret x;
                        interp_ret x;
                        m_return x) |)
  
sub_effect PURE ~> DM4A = lift_pure_dm4a

// needs monotonicity, plus the lemmas above to relate w_return to lift_wp (....)
[@@expect_failure [19]]
let test () : DM4A int (w_return 5) = 5

// but works via this stupid trick
let test_norm () : DM4A int (lift_wp (fun p -> forall rv. rv == 5 ==> p rv)) by (compute ()) = 5