** 'eestinda.hs' muudab t2hed **
- ö -> 8
- ä -> 2
- ü -> y
- õ -> 6

** Kui kasutada flagi --reverse/-r siis muudab t2hed **
- 8 -> ö
- 2 -> ä
- y -> ü
- 6 -> õ 

** Et kompileerida: **
> ghc --make eestinda.hs

** T2psem kasutus **
> Usage: eestinda [--reverse] --input <filename>
>       eestinda [-r] -i <filename>
