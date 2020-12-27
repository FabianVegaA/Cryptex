# Cryptex
In this project, we had as work decode a message written in a cryptex, the program has as input 2 files, one is a table like next.
```csv
word,count
the,23135851162
of,13151942776
and,12997637966
to,12136980858
a,9081174698
in,8469404971
for,5933321709
is,4705743816
```
The other is a file with the message, for example this
```console
1 # I am a comment, do what I say
2 # I am a washing machine, do what I say
3 m i r a x y z a c
4 e l x c v s d o u
5 p e c e s i l l o
6 h m a r g e m m m

```
To decode the message is necessary to rotate each column of the cryptex until find a word, in this case, the message hidden is *"pecesillo"*. One of the problems is that these cryptex have a compartment with an acid highly corrosive that can danger the content of the cryptex. For this is very important to find the word with the least amount of movements.

## File CSV 
You can find this file in the next [link](https://www.kaggle.com/rtatman/english-word-frequency/)

## Thinks about the cryptex
The cryptex is a matrix of `n x m` dimensions 
