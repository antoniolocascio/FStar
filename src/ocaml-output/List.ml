
let isEmpty = (fun ( _6_18  :  unit ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
true
end
| _ -> begin
false
end))

let isEmptyT = (fun ( _6_18  :  unit ) -> (isEmpty ()))

let hd = (fun ( _6_18  :  unit ) ( _3_1  :  'a list ) -> (match (_3_1) with
| hd::tl -> begin
hd
end
| _ -> begin
(failwith ("head of empty list"))
end))

let tail = (fun ( _6_18  :  unit ) -> (fun ( _3_2  :  'u3u748 list ) -> (match (_3_2) with
| hd::tl -> begin
tl
end
| _ -> begin
(failwith ("tail of empty list"))
end)))

let tl = (fun ( _6_18  :  unit ) -> (tail ()))

let rec length = (fun ( _6_18  :  unit ) ( _3_3  :  'a list ) -> (match (_3_3) with
| [] -> begin
0
end
| _::tl -> begin
(1 + ((length ()) tl))
end))

let lengthT = (fun ( _6_18  :  unit ) -> (length ()))

let rec nth = (fun ( _6_18  :  unit ) ( l  :  'a list ) ( n  :  int ) -> (match ((n < 0)) with
| true -> begin
(failwith ("nth takes a non-negative integer as input"))
end
| false -> begin
(match ((n = 0)) with
| true -> begin
(match (l) with
| [] -> begin
(failwith ("not enough elements"))
end
| hd::_ -> begin
hd
end)
end
| false -> begin
(match (l) with
| [] -> begin
(failwith ("not enough elements"))
end
| _::tl -> begin
((nth ()) tl n)
end)
end)
end))

let rec total_nth = (fun ( _6_18  :  unit ) ( l  :  'a list ) ( n  :  Support.Prims.nat ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((n = 0)) with
| true -> begin
Some (hd)
end
| false -> begin
((total_nth ()) tl (n - 1))
end)
end))

let rec count = (fun ( _6_18  :  unit ) ( x  :  'a ) ( _3_4  :  'a list ) -> (match (_3_4) with
| [] -> begin
0
end
| hd::tl -> begin
(match ((x = hd)) with
| true -> begin
(1 + ((count ()) x tl))
end
| false -> begin
((count ()) x tl)
end)
end))

let countT = (fun ( _6_18  :  unit ) -> (count ()))

let rec rev_acc = (fun ( _6_18  :  unit ) ( l  :  'a list ) ( acc  :  'a list ) -> (match (l) with
| [] -> begin
acc
end
| hd::tl -> begin
((rev_acc ()) tl ((hd)::acc))
end))

let rev_append = (fun ( _6_18  :  unit ) -> (rev_acc ()))

let rev = (fun ( _6_18  :  unit ) ( l  :  'a list ) -> ((rev_acc ()) l []))

let revT = (fun ( _6_18  :  unit ) -> (rev ()))

let rec append = (fun ( _6_18  :  unit ) ( x  :  'a list ) ( y  :  'a list ) -> (match (x) with
| [] -> begin
y
end
| a::tl -> begin
(a)::((append ()) tl y)
end))

let appendT = (fun ( _6_18  :  unit ) -> (append ()))

let rec flatten = (fun ( _6_18  :  unit ) ( l  :  'a list list ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
((append ()) hd ((flatten ()) tl))
end))

let flattenT = (fun ( _6_18  :  unit ) -> (flatten ()))

let concat = (fun ( _6_18  :  unit ) -> (flatten ()))

let concatT = (fun ( _6_18  :  unit ) -> (flattenT ()))

let rec iter = (fun ( _6_18  :  unit ) ( f  :  'a  ->  unit ) ( x  :  'a list ) -> (match (x) with
| [] -> begin
()
end
| a::tl -> begin
(let _3_95 = (f a)
in ((iter ()) f tl))
end))

let rec iterT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  unit ) ( x  :  'a list ) -> ())

let rec map = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b ) ( x  :  'a list ) -> (match (x) with
| [] -> begin
[]
end
| a::tl -> begin
(let _6_1302 = (f a)
in (let _6_1301 = ((map ()) f tl)
in (_6_1302)::_6_1301))
end))

let rec mapT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b ) ( x  :  'a list ) -> (match (x) with
| [] -> begin
[]
end
| a::tl -> begin
((f a))::((mapT ()) f tl)
end))

let rec mapi_init = (fun ( _6_18  :  unit ) ( f  :  int  ->  'a  ->  'b ) ( l  :  'a list ) ( i  :  int ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
(let _6_1318 = (f i hd)
in (let _6_1317 = ((mapi_init ()) f tl (i + 1))
in (_6_1318)::_6_1317))
end))

let rec mapi_initT = (fun ( _6_18  :  unit ) ( f  :  int  ->  'a  ->  'b ) ( l  :  'a list ) ( i  :  int ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
((f i hd))::((mapi_initT ()) f tl (i + 1))
end))

let mapi = (fun ( _6_18  :  unit ) ( f  :  int  ->  'a  ->  'b ) ( l  :  'a list ) -> ((mapi_init ()) f l 0))

let mapiT = (fun ( _6_18  :  unit ) ( f  :  int  ->  'a  ->  'b ) ( l  :  'a list ) -> ((mapi_initT ()) f l 0))

let rec concatMap = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b list ) ( _3_5  :  'a list ) -> (match (_3_5) with
| [] -> begin
[]
end
| a::tl -> begin
(let fa = (f a)
in (let ftl = ((concatMap ()) f tl)
in ((append ()) fa ftl)))
end))

let rec concatMapT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b list ) ( _3_6  :  'a list ) -> (match (_3_6) with
| [] -> begin
[]
end
| a::tl -> begin
(let fa = (f a)
in (let ftl = ((concatMapT ()) f tl)
in ((appendT ()) fa ftl)))
end))

let rec map2 = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'c ) ( l1  :  'a list ) ( l2  :  'b list ) -> (match ((l1, l2)) with
| ([], []) -> begin
[]
end
| (hd1::tl1, hd2::tl2) -> begin
(let _6_1364 = (f hd1 hd2)
in (let _6_1363 = ((map2 ()) f tl1 tl2)
in (_6_1364)::_6_1363))
end
| (_, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec map3 = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'c  ->  'd ) ( l1  :  'a list ) ( l2  :  'b list ) ( l3  :  'c list ) -> (match ((l1, l2, l3)) with
| ([], [], []) -> begin
[]
end
| (hd1::tl1, hd2::tl2, hd3::tl3) -> begin
(let _6_1379 = (f hd1 hd2 hd3)
in (let _6_1378 = ((map3 ()) f tl1 tl2 tl3)
in (_6_1379)::_6_1378))
end
| (_, _, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec fold_left = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'a ) ( x  :  'a ) ( y  :  'b list ) -> (match (y) with
| [] -> begin
x
end
| hd::tl -> begin
(let _6_1389 = (f x hd)
in ((fold_left ()) f _6_1389 tl))
end))

let rec fold_leftT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'a ) ( x  :  'a ) ( y  :  'b list ) -> (match (y) with
| [] -> begin
x
end
| hd::tl -> begin
((fold_leftT ()) f (f x hd) tl)
end))

let rec fold_left2 = (fun ( _6_18  :  unit ) ( f  :  's  ->  'a  ->  'b  ->  's ) ( a  :  's ) ( l1  :  'a list ) ( l2  :  'b list ) -> (match ((l1, l2)) with
| ([], []) -> begin
a
end
| (hd1::tl1, hd2::tl2) -> begin
(let _6_1412 = (f a hd1 hd2)
in ((fold_left2 ()) f _6_1412 tl1 tl2))
end
| (_, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec fold_right = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'b ) ( l  :  'a list ) ( x  :  'b ) -> (match (l) with
| [] -> begin
x
end
| hd::tl -> begin
(let _6_1422 = ((fold_right ()) f tl x)
in (f hd _6_1422))
end))

let rec fold_rightT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  'b ) ( l  :  'a list ) ( x  :  'b ) -> (match (l) with
| [] -> begin
x
end
| hd::tl -> begin
(f hd ((fold_rightT ()) f tl x))
end))

let rec mem = (fun ( _6_18  :  unit ) ( x  :  'a ) ( _3_7  :  'a list ) -> (match (_3_7) with
| [] -> begin
false
end
| hd::tl -> begin
(match ((hd = x)) with
| true -> begin
true
end
| false -> begin
((mem ()) x tl)
end)
end))

let memT = (fun ( _6_18  :  unit ) -> (mem ()))

let contains = (fun ( _6_18  :  unit ) -> (mem ()))

let containsT = (fun ( _6_18  :  unit ) -> (memT ()))

let rec existsb = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
false
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
true
end
| false -> begin
((existsb ()) f tl)
end)
end))

let rec find = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
Some (hd)
end
| false -> begin
((find ()) f tl)
end)
end))

let findT = (fun ( _6_18  :  unit ) -> (find ()))

let rec filter = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( _3_8  :  'a list ) -> (match (_3_8) with
| [] -> begin
[]
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
(let _6_1478 = ((filter ()) f tl)
in (hd)::_6_1478)
end
| false -> begin
((filter ()) f tl)
end)
end))

let rec filterT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( _3_9  :  'a list ) -> (match (_3_9) with
| [] -> begin
[]
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
(hd)::((filterT ()) f tl)
end
| false -> begin
((filterT ()) f tl)
end)
end))

let rec for_all = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
true
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
((for_all ()) f tl)
end
| false -> begin
false
end)
end))

let rec for_allT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
true
end
| hd::tl -> begin
(match ((f hd)) with
| true -> begin
((for_allT ()) f tl)
end
| false -> begin
false
end)
end))

let rec forall2 = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b  ->  bool ) ( l1  :  'a list ) ( l2  :  'b list ) -> (match ((l1, l2)) with
| ([], []) -> begin
true
end
| (hd1::tl1, hd2::tl2) -> begin
(match ((f hd1 hd2)) with
| true -> begin
((forall2 ()) f tl1 tl2)
end
| false -> begin
false
end)
end
| (_, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec collect = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b list ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
(let _6_1517 = (f hd)
in (let _6_1516 = ((collect ()) f tl)
in ((append ()) _6_1517 _6_1516)))
end))

let rec collectT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b list ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
((appendT ()) (f hd) ((collectT ()) f tl))
end))

let rec tryFind = (fun ( _6_18  :  unit ) ( p  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((p hd)) with
| true -> begin
Some (hd)
end
| false -> begin
((tryFind ()) p tl)
end)
end))

let rec tryFindT = (fun ( _6_18  :  unit ) ( p  :  'a  ->  bool ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((p hd)) with
| true -> begin
Some (hd)
end
| false -> begin
((tryFindT ()) p tl)
end)
end))

let rec tryPick = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b option ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((f hd)) with
| Some (x) -> begin
Some (x)
end
| None -> begin
((tryPick ()) f tl)
end)
end))

let rec tryPickT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b option ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
None
end
| hd::tl -> begin
(match ((f hd)) with
| Some (x) -> begin
Some (x)
end
| None -> begin
((tryPickT ()) f tl)
end)
end))

let rec choose = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b option ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
(match ((f hd)) with
| Some (x) -> begin
(let _6_1548 = ((choose ()) f tl)
in (x)::_6_1548)
end
| None -> begin
((choose ()) f tl)
end)
end))

let rec chooseT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'b option ) ( l  :  'a list ) -> (match (l) with
| [] -> begin
[]
end
| hd::tl -> begin
(match ((f hd)) with
| Some (x) -> begin
(x)::((chooseT ()) f tl)
end
| None -> begin
((chooseT ()) f tl)
end)
end))

let rec partition = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( _3_10  :  'a list ) -> (match (_3_10) with
| [] -> begin
([], [])
end
| hd::tl -> begin
(let _3_439 = ((partition ()) f tl)
in (match (_3_439) with
| (l1, l2) -> begin
(match ((f hd)) with
| true -> begin
((hd)::l1, l2)
end
| false -> begin
(l1, (hd)::l2)
end)
end))
end))

let rec partitionT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( _3_11  :  'a list ) -> (match (_3_11) with
| [] -> begin
([], [])
end
| hd::tl -> begin
(let _3_450 = ((partitionT ()) f tl)
in (match (_3_450) with
| (l1, l2) -> begin
(match ((f hd)) with
| true -> begin
((hd)::l1, l2)
end
| false -> begin
(l1, (hd)::l2)
end)
end))
end))

let rec assoc = (fun ( _6_18  :  unit ) ( a  :  'a ) ( x  :  ('a * 'b) list ) -> (match (x) with
| [] -> begin
None
end
| (a', b)::tl -> begin
(match ((a = a')) with
| true -> begin
Some (b)
end
| false -> begin
((assoc ()) a tl)
end)
end))

let assocT = (fun ( _6_18  :  unit ) -> (assoc ()))

let rec split = (fun ( _6_18  :  unit ) ( l  :  ('a * 'b) list ) -> (match (l) with
| [] -> begin
([], [])
end
| (hd1, hd2)::tl -> begin
(let _3_472 = ((split ()) tl)
in (match (_3_472) with
| (tl1, tl2) -> begin
((hd1)::tl1, (hd2)::tl2)
end))
end))

let splitT = (fun ( _6_18  :  unit ) -> (split ()))

let unzip = (fun ( _6_18  :  unit ) -> (split ()))

let unzipT = (fun ( _6_18  :  unit ) -> (splitT ()))

let rec unzip3 = (fun ( _6_18  :  unit ) ( l  :  ('a * 'b * 'c) list ) -> (match (l) with
| [] -> begin
([], [], [])
end
| (hd1, hd2, hd3)::tl -> begin
(let _3_487 = ((unzip3 ()) tl)
in (match (_3_487) with
| (tl1, tl2, tl3) -> begin
((hd1)::tl1, (hd2)::tl2, (hd3)::tl3)
end))
end))

let unzip3T = (fun ( _6_18  :  unit ) -> (unzip3 ()))

let rec zip = (fun ( _6_18  :  unit ) ( l1  :  'a list ) ( l2  :  'b list ) -> (match ((l1, l2)) with
| ([], []) -> begin
[]
end
| (hd1::tl1, hd2::tl2) -> begin
(let _6_1576 = ((zip ()) tl1 tl2)
in ((hd1, hd2))::_6_1576)
end
| (_, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec zip3 = (fun ( _6_18  :  unit ) ( l1  :  'a list ) ( l2  :  'b list ) ( l3  :  'c list ) -> (match ((l1, l2, l3)) with
| ([], [], []) -> begin
[]
end
| (hd1::tl1, hd2::tl2, hd3::tl3) -> begin
(let _6_1580 = ((zip3 ()) tl1 tl2 tl3)
in ((hd1, hd2, hd3))::_6_1580)
end
| (_, _, _) -> begin
(failwith ("The lists do not have the same length"))
end))

let rec sortWith = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'a  ->  int ) ( _3_12  :  'a list ) -> (match (_3_12) with
| [] -> begin
[]
end
| pivot::tl -> begin
(let _3_544 = ((partition ()) (fun ( x  :  'a ) -> (let _6_1590 = (f pivot x)
in (_6_1590 > 0))) tl)
in (match (_3_544) with
| (hi, lo) -> begin
(let _6_1593 = ((sortWith ()) f lo)
in (let _6_1592 = (let _6_1591 = ((sortWith ()) f hi)
in (pivot)::_6_1591)
in ((append ()) _6_1593 _6_1592)))
end))
end))

let rec partition_length = (fun ( _6_18  :  unit ) ( f  :  'a  ->  bool ) ( l  :  'a list ) -> ())

let bool_of_compare = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'a  ->  int ) ( x  :  'a ) ( y  :  'a ) -> ((f x y) >= 0))

let rec sortWithT = (fun ( _6_18  :  unit ) ( f  :  'a  ->  'a  ->  int ) ( _3_13  :  'a list ) -> (match (_3_13) with
| [] -> begin
[]
end
| pivot::tl -> begin
(let _3_568 = ((partitionT ()) ((bool_of_compare ()) f pivot) tl)
in (match (_3_568) with
| (hi, lo) -> begin
(let _3_569 = ()
in ((append ()) ((sortWithT ()) f lo) ((pivot)::((sortWithT ()) f hi))))
end))
end))




