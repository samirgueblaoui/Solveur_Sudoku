let sure = fun l -> match l with  
[i] -> Some i 
| (t1 :: t2 :: q) -> None 
| [] -> None;;

let grille_test1 = 
[[[1;2;3;4;5;6;7;8;9];[3];[1;2;3;4;5;6;7;8;9];[2];[7];[4];[5];[1;2;3;4;5;6;7;8;9];[9]];
[[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[2];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[2];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[8]];
[[1;2;3;4;5;6;7;8;9];[7];[6];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[3];[1];[2];[4]];
[[3];[1];[5];[1;2;3;4;5;6;7;8;9];[9];[6];[2];[8];[7]];
[[7];[4];[8];[1;2;3;4;5;6;7;8;9];[1];[1;2;3;4;5;6;7;8;9];[9];[3];[6]];
[[6];[2];[9];[7];[3];[1;2;3;4;5;6;7;8;9];[4];[5];[1]];
[[1];[8];[3];[6];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[7];[9];[1;2;3;4;5;6;7;8;9]];
[[2];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[3];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9];[3];[1;2;3;4;5;6;7;8;9];[1;2;3;4;5;6;7;8;9]];
[[5];[1;2;3;4;5;6;7;8;9];[4];[9];[2];[7];[1;2;3;4;5;6;7;8;9];[1];[1;2;3;4;5;6;7;8;9]]];;

let iter_colonne = fun (i,j) -> fun n -> ((n-1),j);;
let iter_ligne = fun (i,j) -> fun n -> (i,(n-1));;

let iter_carre = fun (i,j)-> fun n -> if j<3 then 
(if n<4 then ( i - (i mod 3) , ((n-1) mod 3)) 
else ( if n>6 then ( (i - (i mod 3) + 2) , ((n-1) mod 3)) 
else ( (i - (i mod 3) + 1) , ((n-1) mod 3))))
else (if j > 5 then (if n<4 then ( (i - (i mod 3)) , (6+ ((n-1) mod 3))) 
else ( if n>6 then ( (i - (i mod 3) + 2) , (6+((n-1) mod 3))) 
else ( (i - (i mod 3) + 1) , (6 +((n-1) mod 3))))) 
else (if n<4 then ( (i - (i mod 3)) , (3+((n-1) mod 3))) 
else ( if n>6 then ( (i - (i mod 3) + 2) , (3+((n-1) mod 3))) 
else ( (i - (i mod 3) + 1) , (3+((n-1) mod 3))))));;


let print_grille_aux = fun l -> match l with
|[] ->0
|t::q -> t ;; 

let rec print_grille_aux2 = fun l -> match l with 
|[] -> ()
| t::q -> (print_int (print_grille_aux t)) ; (print_string " ") ; (print_grille_aux2 q);;

let rec print_grille = fun l -> match l with
|[] -> ()
|t::q -> (print_grille_aux2 t) ; (print_newline ()) ; (print_grille q);;

let rec map_grille_aux = fun i -> fun g -> match g with
[] -> []
|t::q-> if i = 0 then t else map_grille_aux (i-1) q;;

let rec map_grille_aux2 = fun j -> fun l -> match l with 
[] -> []
|t::q -> if j = 0 then t else map_grille_aux2 (j-1) q;;

let map_grille_aux3 = fun i -> fun j -> fun g -> (map_grille_aux2 j (map_grille_aux i g));;

let map_grille_aux4 = fun f -> fun i -> fun j -> fun g -> (f i j (map_grille_aux3 i j g));;

let rec map = fun f -> fun i -> fun j -> fun g -> if j=8 then (map_grille_aux4 f i 8 g) :: [] 
else 
(map_grille_aux4 f i j g) :: (map f i (j+1) g);; 

let rec map_grille2 = fun f -> fun i -> fun j -> fun g -> if i = 8 then (map f 8 j g) :: [] 
else
(map f i j g ) :: (map_grille2 f (i+1) j g);;

let map_grille = fun f -> fun g -> (map_grille2 f 0 0 g);;

let build_grille = fun g ->
map_grille ( fun _ -> fun _ -> fun c ->
match c with
[ ] -> [1;2;3;4;5;6;7;8;9]
| [x] -> [x]
| _ -> failwith " Grille   incorrect "
) g;;
let grille_test_incomplete = [
[[1]; [ ]; [ ]; [8]; [3]; [ ]; [ ]; [ ]; [2]];
[[5]; [7]; [ ]; [ ]; [ ]; [1]; [ ]; [ ]; [ ]];
[[ ]; [ ]; [ ]; [5]; [ ]; [9]; [ ]; [6]; [4]];
[[7]; [ ]; [4]; [ ]; [ ]; [8]; [5]; [9]; [ ]];
[[ ]; [ ]; [3]; [ ]; [1]; [ ]; [4]; [ ]; [ ]];
[[ ]; [5]; [1]; [4]; [ ]; [ ]; [3]; [ ]; [6]];
[[3]; [6]; [ ]; [7]; [ ]; [4]; [ ]; [ ]; [ ]];
[[ ]; [ ]; [ ]; [6]; [ ]; [ ]; [ ]; [7]; [9]];
[[8]; [ ]; [ ]; [ ]; [5]; [2]; [ ]; [ ]; [3]]];;

let grille_test = build_grille grille_test_incomplete ;;

type coord = int *int;;
type iter = int -> int -> int -> coord;;

let get = fun g -> fun i -> fun j -> (map_grille_aux2 j (map_grille_aux i g));;


let retire_valeur_cases = fun g -> fun (l,m) -> fun acc -> 
match get g l m with 
|[] -> acc
|t::[] -> (List.filter (fun q -> if q=t then false else true) acc)
|t1::t2::q -> acc ;;

let retire_valeur_cases_it = fun g -> fun (i,j) -> fun acc -> fun it -> fun k -> 
  let (l,m) = (it (i,j) k) in 
  if (i,j) = (l,m) then acc
  else retire_valeur_cases g (l,m) acc;;

let rec retire_valeur_cases_it_app_aux = fun g -> fun (i,j) -> fun acc -> fun it -> fun k ->
if k = 1 then retire_valeur_cases_it g (i,j) acc it 1
  else 
  (retire_valeur_cases_it g (i,j) (retire_valeur_cases_it_app_aux g (i,j) acc it (k-1)) it k);;
  
let retire_valeur_cases_it_app = fun g -> fun (i,j) -> fun acc -> fun it ->
match (get g i j) with
|[]->[]
|t::[]-> t::[]
|t1::t2::q-> retire_valeur_cases_it_app_aux g (i,j) acc it 9 ;;

let iter_all = fun g -> fun (i,j) -> fun acc ->
let x = retire_valeur_cases_it_app g (i,j) acc iter_colonne in
let y = retire_valeur_cases_it_app g (i,j) x iter_ligne in
retire_valeur_cases_it_app g (i,j) y iter_carre;;

let enleve_sur = fun g ->  
let x = (fun i -> fun j -> fun acc -> iter_all g (i,j) acc) in 
(map_grille x g);;

let rec solve_loop = fun g -> fun n ->
  if n = 0 then g
  else
    let g2 = enleve_sur g in
    if g2 = g then g2
    else solve_loop g2 (n - 1);;

let solve_grid = fun g -> solve_loop g 100;;

let () =
  print_endline "Grille test resolue :";
  print_grille (solve_grid grille_test);;


