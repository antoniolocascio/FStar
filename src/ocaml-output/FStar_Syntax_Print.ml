
open Prims
open FStar_Pervasives

let rec delta_depth_to_string : FStar_Syntax_Syntax.delta_depth  ->  Prims.string = (fun uu___0_5 -> (match (uu___0_5) with
| FStar_Syntax_Syntax.Delta_constant_at_level (i) -> begin
(

let uu____9 = (FStar_Util.string_of_int i)
in (Prims.op_Hat "Delta_constant_at_level " uu____9))
end
| FStar_Syntax_Syntax.Delta_equational_at_level (i) -> begin
(

let uu____14 = (FStar_Util.string_of_int i)
in (Prims.op_Hat "Delta_equational_at_level " uu____14))
end
| FStar_Syntax_Syntax.Delta_abstract (d) -> begin
(

let uu____18 = (

let uu____20 = (delta_depth_to_string d)
in (Prims.op_Hat uu____20 ")"))
in (Prims.op_Hat "Delta_abstract (" uu____18))
end))


let sli : FStar_Ident.lident  ->  Prims.string = (fun l -> (

let uu____32 = (FStar_Options.print_real_names ())
in (match (uu____32) with
| true -> begin
l.FStar_Ident.str
end
| uu____36 -> begin
l.FStar_Ident.ident.FStar_Ident.idText
end)))


let lid_to_string : FStar_Ident.lid  ->  Prims.string = (fun l -> (sli l))


let fv_to_string : FStar_Syntax_Syntax.fv  ->  Prims.string = (fun fv -> (lid_to_string fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v))


let bv_to_string : FStar_Syntax_Syntax.bv  ->  Prims.string = (fun bv -> (

let uu____59 = (

let uu____61 = (FStar_Util.string_of_int bv.FStar_Syntax_Syntax.index)
in (Prims.op_Hat "#" uu____61))
in (Prims.op_Hat bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText uu____59)))


let nm_to_string : FStar_Syntax_Syntax.bv  ->  Prims.string = (fun bv -> (

let uu____71 = (FStar_Options.print_real_names ())
in (match (uu____71) with
| true -> begin
(bv_to_string bv)
end
| uu____75 -> begin
bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText
end)))


let db_to_string : FStar_Syntax_Syntax.bv  ->  Prims.string = (fun bv -> (

let uu____84 = (

let uu____86 = (FStar_Util.string_of_int bv.FStar_Syntax_Syntax.index)
in (Prims.op_Hat "@" uu____86))
in (Prims.op_Hat bv.FStar_Syntax_Syntax.ppname.FStar_Ident.idText uu____84)))


let infix_prim_ops : (FStar_Ident.lident * Prims.string) Prims.list = (((FStar_Parser_Const.op_Addition), ("+")))::(((FStar_Parser_Const.op_Subtraction), ("-")))::(((FStar_Parser_Const.op_Multiply), ("*")))::(((FStar_Parser_Const.op_Division), ("/")))::(((FStar_Parser_Const.op_Eq), ("=")))::(((FStar_Parser_Const.op_ColonEq), (":=")))::(((FStar_Parser_Const.op_notEq), ("<>")))::(((FStar_Parser_Const.op_And), ("&&")))::(((FStar_Parser_Const.op_Or), ("||")))::(((FStar_Parser_Const.op_LTE), ("<=")))::(((FStar_Parser_Const.op_GTE), (">=")))::(((FStar_Parser_Const.op_LT), ("<")))::(((FStar_Parser_Const.op_GT), (">")))::(((FStar_Parser_Const.op_Modulus), ("mod")))::(((FStar_Parser_Const.and_lid), ("/\\")))::(((FStar_Parser_Const.or_lid), ("\\/")))::(((FStar_Parser_Const.imp_lid), ("==>")))::(((FStar_Parser_Const.iff_lid), ("<==>")))::(((FStar_Parser_Const.precedes_lid), ("<<")))::(((FStar_Parser_Const.eq2_lid), ("==")))::(((FStar_Parser_Const.eq3_lid), ("===")))::[]


let unary_prim_ops : (FStar_Ident.lident * Prims.string) Prims.list = (((FStar_Parser_Const.op_Negation), ("not")))::(((FStar_Parser_Const.op_Minus), ("-")))::(((FStar_Parser_Const.not_lid), ("~")))::[]


let is_prim_op : FStar_Ident.lident Prims.list  ->  FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  Prims.bool = (fun ps f -> (match (f.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
(FStar_All.pipe_right ps (FStar_Util.for_some (FStar_Syntax_Syntax.fv_eq_lid fv)))
end
| uu____308 -> begin
false
end))


let get_lid : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  FStar_Ident.lident = (fun f -> (match (f.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_fvar (fv) -> begin
fv.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v
end
| uu____321 -> begin
(failwith "get_lid")
end))


let is_infix_prim_op : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun e -> (is_prim_op (FStar_Pervasives_Native.fst (FStar_List.split infix_prim_ops)) e))


let is_unary_prim_op : FStar_Syntax_Syntax.term  ->  Prims.bool = (fun e -> (is_prim_op (FStar_Pervasives_Native.fst (FStar_List.split unary_prim_ops)) e))


let quants : (FStar_Ident.lident * Prims.string) Prims.list = (((FStar_Parser_Const.forall_lid), ("forall")))::(((FStar_Parser_Const.exists_lid), ("exists")))::[]


type exp =
FStar_Syntax_Syntax.term


let is_b2t : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (is_prim_op ((FStar_Parser_Const.b2t_lid)::[]) t))


let is_quant : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (is_prim_op (FStar_Pervasives_Native.fst (FStar_List.split quants)) t))


let is_ite : FStar_Syntax_Syntax.typ  ->  Prims.bool = (fun t -> (is_prim_op ((FStar_Parser_Const.ite_lid)::[]) t))


let is_lex_cons : exp  ->  Prims.bool = (fun f -> (is_prim_op ((FStar_Parser_Const.lexcons_lid)::[]) f))


let is_lex_top : exp  ->  Prims.bool = (fun f -> (is_prim_op ((FStar_Parser_Const.lextop_lid)::[]) f))


let is_inr : 'Auu____424 'Auu____425 . ('Auu____424, 'Auu____425) FStar_Util.either  ->  Prims.bool = (fun uu___1_435 -> (match (uu___1_435) with
| FStar_Util.Inl (uu____440) -> begin
false
end
| FStar_Util.Inr (uu____442) -> begin
true
end))


let filter_imp : 'Auu____449 . ('Auu____449 * FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option) Prims.list  ->  ('Auu____449 * FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option) Prims.list = (fun a -> (FStar_All.pipe_right a (FStar_List.filter (fun uu___2_504 -> (match (uu___2_504) with
| (uu____512, FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta (t))) when (FStar_Syntax_Util.is_fvar FStar_Parser_Const.tcresolve_lid t) -> begin
true
end
| (uu____519, FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit (uu____520))) -> begin
false
end
| (uu____525, FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta (uu____526))) -> begin
false
end
| uu____532 -> begin
true
end)))))


let rec reconstruct_lex : exp  ->  exp Prims.list FStar_Pervasives_Native.option = (fun e -> (

let uu____550 = (

let uu____551 = (FStar_Syntax_Subst.compress e)
in uu____551.FStar_Syntax_Syntax.n)
in (match (uu____550) with
| FStar_Syntax_Syntax.Tm_app (f, args) -> begin
(

let args1 = (filter_imp args)
in (

let exps = (FStar_List.map FStar_Pervasives_Native.fst args1)
in (

let uu____612 = ((is_lex_cons f) && (Prims.op_Equality (FStar_List.length exps) (Prims.parse_int "2")))
in (match (uu____612) with
| true -> begin
(

let uu____621 = (

let uu____626 = (FStar_List.nth exps (Prims.parse_int "1"))
in (reconstruct_lex uu____626))
in (match (uu____621) with
| FStar_Pervasives_Native.Some (xs) -> begin
(

let uu____637 = (

let uu____640 = (FStar_List.nth exps (Prims.parse_int "0"))
in (uu____640)::xs)
in FStar_Pervasives_Native.Some (uu____637))
end
| FStar_Pervasives_Native.None -> begin
FStar_Pervasives_Native.None
end))
end
| uu____648 -> begin
FStar_Pervasives_Native.None
end))))
end
| uu____652 -> begin
(

let uu____653 = (is_lex_top e)
in (match (uu____653) with
| true -> begin
FStar_Pervasives_Native.Some ([])
end
| uu____662 -> begin
FStar_Pervasives_Native.None
end))
end)))


let rec find : 'a . ('a  ->  Prims.bool)  ->  'a Prims.list  ->  'a = (fun f l -> (match (l) with
| [] -> begin
(failwith "blah")
end
| (hd1)::tl1 -> begin
(

let uu____701 = (f hd1)
in (match (uu____701) with
| true -> begin
hd1
end
| uu____704 -> begin
(find f tl1)
end))
end))


let find_lid : FStar_Ident.lident  ->  (FStar_Ident.lident * Prims.string) Prims.list  ->  Prims.string = (fun x xs -> (

let uu____733 = (find (fun p -> (FStar_Ident.lid_equals x (FStar_Pervasives_Native.fst p))) xs)
in (FStar_Pervasives_Native.snd uu____733)))


let infix_prim_op_to_string : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  Prims.string = (fun e -> (

let uu____764 = (get_lid e)
in (find_lid uu____764 infix_prim_ops)))


let unary_prim_op_to_string : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  Prims.string = (fun e -> (

let uu____776 = (get_lid e)
in (find_lid uu____776 unary_prim_ops)))


let quant_to_string : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  Prims.string = (fun t -> (

let uu____788 = (get_lid t)
in (find_lid uu____788 quants)))


let const_to_string : FStar_Const.sconst  ->  Prims.string = (fun x -> (FStar_Parser_Const.const_to_string x))


let lbname_to_string : FStar_Syntax_Syntax.lbname  ->  Prims.string = (fun uu___3_802 -> (match (uu___3_802) with
| FStar_Util.Inl (l) -> begin
(bv_to_string l)
end
| FStar_Util.Inr (l) -> begin
(lid_to_string l.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
end))


let uvar_to_string : FStar_Syntax_Syntax.uvar  ->  Prims.string = (fun u -> (

let uu____813 = (FStar_Options.hide_uvar_nums ())
in (match (uu____813) with
| true -> begin
"?"
end
| uu____818 -> begin
(

let uu____820 = (

let uu____822 = (FStar_Syntax_Unionfind.uvar_id u)
in (FStar_All.pipe_right uu____822 FStar_Util.string_of_int))
in (Prims.op_Hat "?" uu____820))
end)))


let version_to_string : FStar_Syntax_Syntax.version  ->  Prims.string = (fun v1 -> (

let uu____834 = (FStar_Util.string_of_int v1.FStar_Syntax_Syntax.major)
in (

let uu____836 = (FStar_Util.string_of_int v1.FStar_Syntax_Syntax.minor)
in (FStar_Util.format2 "%s.%s" uu____834 uu____836))))


let univ_uvar_to_string : (FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option FStar_Unionfind.p_uvar * FStar_Syntax_Syntax.version)  ->  Prims.string = (fun u -> (

let uu____862 = (FStar_Options.hide_uvar_nums ())
in (match (uu____862) with
| true -> begin
"?"
end
| uu____867 -> begin
(

let uu____869 = (

let uu____871 = (

let uu____873 = (FStar_Syntax_Unionfind.univ_uvar_id u)
in (FStar_All.pipe_right uu____873 FStar_Util.string_of_int))
in (

let uu____877 = (

let uu____879 = (version_to_string (FStar_Pervasives_Native.snd u))
in (Prims.op_Hat ":" uu____879))
in (Prims.op_Hat uu____871 uu____877)))
in (Prims.op_Hat "?" uu____869))
end)))


let rec int_of_univ : Prims.int  ->  FStar_Syntax_Syntax.universe  ->  (Prims.int * FStar_Syntax_Syntax.universe FStar_Pervasives_Native.option) = (fun n1 u -> (

let uu____907 = (FStar_Syntax_Subst.compress_univ u)
in (match (uu____907) with
| FStar_Syntax_Syntax.U_zero -> begin
((n1), (FStar_Pervasives_Native.None))
end
| FStar_Syntax_Syntax.U_succ (u1) -> begin
(int_of_univ (n1 + (Prims.parse_int "1")) u1)
end
| uu____920 -> begin
((n1), (FStar_Pervasives_Native.Some (u)))
end)))


let rec univ_to_string : FStar_Syntax_Syntax.universe  ->  Prims.string = (fun u -> (

let uu____931 = (FStar_Syntax_Subst.compress_univ u)
in (match (uu____931) with
| FStar_Syntax_Syntax.U_unif (u1) -> begin
(

let uu____942 = (univ_uvar_to_string u1)
in (Prims.op_Hat "U_unif " uu____942))
end
| FStar_Syntax_Syntax.U_name (x) -> begin
(Prims.op_Hat "U_name " x.FStar_Ident.idText)
end
| FStar_Syntax_Syntax.U_bvar (x) -> begin
(

let uu____949 = (FStar_Util.string_of_int x)
in (Prims.op_Hat "@" uu____949))
end
| FStar_Syntax_Syntax.U_zero -> begin
"0"
end
| FStar_Syntax_Syntax.U_succ (u1) -> begin
(

let uu____954 = (int_of_univ (Prims.parse_int "1") u1)
in (match (uu____954) with
| (n1, FStar_Pervasives_Native.None) -> begin
(FStar_Util.string_of_int n1)
end
| (n1, FStar_Pervasives_Native.Some (u2)) -> begin
(

let uu____975 = (univ_to_string u2)
in (

let uu____977 = (FStar_Util.string_of_int n1)
in (FStar_Util.format2 "(%s + %s)" uu____975 uu____977)))
end))
end
| FStar_Syntax_Syntax.U_max (us) -> begin
(

let uu____983 = (

let uu____985 = (FStar_List.map univ_to_string us)
in (FStar_All.pipe_right uu____985 (FStar_String.concat ", ")))
in (FStar_Util.format1 "(max %s)" uu____983))
end
| FStar_Syntax_Syntax.U_unknown -> begin
"unknown"
end)))


let univs_to_string : FStar_Syntax_Syntax.universes  ->  Prims.string = (fun us -> (

let uu____1004 = (FStar_List.map univ_to_string us)
in (FStar_All.pipe_right uu____1004 (FStar_String.concat ", "))))


let univ_names_to_string : FStar_Syntax_Syntax.univ_names  ->  Prims.string = (fun us -> (

let uu____1021 = (FStar_List.map (fun x -> x.FStar_Ident.idText) us)
in (FStar_All.pipe_right uu____1021 (FStar_String.concat ", "))))


let qual_to_string : FStar_Syntax_Syntax.qualifier  ->  Prims.string = (fun uu___4_1039 -> (match (uu___4_1039) with
| FStar_Syntax_Syntax.Assumption -> begin
"assume"
end
| FStar_Syntax_Syntax.New -> begin
"new"
end
| FStar_Syntax_Syntax.Private -> begin
"private"
end
| FStar_Syntax_Syntax.Unfold_for_unification_and_vcgen -> begin
"unfold"
end
| FStar_Syntax_Syntax.Inline_for_extraction -> begin
"inline"
end
| FStar_Syntax_Syntax.NoExtract -> begin
"noextract"
end
| FStar_Syntax_Syntax.Visible_default -> begin
"visible"
end
| FStar_Syntax_Syntax.Irreducible -> begin
"irreducible"
end
| FStar_Syntax_Syntax.Abstract -> begin
"abstract"
end
| FStar_Syntax_Syntax.Noeq -> begin
"noeq"
end
| FStar_Syntax_Syntax.Unopteq -> begin
"unopteq"
end
| FStar_Syntax_Syntax.Logic -> begin
"logic"
end
| FStar_Syntax_Syntax.TotalEffect -> begin
"total"
end
| FStar_Syntax_Syntax.Discriminator (l) -> begin
(

let uu____1055 = (lid_to_string l)
in (FStar_Util.format1 "(Discriminator %s)" uu____1055))
end
| FStar_Syntax_Syntax.Projector (l, x) -> begin
(

let uu____1060 = (lid_to_string l)
in (FStar_Util.format2 "(Projector %s %s)" uu____1060 x.FStar_Ident.idText))
end
| FStar_Syntax_Syntax.RecordType (ns, fns) -> begin
(

let uu____1073 = (

let uu____1075 = (FStar_Ident.path_of_ns ns)
in (FStar_Ident.text_of_path uu____1075))
in (

let uu____1076 = (

let uu____1078 = (FStar_All.pipe_right fns (FStar_List.map FStar_Ident.text_of_id))
in (FStar_All.pipe_right uu____1078 (FStar_String.concat ", ")))
in (FStar_Util.format2 "(RecordType %s %s)" uu____1073 uu____1076)))
end
| FStar_Syntax_Syntax.RecordConstructor (ns, fns) -> begin
(

let uu____1104 = (

let uu____1106 = (FStar_Ident.path_of_ns ns)
in (FStar_Ident.text_of_path uu____1106))
in (

let uu____1107 = (

let uu____1109 = (FStar_All.pipe_right fns (FStar_List.map FStar_Ident.text_of_id))
in (FStar_All.pipe_right uu____1109 (FStar_String.concat ", ")))
in (FStar_Util.format2 "(RecordConstructor %s %s)" uu____1104 uu____1107)))
end
| FStar_Syntax_Syntax.Action (eff_lid) -> begin
(

let uu____1126 = (lid_to_string eff_lid)
in (FStar_Util.format1 "(Action %s)" uu____1126))
end
| FStar_Syntax_Syntax.ExceptionConstructor -> begin
"ExceptionConstructor"
end
| FStar_Syntax_Syntax.HasMaskedEffect -> begin
"HasMaskedEffect"
end
| FStar_Syntax_Syntax.Effect -> begin
"Effect"
end
| FStar_Syntax_Syntax.Reifiable -> begin
"reify"
end
| FStar_Syntax_Syntax.Reflectable (l) -> begin
(FStar_Util.format1 "(reflect %s)" l.FStar_Ident.str)
end
| FStar_Syntax_Syntax.OnlyName -> begin
"OnlyName"
end))


let quals_to_string : FStar_Syntax_Syntax.qualifier Prims.list  ->  Prims.string = (fun quals -> (match (quals) with
| [] -> begin
""
end
| uu____1149 -> begin
(

let uu____1152 = (FStar_All.pipe_right quals (FStar_List.map qual_to_string))
in (FStar_All.pipe_right uu____1152 (FStar_String.concat " ")))
end))


let quals_to_string' : FStar_Syntax_Syntax.qualifier Prims.list  ->  Prims.string = (fun quals -> (match (quals) with
| [] -> begin
""
end
| uu____1180 -> begin
(

let uu____1183 = (quals_to_string quals)
in (Prims.op_Hat uu____1183 " "))
end))


let paren : Prims.string  ->  Prims.string = (fun s -> (Prims.op_Hat "(" (Prims.op_Hat s ")")))


let rec tag_of_term : FStar_Syntax_Syntax.term  ->  Prims.string = (fun t -> (match (t.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_bvar (x) -> begin
(

let uu____1365 = (db_to_string x)
in (Prims.op_Hat "Tm_bvar: " uu____1365))
end
| FStar_Syntax_Syntax.Tm_name (x) -> begin
(

let uu____1369 = (nm_to_string x)
in (Prims.op_Hat "Tm_name: " uu____1369))
end
| FStar_Syntax_Syntax.Tm_fvar (x) -> begin
(

let uu____1373 = (lid_to_string x.FStar_Syntax_Syntax.fv_name.FStar_Syntax_Syntax.v)
in (Prims.op_Hat "Tm_fvar: " uu____1373))
end
| FStar_Syntax_Syntax.Tm_uinst (uu____1376) -> begin
"Tm_uinst"
end
| FStar_Syntax_Syntax.Tm_constant (uu____1384) -> begin
"Tm_constant"
end
| FStar_Syntax_Syntax.Tm_type (uu____1386) -> begin
"Tm_type"
end
| FStar_Syntax_Syntax.Tm_quoted (uu____1388, {FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_static; FStar_Syntax_Syntax.antiquotes = uu____1389}) -> begin
"Tm_quoted (static)"
end
| FStar_Syntax_Syntax.Tm_quoted (uu____1403, {FStar_Syntax_Syntax.qkind = FStar_Syntax_Syntax.Quote_dynamic; FStar_Syntax_Syntax.antiquotes = uu____1404}) -> begin
"Tm_quoted (dynamic)"
end
| FStar_Syntax_Syntax.Tm_abs (uu____1418) -> begin
"Tm_abs"
end
| FStar_Syntax_Syntax.Tm_arrow (uu____1438) -> begin
"Tm_arrow"
end
| FStar_Syntax_Syntax.Tm_refine (uu____1454) -> begin
"Tm_refine"
end
| FStar_Syntax_Syntax.Tm_app (uu____1462) -> begin
"Tm_app"
end
| FStar_Syntax_Syntax.Tm_match (uu____1480) -> begin
"Tm_match"
end
| FStar_Syntax_Syntax.Tm_ascribed (uu____1504) -> begin
"Tm_ascribed"
end
| FStar_Syntax_Syntax.Tm_let (uu____1532) -> begin
"Tm_let"
end
| FStar_Syntax_Syntax.Tm_uvar (uu____1547) -> begin
"Tm_uvar"
end
| FStar_Syntax_Syntax.Tm_delayed (uu____1561, m) -> begin
(

let uu____1599 = (FStar_ST.op_Bang m)
in (match (uu____1599) with
| FStar_Pervasives_Native.None -> begin
"Tm_delayed"
end
| FStar_Pervasives_Native.Some (uu____1635) -> begin
"Tm_delayed-resolved"
end))
end
| FStar_Syntax_Syntax.Tm_meta (uu____1641, m) -> begin
(

let uu____1647 = (metadata_to_string m)
in (Prims.op_Hat "Tm_meta:" uu____1647))
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
"Tm_unknown"
end
| FStar_Syntax_Syntax.Tm_lazy (uu____1651) -> begin
"Tm_lazy"
end))
and term_to_string : FStar_Syntax_Syntax.term  ->  Prims.string = (fun x -> (

let uu____1654 = (

let uu____1656 = (FStar_Options.ugly ())
in (not (uu____1656)))
in (match (uu____1654) with
| true -> begin
(

let e = (FStar_Syntax_Resugar.resugar_term x)
in (

let d = (FStar_Parser_ToDocument.term_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d)))
end
| uu____1664 -> begin
(

let x1 = (FStar_Syntax_Subst.compress x)
in (

let x2 = (

let uu____1670 = (FStar_Options.print_implicits ())
in (match (uu____1670) with
| true -> begin
x1
end
| uu____1675 -> begin
(FStar_Syntax_Util.unmeta x1)
end))
in (match (x2.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Tm_delayed (uu____1678) -> begin
(failwith "impossible")
end
| FStar_Syntax_Syntax.Tm_app (uu____1703, []) -> begin
(failwith "Empty args!")
end
| FStar_Syntax_Syntax.Tm_lazy ({FStar_Syntax_Syntax.blob = b; FStar_Syntax_Syntax.lkind = FStar_Syntax_Syntax.Lazy_embedding (uu____1729, thunk1); FStar_Syntax_Syntax.ltyp = uu____1731; FStar_Syntax_Syntax.rng = uu____1732}) -> begin
(

let uu____1743 = (

let uu____1745 = (

let uu____1747 = (FStar_Thunk.force thunk1)
in (term_to_string uu____1747))
in (Prims.op_Hat uu____1745 "]"))
in (Prims.op_Hat "[LAZYEMB:" uu____1743))
end
| FStar_Syntax_Syntax.Tm_lazy (i) -> begin
(

let uu____1753 = (

let uu____1755 = (

let uu____1757 = (

let uu____1758 = (

let uu____1767 = (FStar_ST.op_Bang FStar_Syntax_Syntax.lazy_chooser)
in (FStar_Util.must uu____1767))
in (uu____1758 i.FStar_Syntax_Syntax.lkind i))
in (term_to_string uu____1757))
in (Prims.op_Hat uu____1755 "]"))
in (Prims.op_Hat "[lazy:" uu____1753))
end
| FStar_Syntax_Syntax.Tm_quoted (tm, qi) -> begin
(match (qi.FStar_Syntax_Syntax.qkind) with
| FStar_Syntax_Syntax.Quote_static -> begin
(

let print_aq = (fun uu____1836 -> (match (uu____1836) with
| (bv, t) -> begin
(

let uu____1844 = (bv_to_string bv)
in (

let uu____1846 = (term_to_string t)
in (FStar_Util.format2 "%s -> %s" uu____1844 uu____1846)))
end))
in (

let uu____1849 = (term_to_string tm)
in (

let uu____1851 = (FStar_Common.string_of_list print_aq qi.FStar_Syntax_Syntax.antiquotes)
in (FStar_Util.format2 "`(%s)%s" uu____1849 uu____1851))))
end
| FStar_Syntax_Syntax.Quote_dynamic -> begin
(

let uu____1860 = (term_to_string tm)
in (FStar_Util.format1 "quote (%s)" uu____1860))
end)
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_pattern (uu____1864, ps)) -> begin
(

let pats = (

let uu____1904 = (FStar_All.pipe_right ps (FStar_List.map (fun args -> (

let uu____1941 = (FStar_All.pipe_right args (FStar_List.map (fun uu____1966 -> (match (uu____1966) with
| (t1, uu____1975) -> begin
(term_to_string t1)
end))))
in (FStar_All.pipe_right uu____1941 (FStar_String.concat "; "))))))
in (FStar_All.pipe_right uu____1904 (FStar_String.concat "\\/")))
in (

let uu____1990 = (term_to_string t)
in (FStar_Util.format2 "{:pattern %s} %s" pats uu____1990)))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_monadic (m, t')) -> begin
(

let uu____2004 = (tag_of_term t)
in (

let uu____2006 = (sli m)
in (

let uu____2008 = (term_to_string t')
in (

let uu____2010 = (term_to_string t)
in (FStar_Util.format4 "(Monadic-%s{%s %s} %s)" uu____2004 uu____2006 uu____2008 uu____2010)))))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_monadic_lift (m0, m1, t')) -> begin
(

let uu____2025 = (tag_of_term t)
in (

let uu____2027 = (term_to_string t')
in (

let uu____2029 = (sli m0)
in (

let uu____2031 = (sli m1)
in (

let uu____2033 = (term_to_string t)
in (FStar_Util.format5 "(MonadicLift-%s{%s : %s -> %s} %s)" uu____2025 uu____2027 uu____2029 uu____2031 uu____2033))))))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_labeled (l, r, b)) -> begin
(

let uu____2048 = (FStar_Range.string_of_range r)
in (

let uu____2050 = (term_to_string t)
in (FStar_Util.format3 "Meta_labeled(%s, %s){%s}" l uu____2048 uu____2050)))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_named (l)) -> begin
(

let uu____2059 = (lid_to_string l)
in (

let uu____2061 = (FStar_Range.string_of_range t.FStar_Syntax_Syntax.pos)
in (

let uu____2063 = (term_to_string t)
in (FStar_Util.format3 "Meta_named(%s, %s){%s}" uu____2059 uu____2061 uu____2063))))
end
| FStar_Syntax_Syntax.Tm_meta (t, FStar_Syntax_Syntax.Meta_desugared (uu____2067)) -> begin
(

let uu____2072 = (term_to_string t)
in (FStar_Util.format1 "Meta_desugared{%s}" uu____2072))
end
| FStar_Syntax_Syntax.Tm_bvar (x3) -> begin
(

let uu____2076 = (db_to_string x3)
in (

let uu____2078 = (

let uu____2080 = (

let uu____2082 = (tag_of_term x3.FStar_Syntax_Syntax.sort)
in (Prims.op_Hat uu____2082 ")"))
in (Prims.op_Hat ":(" uu____2080))
in (Prims.op_Hat uu____2076 uu____2078)))
end
| FStar_Syntax_Syntax.Tm_name (x3) -> begin
(nm_to_string x3)
end
| FStar_Syntax_Syntax.Tm_fvar (f) -> begin
(fv_to_string f)
end
| FStar_Syntax_Syntax.Tm_uvar (u, ([], uu____2089)) -> begin
(

let uu____2104 = ((FStar_Options.print_bound_var_types ()) && (FStar_Options.print_effect_args ()))
in (match (uu____2104) with
| true -> begin
(ctx_uvar_to_string u)
end
| uu____2108 -> begin
(

let uu____2110 = (

let uu____2112 = (FStar_Syntax_Unionfind.uvar_id u.FStar_Syntax_Syntax.ctx_uvar_head)
in (FStar_All.pipe_left FStar_Util.string_of_int uu____2112))
in (Prims.op_Hat "?" uu____2110))
end))
end
| FStar_Syntax_Syntax.Tm_uvar (u, s) -> begin
(

let uu____2135 = ((FStar_Options.print_bound_var_types ()) && (FStar_Options.print_effect_args ()))
in (match (uu____2135) with
| true -> begin
(

let uu____2139 = (ctx_uvar_to_string u)
in (

let uu____2141 = (

let uu____2143 = (FStar_List.map subst_to_string (FStar_Pervasives_Native.fst s))
in (FStar_All.pipe_right uu____2143 (FStar_String.concat "; ")))
in (FStar_Util.format2 "(%s @ %s)" uu____2139 uu____2141)))
end
| uu____2160 -> begin
(

let uu____2162 = (

let uu____2164 = (FStar_Syntax_Unionfind.uvar_id u.FStar_Syntax_Syntax.ctx_uvar_head)
in (FStar_All.pipe_left FStar_Util.string_of_int uu____2164))
in (Prims.op_Hat "?" uu____2162))
end))
end
| FStar_Syntax_Syntax.Tm_constant (c) -> begin
(const_to_string c)
end
| FStar_Syntax_Syntax.Tm_type (u) -> begin
(

let uu____2171 = (FStar_Options.print_universes ())
in (match (uu____2171) with
| true -> begin
(

let uu____2175 = (univ_to_string u)
in (FStar_Util.format1 "Type u#(%s)" uu____2175))
end
| uu____2178 -> begin
"Type"
end))
end
| FStar_Syntax_Syntax.Tm_arrow (bs, c) -> begin
(

let uu____2203 = (binders_to_string " -> " bs)
in (

let uu____2206 = (comp_to_string c)
in (FStar_Util.format2 "(%s -> %s)" uu____2203 uu____2206)))
end
| FStar_Syntax_Syntax.Tm_abs (bs, t2, lc) -> begin
(match (lc) with
| FStar_Pervasives_Native.Some (rc) when (FStar_Options.print_implicits ()) -> begin
(

let uu____2238 = (binders_to_string " " bs)
in (

let uu____2241 = (term_to_string t2)
in (

let uu____2243 = (match ((FStar_Option.isNone rc.FStar_Syntax_Syntax.residual_typ)) with
| true -> begin
"None"
end
| uu____2250 -> begin
(

let uu____2252 = (FStar_Option.get rc.FStar_Syntax_Syntax.residual_typ)
in (term_to_string uu____2252))
end)
in (FStar_Util.format4 "(fun %s -> (%s $$ (residual) %s %s))" uu____2238 uu____2241 rc.FStar_Syntax_Syntax.residual_effect.FStar_Ident.str uu____2243))))
end
| uu____2256 -> begin
(

let uu____2259 = (binders_to_string " " bs)
in (

let uu____2262 = (term_to_string t2)
in (FStar_Util.format2 "(fun %s -> %s)" uu____2259 uu____2262)))
end)
end
| FStar_Syntax_Syntax.Tm_refine (xt, f) -> begin
(

let uu____2271 = (bv_to_string xt)
in (

let uu____2273 = (FStar_All.pipe_right xt.FStar_Syntax_Syntax.sort term_to_string)
in (

let uu____2276 = (FStar_All.pipe_right f formula_to_string)
in (FStar_Util.format3 "(%s:%s{%s})" uu____2271 uu____2273 uu____2276))))
end
| FStar_Syntax_Syntax.Tm_app (t, args) -> begin
(

let uu____2308 = (term_to_string t)
in (

let uu____2310 = (args_to_string args)
in (FStar_Util.format2 "(%s %s)" uu____2308 uu____2310)))
end
| FStar_Syntax_Syntax.Tm_let (lbs, e) -> begin
(

let uu____2333 = (lbs_to_string [] lbs)
in (

let uu____2335 = (term_to_string e)
in (FStar_Util.format2 "%s\nin\n%s" uu____2333 uu____2335)))
end
| FStar_Syntax_Syntax.Tm_ascribed (e, (annot, topt), eff_name) -> begin
(

let annot1 = (match (annot) with
| FStar_Util.Inl (t) -> begin
(

let uu____2400 = (

let uu____2402 = (FStar_Util.map_opt eff_name FStar_Ident.text_of_lid)
in (FStar_All.pipe_right uu____2402 (FStar_Util.dflt "default")))
in (

let uu____2413 = (term_to_string t)
in (FStar_Util.format2 "[%s] %s" uu____2400 uu____2413)))
end
| FStar_Util.Inr (c) -> begin
(comp_to_string c)
end)
in (

let topt1 = (match (topt) with
| FStar_Pervasives_Native.None -> begin
""
end
| FStar_Pervasives_Native.Some (t) -> begin
(

let uu____2434 = (term_to_string t)
in (FStar_Util.format1 "by %s" uu____2434))
end)
in (

let uu____2437 = (term_to_string e)
in (FStar_Util.format3 "(%s <ascribed: %s %s)" uu____2437 annot1 topt1))))
end
| FStar_Syntax_Syntax.Tm_match (head1, branches) -> begin
(

let uu____2478 = (term_to_string head1)
in (

let uu____2480 = (

let uu____2482 = (FStar_All.pipe_right branches (FStar_List.map branch_to_string))
in (FStar_Util.concat_l "\n\t|" uu____2482))
in (FStar_Util.format2 "(match %s with\n\t| %s)" uu____2478 uu____2480)))
end
| FStar_Syntax_Syntax.Tm_uinst (t, us) -> begin
(

let uu____2500 = (FStar_Options.print_universes ())
in (match (uu____2500) with
| true -> begin
(

let uu____2504 = (term_to_string t)
in (

let uu____2506 = (univs_to_string us)
in (FStar_Util.format2 "%s<%s>" uu____2504 uu____2506)))
end
| uu____2509 -> begin
(term_to_string t)
end))
end
| FStar_Syntax_Syntax.Tm_unknown -> begin
"_"
end)))
end)))
and branch_to_string : FStar_Syntax_Syntax.branch  ->  Prims.string = (fun uu____2512 -> (match (uu____2512) with
| (p, wopt, e) -> begin
(

let uu____2534 = (FStar_All.pipe_right p pat_to_string)
in (

let uu____2537 = (match (wopt) with
| FStar_Pervasives_Native.None -> begin
""
end
| FStar_Pervasives_Native.Some (w) -> begin
(

let uu____2548 = (FStar_All.pipe_right w term_to_string)
in (FStar_Util.format1 "when %s" uu____2548))
end)
in (

let uu____2552 = (FStar_All.pipe_right e term_to_string)
in (FStar_Util.format3 "%s %s -> %s" uu____2534 uu____2537 uu____2552))))
end))
and ctx_uvar_to_string : FStar_Syntax_Syntax.ctx_uvar  ->  Prims.string = (fun ctx_uvar -> (

let uu____2557 = (binders_to_string ", " ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_binders)
in (

let uu____2560 = (uvar_to_string ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_head)
in (

let uu____2562 = (term_to_string ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_typ)
in (FStar_Util.format4 "(* %s *)\n(%s |- %s : %s)" ctx_uvar.FStar_Syntax_Syntax.ctx_uvar_reason uu____2557 uu____2560 uu____2562)))))
and subst_elt_to_string : FStar_Syntax_Syntax.subst_elt  ->  Prims.string = (fun uu___5_2565 -> (match (uu___5_2565) with
| FStar_Syntax_Syntax.DB (i, x) -> begin
(

let uu____2571 = (FStar_Util.string_of_int i)
in (

let uu____2573 = (bv_to_string x)
in (FStar_Util.format2 "DB (%s, %s)" uu____2571 uu____2573)))
end
| FStar_Syntax_Syntax.NM (x, i) -> begin
(

let uu____2580 = (bv_to_string x)
in (

let uu____2582 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "NM (%s, %s)" uu____2580 uu____2582)))
end
| FStar_Syntax_Syntax.NT (x, t) -> begin
(

let uu____2591 = (bv_to_string x)
in (

let uu____2593 = (term_to_string t)
in (FStar_Util.format2 "NT (%s, %s)" uu____2591 uu____2593)))
end
| FStar_Syntax_Syntax.UN (i, u) -> begin
(

let uu____2600 = (FStar_Util.string_of_int i)
in (

let uu____2602 = (univ_to_string u)
in (FStar_Util.format2 "UN (%s, %s)" uu____2600 uu____2602)))
end
| FStar_Syntax_Syntax.UD (u, i) -> begin
(

let uu____2609 = (FStar_Util.string_of_int i)
in (FStar_Util.format2 "UD (%s, %s)" u.FStar_Ident.idText uu____2609))
end))
and subst_to_string : FStar_Syntax_Syntax.subst_t  ->  Prims.string = (fun s -> (

let uu____2613 = (FStar_All.pipe_right s (FStar_List.map subst_elt_to_string))
in (FStar_All.pipe_right uu____2613 (FStar_String.concat "; "))))
and pat_to_string : FStar_Syntax_Syntax.pat  ->  Prims.string = (fun x -> (

let uu____2629 = (

let uu____2631 = (FStar_Options.ugly ())
in (not (uu____2631)))
in (match (uu____2629) with
| true -> begin
(

let e = (

let uu____2636 = (FStar_Syntax_Syntax.new_bv_set ())
in (FStar_Syntax_Resugar.resugar_pat x uu____2636))
in (

let d = (FStar_Parser_ToDocument.pat_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d)))
end
| uu____2642 -> begin
(match (x.FStar_Syntax_Syntax.v) with
| FStar_Syntax_Syntax.Pat_cons (l, pats) -> begin
(

let uu____2665 = (fv_to_string l)
in (

let uu____2667 = (

let uu____2669 = (FStar_List.map (fun uu____2683 -> (match (uu____2683) with
| (x1, b) -> begin
(

let p = (pat_to_string x1)
in (match (b) with
| true -> begin
(Prims.op_Hat "#" p)
end
| uu____2699 -> begin
p
end))
end)) pats)
in (FStar_All.pipe_right uu____2669 (FStar_String.concat " ")))
in (FStar_Util.format2 "(%s %s)" uu____2665 uu____2667)))
end
| FStar_Syntax_Syntax.Pat_dot_term (x1, uu____2708) -> begin
(

let uu____2713 = (FStar_Options.print_bound_var_types ())
in (match (uu____2713) with
| true -> begin
(

let uu____2717 = (bv_to_string x1)
in (

let uu____2719 = (term_to_string x1.FStar_Syntax_Syntax.sort)
in (FStar_Util.format2 ".%s:%s" uu____2717 uu____2719)))
end
| uu____2722 -> begin
(

let uu____2724 = (bv_to_string x1)
in (FStar_Util.format1 ".%s" uu____2724))
end))
end
| FStar_Syntax_Syntax.Pat_var (x1) -> begin
(

let uu____2728 = (FStar_Options.print_bound_var_types ())
in (match (uu____2728) with
| true -> begin
(

let uu____2732 = (bv_to_string x1)
in (

let uu____2734 = (term_to_string x1.FStar_Syntax_Syntax.sort)
in (FStar_Util.format2 "%s:%s" uu____2732 uu____2734)))
end
| uu____2737 -> begin
(bv_to_string x1)
end))
end
| FStar_Syntax_Syntax.Pat_constant (c) -> begin
(const_to_string c)
end
| FStar_Syntax_Syntax.Pat_wild (x1) -> begin
(

let uu____2741 = (FStar_Options.print_bound_var_types ())
in (match (uu____2741) with
| true -> begin
(

let uu____2745 = (bv_to_string x1)
in (

let uu____2747 = (term_to_string x1.FStar_Syntax_Syntax.sort)
in (FStar_Util.format2 "_wild_%s:%s" uu____2745 uu____2747)))
end
| uu____2750 -> begin
(bv_to_string x1)
end))
end)
end)))
and lbs_to_string : FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Syntax_Syntax.letbindings  ->  Prims.string = (fun quals lbs -> (

let uu____2756 = (quals_to_string' quals)
in (

let uu____2758 = (

let uu____2760 = (FStar_All.pipe_right (FStar_Pervasives_Native.snd lbs) (FStar_List.map (fun lb -> (

let uu____2780 = (attrs_to_string lb.FStar_Syntax_Syntax.lbattrs)
in (

let uu____2782 = (lbname_to_string lb.FStar_Syntax_Syntax.lbname)
in (

let uu____2784 = (

let uu____2786 = (FStar_Options.print_universes ())
in (match (uu____2786) with
| true -> begin
(

let uu____2790 = (

let uu____2792 = (univ_names_to_string lb.FStar_Syntax_Syntax.lbunivs)
in (Prims.op_Hat uu____2792 ">"))
in (Prims.op_Hat "<" uu____2790))
end
| uu____2796 -> begin
""
end))
in (

let uu____2799 = (term_to_string lb.FStar_Syntax_Syntax.lbtyp)
in (

let uu____2801 = (FStar_All.pipe_right lb.FStar_Syntax_Syntax.lbdef term_to_string)
in (FStar_Util.format5 "%s%s %s : %s = %s" uu____2780 uu____2782 uu____2784 uu____2799 uu____2801)))))))))
in (FStar_Util.concat_l "\n and " uu____2760))
in (FStar_Util.format3 "%slet %s %s" uu____2756 (match ((FStar_Pervasives_Native.fst lbs)) with
| true -> begin
"rec"
end
| uu____2813 -> begin
""
end) uu____2758))))
and attrs_to_string : FStar_Syntax_Syntax.attribute Prims.list  ->  Prims.string = (fun uu___6_2816 -> (match (uu___6_2816) with
| [] -> begin
""
end
| tms -> begin
(

let uu____2824 = (

let uu____2826 = (FStar_List.map (fun t -> (

let uu____2834 = (term_to_string t)
in (paren uu____2834))) tms)
in (FStar_All.pipe_right uu____2826 (FStar_String.concat "; ")))
in (FStar_Util.format1 "[@ %s]" uu____2824))
end))
and aqual_to_string' : Prims.string  ->  FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option  ->  Prims.string = (fun s uu___7_2843 -> (match (uu___7_2843) with
| FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit (false)) -> begin
(Prims.op_Hat "#" s)
end
| FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Implicit (true)) -> begin
(Prims.op_Hat "#." s)
end
| FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Equality) -> begin
(Prims.op_Hat "$" s)
end
| FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta (t)) when (FStar_Syntax_Util.is_fvar FStar_Parser_Const.tcresolve_lid t) -> begin
(Prims.op_Hat "[|" (Prims.op_Hat s "|]"))
end
| FStar_Pervasives_Native.Some (FStar_Syntax_Syntax.Meta (t)) -> begin
(

let uu____2861 = (

let uu____2863 = (term_to_string t)
in (Prims.op_Hat uu____2863 (Prims.op_Hat "]" s)))
in (Prims.op_Hat "#[" uu____2861))
end
| FStar_Pervasives_Native.None -> begin
s
end))
and imp_to_string : Prims.string  ->  FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option  ->  Prims.string = (fun s aq -> (aqual_to_string' s aq))
and binder_to_string' : Prims.bool  ->  (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)  ->  Prims.string = (fun is_arrow b -> (

let uu____2881 = (

let uu____2883 = (FStar_Options.ugly ())
in (not (uu____2883)))
in (match (uu____2881) with
| true -> begin
(

let uu____2887 = (FStar_Syntax_Resugar.resugar_binder b FStar_Range.dummyRange)
in (match (uu____2887) with
| FStar_Pervasives_Native.None -> begin
""
end
| FStar_Pervasives_Native.Some (e) -> begin
(

let d = (FStar_Parser_ToDocument.binder_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d))
end))
end
| uu____2896 -> begin
(

let uu____2898 = b
in (match (uu____2898) with
| (a, imp) -> begin
(

let uu____2912 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____2912) with
| true -> begin
(

let uu____2916 = (term_to_string a.FStar_Syntax_Syntax.sort)
in (Prims.op_Hat "_:" uu____2916))
end
| uu____2919 -> begin
(

let uu____2921 = ((not (is_arrow)) && (

let uu____2924 = (FStar_Options.print_bound_var_types ())
in (not (uu____2924))))
in (match (uu____2921) with
| true -> begin
(

let uu____2928 = (nm_to_string a)
in (imp_to_string uu____2928 imp))
end
| uu____2930 -> begin
(

let uu____2932 = (

let uu____2934 = (nm_to_string a)
in (

let uu____2936 = (

let uu____2938 = (term_to_string a.FStar_Syntax_Syntax.sort)
in (Prims.op_Hat ":" uu____2938))
in (Prims.op_Hat uu____2934 uu____2936)))
in (imp_to_string uu____2932 imp))
end))
end))
end))
end)))
and binder_to_string : FStar_Syntax_Syntax.binder  ->  Prims.string = (fun b -> (binder_to_string' false b))
and arrow_binder_to_string : (FStar_Syntax_Syntax.bv * FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)  ->  Prims.string = (fun b -> (binder_to_string' true b))
and binders_to_string : Prims.string  ->  FStar_Syntax_Syntax.binders  ->  Prims.string = (fun sep bs -> (

let bs1 = (

let uu____2957 = (FStar_Options.print_implicits ())
in (match (uu____2957) with
| true -> begin
bs
end
| uu____2962 -> begin
(filter_imp bs)
end))
in (match ((Prims.op_Equality sep " -> ")) with
| true -> begin
(

let uu____2968 = (FStar_All.pipe_right bs1 (FStar_List.map arrow_binder_to_string))
in (FStar_All.pipe_right uu____2968 (FStar_String.concat sep)))
end
| uu____2994 -> begin
(

let uu____2996 = (FStar_All.pipe_right bs1 (FStar_List.map binder_to_string))
in (FStar_All.pipe_right uu____2996 (FStar_String.concat sep)))
end)))
and arg_to_string : (FStar_Syntax_Syntax.term * FStar_Syntax_Syntax.arg_qualifier FStar_Pervasives_Native.option)  ->  Prims.string = (fun uu___8_3010 -> (match (uu___8_3010) with
| (a, imp) -> begin
(

let uu____3024 = (term_to_string a)
in (imp_to_string uu____3024 imp))
end))
and args_to_string : FStar_Syntax_Syntax.args  ->  Prims.string = (fun args -> (

let args1 = (

let uu____3036 = (FStar_Options.print_implicits ())
in (match (uu____3036) with
| true -> begin
args
end
| uu____3047 -> begin
(filter_imp args)
end))
in (

let uu____3051 = (FStar_All.pipe_right args1 (FStar_List.map arg_to_string))
in (FStar_All.pipe_right uu____3051 (FStar_String.concat " ")))))
and comp_to_string : FStar_Syntax_Syntax.comp  ->  Prims.string = (fun c -> (

let uu____3079 = (

let uu____3081 = (FStar_Options.ugly ())
in (not (uu____3081)))
in (match (uu____3079) with
| true -> begin
(

let e = (FStar_Syntax_Resugar.resugar_comp c)
in (

let d = (FStar_Parser_ToDocument.term_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d)))
end
| uu____3089 -> begin
(match (c.FStar_Syntax_Syntax.n) with
| FStar_Syntax_Syntax.Total (t, uopt) -> begin
(

let uu____3102 = (

let uu____3103 = (FStar_Syntax_Subst.compress t)
in uu____3103.FStar_Syntax_Syntax.n)
in (match (uu____3102) with
| FStar_Syntax_Syntax.Tm_type (uu____3107) when (

let uu____3108 = ((FStar_Options.print_implicits ()) || (FStar_Options.print_universes ()))
in (not (uu____3108))) -> begin
(term_to_string t)
end
| uu____3110 -> begin
(match (uopt) with
| FStar_Pervasives_Native.Some (u) when (FStar_Options.print_universes ()) -> begin
(

let uu____3113 = (univ_to_string u)
in (

let uu____3115 = (term_to_string t)
in (FStar_Util.format2 "Tot<%s> %s" uu____3113 uu____3115)))
end
| uu____3118 -> begin
(

let uu____3121 = (term_to_string t)
in (FStar_Util.format1 "Tot %s" uu____3121))
end)
end))
end
| FStar_Syntax_Syntax.GTotal (t, uopt) -> begin
(

let uu____3134 = (

let uu____3135 = (FStar_Syntax_Subst.compress t)
in uu____3135.FStar_Syntax_Syntax.n)
in (match (uu____3134) with
| FStar_Syntax_Syntax.Tm_type (uu____3139) when (

let uu____3140 = ((FStar_Options.print_implicits ()) || (FStar_Options.print_universes ()))
in (not (uu____3140))) -> begin
(term_to_string t)
end
| uu____3142 -> begin
(match (uopt) with
| FStar_Pervasives_Native.Some (u) when (FStar_Options.print_universes ()) -> begin
(

let uu____3145 = (univ_to_string u)
in (

let uu____3147 = (term_to_string t)
in (FStar_Util.format2 "GTot<%s> %s" uu____3145 uu____3147)))
end
| uu____3150 -> begin
(

let uu____3153 = (term_to_string t)
in (FStar_Util.format1 "GTot %s" uu____3153))
end)
end))
end
| FStar_Syntax_Syntax.Comp (c1) -> begin
(

let basic = (

let uu____3159 = (FStar_Options.print_effect_args ())
in (match (uu____3159) with
| true -> begin
(

let uu____3163 = (sli c1.FStar_Syntax_Syntax.effect_name)
in (

let uu____3165 = (

let uu____3167 = (FStar_All.pipe_right c1.FStar_Syntax_Syntax.comp_univs (FStar_List.map univ_to_string))
in (FStar_All.pipe_right uu____3167 (FStar_String.concat ", ")))
in (

let uu____3182 = (term_to_string c1.FStar_Syntax_Syntax.result_typ)
in (

let uu____3184 = (

let uu____3186 = (FStar_All.pipe_right c1.FStar_Syntax_Syntax.effect_args (FStar_List.map arg_to_string))
in (FStar_All.pipe_right uu____3186 (FStar_String.concat ", ")))
in (

let uu____3213 = (cflags_to_string c1.FStar_Syntax_Syntax.flags)
in (FStar_Util.format5 "%s<%s> (%s) %s (attributes %s)" uu____3163 uu____3165 uu____3182 uu____3184 uu____3213))))))
end
| uu____3216 -> begin
(

let uu____3218 = ((FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun uu___9_3224 -> (match (uu___9_3224) with
| FStar_Syntax_Syntax.TOTAL -> begin
true
end
| uu____3227 -> begin
false
end)))) && (

let uu____3230 = (FStar_Options.print_effect_args ())
in (not (uu____3230))))
in (match (uu____3218) with
| true -> begin
(

let uu____3234 = (term_to_string c1.FStar_Syntax_Syntax.result_typ)
in (FStar_Util.format1 "Tot %s" uu____3234))
end
| uu____3237 -> begin
(

let uu____3239 = (((

let uu____3243 = (FStar_Options.print_effect_args ())
in (not (uu____3243))) && (

let uu____3246 = (FStar_Options.print_implicits ())
in (not (uu____3246)))) && (FStar_Ident.lid_equals c1.FStar_Syntax_Syntax.effect_name FStar_Parser_Const.effect_ML_lid))
in (match (uu____3239) with
| true -> begin
(term_to_string c1.FStar_Syntax_Syntax.result_typ)
end
| uu____3250 -> begin
(

let uu____3252 = ((

let uu____3256 = (FStar_Options.print_effect_args ())
in (not (uu____3256))) && (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags (FStar_Util.for_some (fun uu___10_3262 -> (match (uu___10_3262) with
| FStar_Syntax_Syntax.MLEFFECT -> begin
true
end
| uu____3265 -> begin
false
end)))))
in (match (uu____3252) with
| true -> begin
(

let uu____3269 = (term_to_string c1.FStar_Syntax_Syntax.result_typ)
in (FStar_Util.format1 "ALL %s" uu____3269))
end
| uu____3272 -> begin
(

let uu____3274 = (sli c1.FStar_Syntax_Syntax.effect_name)
in (

let uu____3276 = (term_to_string c1.FStar_Syntax_Syntax.result_typ)
in (FStar_Util.format2 "%s (%s)" uu____3274 uu____3276)))
end))
end))
end))
end))
in (

let dec = (

let uu____3281 = (FStar_All.pipe_right c1.FStar_Syntax_Syntax.flags (FStar_List.collect (fun uu___11_3294 -> (match (uu___11_3294) with
| FStar_Syntax_Syntax.DECREASES (e) -> begin
(

let uu____3301 = (

let uu____3303 = (term_to_string e)
in (FStar_Util.format1 " (decreases %s)" uu____3303))
in (uu____3301)::[])
end
| uu____3308 -> begin
[]
end))))
in (FStar_All.pipe_right uu____3281 (FStar_String.concat " ")))
in (FStar_Util.format2 "%s%s" basic dec)))
end)
end)))
and cflag_to_string : FStar_Syntax_Syntax.cflag  ->  Prims.string = (fun c -> (match (c) with
| FStar_Syntax_Syntax.TOTAL -> begin
"total"
end
| FStar_Syntax_Syntax.MLEFFECT -> begin
"ml"
end
| FStar_Syntax_Syntax.RETURN -> begin
"return"
end
| FStar_Syntax_Syntax.PARTIAL_RETURN -> begin
"partial_return"
end
| FStar_Syntax_Syntax.SOMETRIVIAL -> begin
"sometrivial"
end
| FStar_Syntax_Syntax.TRIVIAL_POSTCONDITION -> begin
"trivial_postcondition"
end
| FStar_Syntax_Syntax.SHOULD_NOT_INLINE -> begin
"should_not_inline"
end
| FStar_Syntax_Syntax.LEMMA -> begin
"lemma"
end
| FStar_Syntax_Syntax.CPS -> begin
"cps"
end
| FStar_Syntax_Syntax.DECREASES (uu____3327) -> begin
""
end))
and cflags_to_string : FStar_Syntax_Syntax.cflag Prims.list  ->  Prims.string = (fun fs -> (FStar_Common.string_of_list cflag_to_string fs))
and formula_to_string : FStar_Syntax_Syntax.term' FStar_Syntax_Syntax.syntax  ->  Prims.string = (fun phi -> (term_to_string phi))
and metadata_to_string : FStar_Syntax_Syntax.metadata  ->  Prims.string = (fun uu___12_3337 -> (match (uu___12_3337) with
| FStar_Syntax_Syntax.Meta_pattern (uu____3339, ps) -> begin
(

let pats = (

let uu____3375 = (FStar_All.pipe_right ps (FStar_List.map (fun args -> (

let uu____3412 = (FStar_All.pipe_right args (FStar_List.map (fun uu____3437 -> (match (uu____3437) with
| (t, uu____3446) -> begin
(term_to_string t)
end))))
in (FStar_All.pipe_right uu____3412 (FStar_String.concat "; "))))))
in (FStar_All.pipe_right uu____3375 (FStar_String.concat "\\/")))
in (FStar_Util.format1 "{Meta_pattern %s}" pats))
end
| FStar_Syntax_Syntax.Meta_named (lid) -> begin
(

let uu____3463 = (sli lid)
in (FStar_Util.format1 "{Meta_named %s}" uu____3463))
end
| FStar_Syntax_Syntax.Meta_labeled (l, r, uu____3468) -> begin
(

let uu____3473 = (FStar_Range.string_of_range r)
in (FStar_Util.format2 "{Meta_labeled (%s, %s)}" l uu____3473))
end
| FStar_Syntax_Syntax.Meta_desugared (msi) -> begin
"{Meta_desugared}"
end
| FStar_Syntax_Syntax.Meta_monadic (m, t) -> begin
(

let uu____3484 = (sli m)
in (

let uu____3486 = (term_to_string t)
in (FStar_Util.format2 "{Meta_monadic(%s @ %s)}" uu____3484 uu____3486)))
end
| FStar_Syntax_Syntax.Meta_monadic_lift (m, m', t) -> begin
(

let uu____3496 = (sli m)
in (

let uu____3498 = (sli m')
in (

let uu____3500 = (term_to_string t)
in (FStar_Util.format3 "{Meta_monadic_lift(%s -> %s @ %s)}" uu____3496 uu____3498 uu____3500))))
end))


let aqual_to_string : FStar_Syntax_Syntax.aqual  ->  Prims.string = (fun aq -> (aqual_to_string' "" aq))


let comp_to_string' : FStar_Syntax_DsEnv.env  ->  FStar_Syntax_Syntax.comp  ->  Prims.string = (fun env c -> (

let uu____3523 = (FStar_Options.ugly ())
in (match (uu____3523) with
| true -> begin
(comp_to_string c)
end
| uu____3527 -> begin
(

let e = (FStar_Syntax_Resugar.resugar_comp' env c)
in (

let d = (FStar_Parser_ToDocument.term_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d)))
end)))


let term_to_string' : FStar_Syntax_DsEnv.env  ->  FStar_Syntax_Syntax.term  ->  Prims.string = (fun env x -> (

let uu____3545 = (FStar_Options.ugly ())
in (match (uu____3545) with
| true -> begin
(term_to_string x)
end
| uu____3549 -> begin
(

let e = (FStar_Syntax_Resugar.resugar_term' env x)
in (

let d = (FStar_Parser_ToDocument.term_to_document e)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d)))
end)))


let binder_to_json : FStar_Syntax_DsEnv.env  ->  FStar_Syntax_Syntax.binder  ->  FStar_Util.json = (fun env b -> (

let uu____3566 = b
in (match (uu____3566) with
| (a, imp) -> begin
(

let n1 = (

let uu____3574 = (FStar_Syntax_Syntax.is_null_binder b)
in (match (uu____3574) with
| true -> begin
FStar_Util.JsonNull
end
| uu____3577 -> begin
(

let uu____3579 = (

let uu____3581 = (nm_to_string a)
in (imp_to_string uu____3581 imp))
in FStar_Util.JsonStr (uu____3579))
end))
in (

let t = (

let uu____3584 = (term_to_string' env a.FStar_Syntax_Syntax.sort)
in FStar_Util.JsonStr (uu____3584))
in FStar_Util.JsonAssoc (((("name"), (n1)))::((("type"), (t)))::[])))
end)))


let binders_to_json : FStar_Syntax_DsEnv.env  ->  FStar_Syntax_Syntax.binders  ->  FStar_Util.json = (fun env bs -> (

let uu____3616 = (FStar_List.map (binder_to_json env) bs)
in FStar_Util.JsonList (uu____3616)))


let enclose_universes : Prims.string  ->  Prims.string = (fun s -> (

let uu____3634 = (FStar_Options.print_universes ())
in (match (uu____3634) with
| true -> begin
(Prims.op_Hat "<" (Prims.op_Hat s ">"))
end
| uu____3640 -> begin
""
end)))


let tscheme_to_string : FStar_Syntax_Syntax.tscheme  ->  Prims.string = (fun s -> (

let uu____3650 = (

let uu____3652 = (FStar_Options.ugly ())
in (not (uu____3652)))
in (match (uu____3650) with
| true -> begin
(

let d = (FStar_Syntax_Resugar.resugar_tscheme s)
in (

let d1 = (FStar_Parser_ToDocument.decl_to_document d)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d1)))
end
| uu____3660 -> begin
(

let uu____3662 = s
in (match (uu____3662) with
| (us, t) -> begin
(

let uu____3674 = (

let uu____3676 = (univ_names_to_string us)
in (FStar_All.pipe_left enclose_universes uu____3676))
in (

let uu____3680 = (term_to_string t)
in (FStar_Util.format2 "%s%s" uu____3674 uu____3680)))
end))
end)))


let action_to_string : FStar_Syntax_Syntax.action  ->  Prims.string = (fun a -> (

let uu____3690 = (sli a.FStar_Syntax_Syntax.action_name)
in (

let uu____3692 = (binders_to_string " " a.FStar_Syntax_Syntax.action_params)
in (

let uu____3695 = (

let uu____3697 = (univ_names_to_string a.FStar_Syntax_Syntax.action_univs)
in (FStar_All.pipe_left enclose_universes uu____3697))
in (

let uu____3701 = (term_to_string a.FStar_Syntax_Syntax.action_typ)
in (

let uu____3703 = (term_to_string a.FStar_Syntax_Syntax.action_defn)
in (FStar_Util.format5 "%s%s %s : %s = %s" uu____3690 uu____3692 uu____3695 uu____3701 uu____3703)))))))


let wp_eff_combinators_to_string : FStar_Syntax_Syntax.wp_eff_combinators  ->  Prims.string = (fun combs -> (

let tscheme_opt_to_string = (fun uu___13_3721 -> (match (uu___13_3721) with
| FStar_Pervasives_Native.Some (ts) -> begin
(tscheme_to_string ts)
end
| FStar_Pervasives_Native.None -> begin
"None"
end))
in (

let uu____3727 = (

let uu____3731 = (tscheme_to_string combs.FStar_Syntax_Syntax.ret_wp)
in (

let uu____3733 = (

let uu____3737 = (tscheme_to_string combs.FStar_Syntax_Syntax.bind_wp)
in (

let uu____3739 = (

let uu____3743 = (tscheme_to_string combs.FStar_Syntax_Syntax.stronger)
in (

let uu____3745 = (

let uu____3749 = (tscheme_to_string combs.FStar_Syntax_Syntax.if_then_else)
in (

let uu____3751 = (

let uu____3755 = (tscheme_to_string combs.FStar_Syntax_Syntax.ite_wp)
in (

let uu____3757 = (

let uu____3761 = (tscheme_to_string combs.FStar_Syntax_Syntax.close_wp)
in (

let uu____3763 = (

let uu____3767 = (tscheme_to_string combs.FStar_Syntax_Syntax.trivial)
in (

let uu____3769 = (

let uu____3773 = (tscheme_opt_to_string combs.FStar_Syntax_Syntax.repr)
in (

let uu____3775 = (

let uu____3779 = (tscheme_opt_to_string combs.FStar_Syntax_Syntax.return_repr)
in (

let uu____3781 = (

let uu____3785 = (tscheme_opt_to_string combs.FStar_Syntax_Syntax.bind_repr)
in (uu____3785)::[])
in (uu____3779)::uu____3781))
in (uu____3773)::uu____3775))
in (uu____3767)::uu____3769))
in (uu____3761)::uu____3763))
in (uu____3755)::uu____3757))
in (uu____3749)::uu____3751))
in (uu____3743)::uu____3745))
in (uu____3737)::uu____3739))
in (uu____3731)::uu____3733))
in (FStar_Util.format "{\nret_wp       = %s\n; bind_wp      = %s\n; stronger     = %s\n; if_then_else = %s\n; ite_wp       = %s\n; close_wp     = %s\n; trivial      = %s\n; repr         = %s\n; return_repr  = %s\n; bind_repr    = %s\n}\n" uu____3727))))


let layered_eff_combinators_to_string : FStar_Syntax_Syntax.layered_eff_combinators  ->  Prims.string = (fun combs -> (

let to_str = (fun uu____3816 -> (match (uu____3816) with
| (ts_t, ts_ty) -> begin
(

let uu____3824 = (tscheme_to_string ts_t)
in (

let uu____3826 = (tscheme_to_string ts_ty)
in (FStar_Util.format2 "(%s) : (%s)" uu____3824 uu____3826)))
end))
in (

let uu____3829 = (

let uu____3833 = (FStar_Ident.string_of_lid combs.FStar_Syntax_Syntax.l_base_effect)
in (

let uu____3835 = (

let uu____3839 = (to_str combs.FStar_Syntax_Syntax.l_repr)
in (

let uu____3841 = (

let uu____3845 = (to_str combs.FStar_Syntax_Syntax.l_return)
in (

let uu____3847 = (

let uu____3851 = (to_str combs.FStar_Syntax_Syntax.l_bind)
in (

let uu____3853 = (

let uu____3857 = (to_str combs.FStar_Syntax_Syntax.l_subcomp)
in (

let uu____3859 = (

let uu____3863 = (to_str combs.FStar_Syntax_Syntax.l_if_then_else)
in (uu____3863)::[])
in (uu____3857)::uu____3859))
in (uu____3851)::uu____3853))
in (uu____3845)::uu____3847))
in (uu____3839)::uu____3841))
in (uu____3833)::uu____3835))
in (FStar_Util.format "{\nl_base_effect = %s\n; l_repr = %s\n; l_return = %s\n; l_bind = %s\n; l_subcomp = %s\n; l_if_then_else = %s\n\n  }\n" uu____3829))))


let eff_combinators_to_string : FStar_Syntax_Syntax.eff_combinators  ->  Prims.string = (fun uu___14_3879 -> (match (uu___14_3879) with
| FStar_Syntax_Syntax.Primitive_eff (combs) -> begin
(wp_eff_combinators_to_string combs)
end
| FStar_Syntax_Syntax.DM4F_eff (combs) -> begin
(wp_eff_combinators_to_string combs)
end
| FStar_Syntax_Syntax.Layered_eff (combs) -> begin
(layered_eff_combinators_to_string combs)
end))


let eff_decl_to_string' : Prims.bool  ->  FStar_Range.range  ->  FStar_Syntax_Syntax.qualifier Prims.list  ->  FStar_Syntax_Syntax.eff_decl  ->  Prims.string = (fun for_free r q ed -> (

let uu____3912 = (

let uu____3914 = (FStar_Options.ugly ())
in (not (uu____3914)))
in (match (uu____3912) with
| true -> begin
(

let d = (FStar_Syntax_Resugar.resugar_eff_decl r q ed)
in (

let d1 = (FStar_Parser_ToDocument.decl_to_document d)
in (FStar_Pprint.pretty_string (FStar_Util.float_of_string "1.0") (Prims.parse_int "100") d1)))
end
| uu____3922 -> begin
(

let actions_to_string = (fun actions -> (

let uu____3935 = (FStar_All.pipe_right actions (FStar_List.map action_to_string))
in (FStar_All.pipe_right uu____3935 (FStar_String.concat ",\n\t"))))
in (

let eff_name = (

let uu____3952 = (FStar_Syntax_Util.is_layered ed)
in (match (uu____3952) with
| true -> begin
"layered_effect"
end
| uu____3957 -> begin
"new_effect"
end))
in (

let uu____3960 = (

let uu____3964 = (

let uu____3968 = (

let uu____3972 = (lid_to_string ed.FStar_Syntax_Syntax.mname)
in (

let uu____3974 = (

let uu____3978 = (

let uu____3980 = (univ_names_to_string ed.FStar_Syntax_Syntax.univs)
in (FStar_All.pipe_left enclose_universes uu____3980))
in (

let uu____3984 = (

let uu____3988 = (binders_to_string " " ed.FStar_Syntax_Syntax.binders)
in (

let uu____3991 = (

let uu____3995 = (tscheme_to_string ed.FStar_Syntax_Syntax.signature)
in (

let uu____3997 = (

let uu____4001 = (eff_combinators_to_string ed.FStar_Syntax_Syntax.combinators)
in (

let uu____4003 = (

let uu____4007 = (actions_to_string ed.FStar_Syntax_Syntax.actions)
in (uu____4007)::[])
in (uu____4001)::uu____4003))
in (uu____3995)::uu____3997))
in (uu____3988)::uu____3991))
in (uu____3978)::uu____3984))
in (uu____3972)::uu____3974))
in ((match (for_free) with
| true -> begin
"_for_free "
end
| uu____4020 -> begin
""
end))::uu____3968)
in (eff_name)::uu____3964)
in (FStar_Util.format "%s%s { %s%s %s : %s \n  %s\nand effect_actions\n\t%s\n}\n" uu____3960))))
end)))


let eff_decl_to_string : Prims.bool  ->  FStar_Syntax_Syntax.eff_decl  ->  Prims.string = (fun for_free ed -> (eff_decl_to_string' for_free FStar_Range.dummyRange [] ed))


let sub_eff_to_string : FStar_Syntax_Syntax.sub_eff  ->  Prims.string = (fun se -> (

let tsopt_to_string = (fun ts_opt -> (match ((FStar_Util.is_some ts_opt)) with
| true -> begin
(

let uu____4059 = (FStar_All.pipe_right ts_opt FStar_Util.must)
in (FStar_All.pipe_right uu____4059 tscheme_to_string))
end
| uu____4063 -> begin
"<None>"
end))
in (

let uu____4066 = (lid_to_string se.FStar_Syntax_Syntax.source)
in (

let uu____4068 = (lid_to_string se.FStar_Syntax_Syntax.target)
in (

let uu____4070 = (tsopt_to_string se.FStar_Syntax_Syntax.lift)
in (

let uu____4072 = (tsopt_to_string se.FStar_Syntax_Syntax.lift_wp)
in (FStar_Util.format4 "sub_effect %s ~> %s : lift = %s ;; lift_wp = %s" uu____4066 uu____4068 uu____4070 uu____4072)))))))


let rec sigelt_to_string : FStar_Syntax_Syntax.sigelt  ->  Prims.string = (fun x -> (

let basic = (match (x.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.LightOff) -> begin
"#light \"off\""
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.ResetOptions (FStar_Pervasives_Native.None)) -> begin
"#reset-options"
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.ResetOptions (FStar_Pervasives_Native.Some (s))) -> begin
(FStar_Util.format1 "#reset-options \"%s\"" s)
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.SetOptions (s)) -> begin
(FStar_Util.format1 "#set-options \"%s\"" s)
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PushOptions (FStar_Pervasives_Native.None)) -> begin
"#push-options"
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PushOptions (FStar_Pervasives_Native.Some (s))) -> begin
(FStar_Util.format1 "#push-options \"%s\"" s)
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.RestartSolver) -> begin
"#restart-solver"
end
| FStar_Syntax_Syntax.Sig_pragma (FStar_Syntax_Syntax.PopOptions) -> begin
"#pop-options"
end
| FStar_Syntax_Syntax.Sig_inductive_typ (lid, univs1, tps, k, uu____4107, uu____4108) -> begin
(

let quals_str = (quals_to_string' x.FStar_Syntax_Syntax.sigquals)
in (

let binders_str = (binders_to_string " " tps)
in (

let term_str = (term_to_string k)
in (

let uu____4124 = (FStar_Options.print_universes ())
in (match (uu____4124) with
| true -> begin
(

let uu____4128 = (univ_names_to_string univs1)
in (FStar_Util.format5 "%stype %s<%s> %s : %s" quals_str lid.FStar_Ident.str uu____4128 binders_str term_str))
end
| uu____4131 -> begin
(FStar_Util.format4 "%stype %s %s : %s" quals_str lid.FStar_Ident.str binders_str term_str)
end)))))
end
| FStar_Syntax_Syntax.Sig_datacon (lid, univs1, t, uu____4137, uu____4138, uu____4139) -> begin
(

let uu____4146 = (FStar_Options.print_universes ())
in (match (uu____4146) with
| true -> begin
(

let uu____4150 = (univ_names_to_string univs1)
in (

let uu____4152 = (term_to_string t)
in (FStar_Util.format3 "datacon<%s> %s : %s" uu____4150 lid.FStar_Ident.str uu____4152)))
end
| uu____4155 -> begin
(

let uu____4157 = (term_to_string t)
in (FStar_Util.format2 "datacon %s : %s" lid.FStar_Ident.str uu____4157))
end))
end
| FStar_Syntax_Syntax.Sig_declare_typ (lid, univs1, t) -> begin
(

let uu____4163 = (quals_to_string' x.FStar_Syntax_Syntax.sigquals)
in (

let uu____4165 = (

let uu____4167 = (FStar_Options.print_universes ())
in (match (uu____4167) with
| true -> begin
(

let uu____4171 = (univ_names_to_string univs1)
in (FStar_Util.format1 "<%s>" uu____4171))
end
| uu____4174 -> begin
""
end))
in (

let uu____4177 = (term_to_string t)
in (FStar_Util.format4 "%sval %s %s : %s" uu____4163 lid.FStar_Ident.str uu____4165 uu____4177))))
end
| FStar_Syntax_Syntax.Sig_assume (lid, us, f) -> begin
(

let uu____4183 = (FStar_Options.print_universes ())
in (match (uu____4183) with
| true -> begin
(

let uu____4187 = (univ_names_to_string us)
in (

let uu____4189 = (term_to_string f)
in (FStar_Util.format3 "val %s<%s> : %s" lid.FStar_Ident.str uu____4187 uu____4189)))
end
| uu____4192 -> begin
(

let uu____4194 = (term_to_string f)
in (FStar_Util.format2 "val %s : %s" lid.FStar_Ident.str uu____4194))
end))
end
| FStar_Syntax_Syntax.Sig_let (lbs, uu____4198) -> begin
(lbs_to_string x.FStar_Syntax_Syntax.sigquals lbs)
end
| FStar_Syntax_Syntax.Sig_main (e) -> begin
(

let uu____4204 = (term_to_string e)
in (FStar_Util.format1 "let _ = %s" uu____4204))
end
| FStar_Syntax_Syntax.Sig_bundle (ses, uu____4208) -> begin
(

let uu____4217 = (

let uu____4219 = (FStar_List.map sigelt_to_string ses)
in (FStar_All.pipe_right uu____4219 (FStar_String.concat "\n")))
in (Prims.op_Hat "(* Sig_bundle *)" uu____4217))
end
| FStar_Syntax_Syntax.Sig_new_effect (ed) -> begin
(

let uu____4231 = (FStar_Syntax_Util.is_dm4f ed)
in (eff_decl_to_string' uu____4231 x.FStar_Syntax_Syntax.sigrng x.FStar_Syntax_Syntax.sigquals ed))
end
| FStar_Syntax_Syntax.Sig_sub_effect (se) -> begin
(sub_eff_to_string se)
end
| FStar_Syntax_Syntax.Sig_effect_abbrev (l, univs1, tps, c, flags) -> begin
(

let uu____4243 = (FStar_Options.print_universes ())
in (match (uu____4243) with
| true -> begin
(

let uu____4247 = (

let uu____4252 = (FStar_Syntax_Syntax.mk (FStar_Syntax_Syntax.Tm_arrow (((tps), (c)))) FStar_Pervasives_Native.None FStar_Range.dummyRange)
in (FStar_Syntax_Subst.open_univ_vars univs1 uu____4252))
in (match (uu____4247) with
| (univs2, t) -> begin
(

let uu____4266 = (

let uu____4271 = (

let uu____4272 = (FStar_Syntax_Subst.compress t)
in uu____4272.FStar_Syntax_Syntax.n)
in (match (uu____4271) with
| FStar_Syntax_Syntax.Tm_arrow (bs, c1) -> begin
((bs), (c1))
end
| uu____4301 -> begin
(failwith "impossible")
end))
in (match (uu____4266) with
| (tps1, c1) -> begin
(

let uu____4310 = (sli l)
in (

let uu____4312 = (univ_names_to_string univs2)
in (

let uu____4314 = (binders_to_string " " tps1)
in (

let uu____4317 = (comp_to_string c1)
in (FStar_Util.format4 "effect %s<%s> %s = %s" uu____4310 uu____4312 uu____4314 uu____4317)))))
end))
end))
end
| uu____4320 -> begin
(

let uu____4322 = (sli l)
in (

let uu____4324 = (binders_to_string " " tps)
in (

let uu____4327 = (comp_to_string c)
in (FStar_Util.format3 "effect %s %s = %s" uu____4322 uu____4324 uu____4327))))
end))
end
| FStar_Syntax_Syntax.Sig_splice (lids, t) -> begin
(

let uu____4336 = (

let uu____4338 = (FStar_List.map FStar_Ident.string_of_lid lids)
in (FStar_All.pipe_left (FStar_String.concat "; ") uu____4338))
in (

let uu____4348 = (term_to_string t)
in (FStar_Util.format2 "splice[%s] (%s)" uu____4336 uu____4348)))
end)
in (match (x.FStar_Syntax_Syntax.sigattrs) with
| [] -> begin
(Prims.op_Hat "[@ ]" (Prims.op_Hat "\n" basic))
end
| uu____4354 -> begin
(

let uu____4357 = (attrs_to_string x.FStar_Syntax_Syntax.sigattrs)
in (Prims.op_Hat uu____4357 (Prims.op_Hat "\n" basic)))
end)))


let format_error : FStar_Range.range  ->  Prims.string  ->  Prims.string = (fun r msg -> (

let uu____4374 = (FStar_Range.string_of_range r)
in (FStar_Util.format2 "%s: %s\n" uu____4374 msg)))


let sigelt_to_string_short : FStar_Syntax_Syntax.sigelt  ->  Prims.string = (fun x -> (match (x.FStar_Syntax_Syntax.sigel) with
| FStar_Syntax_Syntax.Sig_let ((uu____4385, ({FStar_Syntax_Syntax.lbname = lb; FStar_Syntax_Syntax.lbunivs = uu____4387; FStar_Syntax_Syntax.lbtyp = t; FStar_Syntax_Syntax.lbeff = uu____4389; FStar_Syntax_Syntax.lbdef = uu____4390; FStar_Syntax_Syntax.lbattrs = uu____4391; FStar_Syntax_Syntax.lbpos = uu____4392})::[]), uu____4393) -> begin
(

let uu____4416 = (lbname_to_string lb)
in (

let uu____4418 = (term_to_string t)
in (FStar_Util.format2 "let %s : %s" uu____4416 uu____4418)))
end
| uu____4421 -> begin
(

let uu____4422 = (FStar_All.pipe_right (FStar_Syntax_Util.lids_of_sigelt x) (FStar_List.map (fun l -> l.FStar_Ident.str)))
in (FStar_All.pipe_right uu____4422 (FStar_String.concat ", ")))
end))


let modul_to_string : FStar_Syntax_Syntax.modul  ->  Prims.string = (fun m -> (

let uu____4446 = (sli m.FStar_Syntax_Syntax.name)
in (

let uu____4448 = (

let uu____4450 = (FStar_List.map sigelt_to_string m.FStar_Syntax_Syntax.declarations)
in (FStar_All.pipe_right uu____4450 (FStar_String.concat "\n")))
in (

let uu____4460 = (

let uu____4462 = (FStar_List.map sigelt_to_string m.FStar_Syntax_Syntax.exports)
in (FStar_All.pipe_right uu____4462 (FStar_String.concat "\n")))
in (FStar_Util.format3 "module %s\nDeclarations: [\n%s\n]\nExports: [\n%s\n]\n" uu____4446 uu____4448 uu____4460)))))


let list_to_string : 'a . ('a  ->  Prims.string)  ->  'a Prims.list  ->  Prims.string = (fun f elts -> (match (elts) with
| [] -> begin
"[]"
end
| (x)::xs -> begin
(

let strb = (FStar_Util.new_string_builder ())
in ((FStar_Util.string_builder_append strb "[");
(

let uu____4512 = (f x)
in (FStar_Util.string_builder_append strb uu____4512));
(FStar_List.iter (fun x1 -> ((FStar_Util.string_builder_append strb "; ");
(

let uu____4521 = (f x1)
in (FStar_Util.string_builder_append strb uu____4521));
)) xs);
(FStar_Util.string_builder_append strb "]");
(FStar_Util.string_of_string_builder strb);
))
end))


let set_to_string : 'a . ('a  ->  Prims.string)  ->  'a FStar_Util.set  ->  Prims.string = (fun f s -> (

let elts = (FStar_Util.set_elements s)
in (match (elts) with
| [] -> begin
"{}"
end
| (x)::xs -> begin
(

let strb = (FStar_Util.new_string_builder ())
in ((FStar_Util.string_builder_append strb "{");
(

let uu____4568 = (f x)
in (FStar_Util.string_builder_append strb uu____4568));
(FStar_List.iter (fun x1 -> ((FStar_Util.string_builder_append strb ", ");
(

let uu____4577 = (f x1)
in (FStar_Util.string_builder_append strb uu____4577));
)) xs);
(FStar_Util.string_builder_append strb "}");
(FStar_Util.string_of_string_builder strb);
))
end)))


let bvs_to_string : Prims.string  ->  FStar_Syntax_Syntax.bv Prims.list  ->  Prims.string = (fun sep bvs -> (

let uu____4599 = (FStar_List.map FStar_Syntax_Syntax.mk_binder bvs)
in (binders_to_string sep uu____4599)))


let rec emb_typ_to_string : FStar_Syntax_Syntax.emb_typ  ->  Prims.string = (fun uu___15_4612 -> (match (uu___15_4612) with
| FStar_Syntax_Syntax.ET_abstract -> begin
"abstract"
end
| FStar_Syntax_Syntax.ET_app (h, []) -> begin
h
end
| FStar_Syntax_Syntax.ET_app (h, args) -> begin
(

let uu____4628 = (

let uu____4630 = (

let uu____4632 = (

let uu____4634 = (

let uu____4636 = (FStar_List.map emb_typ_to_string args)
in (FStar_All.pipe_right uu____4636 (FStar_String.concat " ")))
in (Prims.op_Hat uu____4634 ")"))
in (Prims.op_Hat " " uu____4632))
in (Prims.op_Hat h uu____4630))
in (Prims.op_Hat "(" uu____4628))
end
| FStar_Syntax_Syntax.ET_fun (a, b) -> begin
(

let uu____4651 = (

let uu____4653 = (emb_typ_to_string a)
in (

let uu____4655 = (

let uu____4657 = (emb_typ_to_string b)
in (Prims.op_Hat ") -> " uu____4657))
in (Prims.op_Hat uu____4653 uu____4655)))
in (Prims.op_Hat "(" uu____4651))
end))




