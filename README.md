# Solveur de Sudoku

Ce projet contient un solveur de Sudoku ecrit en **OCaml**.
Le programme manipule une grille 9x9, elimine les valeurs impossibles a partir des contraintes classiques du Sudoku, puis affiche la grille resolue dans le terminal.

Le fichier principal du projet est [Sudoku.ml](/Users/samirgueblaoui/Desktop/Ocaml2/Ocaml/Sudoku.ml).

## Fonctionnement

Chaque case de la grille est representee par une liste d'entiers :

- une case deja connue est representee par une liste contenant une seule valeur, par exemple `[5]`
- une case vide est transformee en liste de possibilites `[1;2;3;4;5;6;7;8;9]`

Le solveur applique ensuite une reduction progressive :

- suppression des valeurs deja presentes sur la meme ligne
- suppression des valeurs deja presentes dans la meme colonne
- suppression des valeurs deja presentes dans le meme carre 3x3

Cette operation est repetee jusqu'a stabilisation de la grille, ou jusqu'a atteindre la limite de boucle prevue dans le code.

## Contenu du projet

- [Sudoku.ml](/Users/samirgueblaoui/Desktop/Ocaml2/Ocaml/Sudoku.ml) : code source principal
- [.gitignore](/Users/samirgueblaoui/Desktop/Ocaml2/Ocaml/.gitignore) : fichiers generes ignores par Git

## Prerequis

Il faut avoir **OCaml** installe sur la machine.

Par exemple, pour verifier l'installation :

```sh
ocaml -version
```

## Compilation

Depuis la racine du projet :

```sh
ocamlc -o programme Sudoku.ml
```

## Execution

Une fois compile :

```sh
./programme
```

Entrez ensuite les 9 lignes de votre grille. Chaque ligne doit contenir
9 chiffres : `1` a `9` pour les cases connues, `0` ou `.` pour les cases vides.
Les espaces sont facultatifs. Par exemple, vous pouvez saisir ou coller :

```text
100830002
570001000
000509064
704008590
003010400
051400306
360704000
000600079
800052003
```

Une ligne mal formee ou contenant un doublon dans une ligne, une colonne
ou un carre 3x3 est redemandee.

Le solveur utilise l'elimination de candidats, sans recherche par essais.
Si cela ne suffit pas, il affiche une resolution partielle avec `0` pour les
cases encore indeterminees. Une contradiction detectee est signalee.

## Exemple de sortie

```text
Grille resolue :
1 4 9 8 3 6 7 5 2
5 7 6 2 4 1 9 3 8
2 3 8 5 7 9 1 6 4
7 2 4 3 6 8 5 9 1
6 8 3 9 1 5 4 2 7
9 5 1 4 2 7 3 8 6
3 6 2 7 9 4 8 1 5
4 1 5 6 8 3 2 7 9
8 9 7 1 5 2 6 4 3
```

## Structure generale du code

Le programme est organise autour de quelques idees simples :

- `build_grille` initialise les cases vides avec toutes les possibilites
- `get` recupere le contenu d'une case
- `iter_colonne`, `iter_ligne` et `iter_carre` permettent de parcourir les zones de contrainte
- `retire_valeur_cases_it_app` elimine les valeurs impossibles
- `enleve_sur` applique cette reduction a toute la grille
- `solve_grid` repete le processus jusqu'a stabilisation

