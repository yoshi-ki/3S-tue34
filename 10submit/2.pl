/* 2.pl */
add(z,Y,Y).
add(s(X),Y,s(Z)) :- add(X,Y,Z).

mult(z,_,z).
/*does not stop*/
/*mult(s(X),Y,W) :- mult(X,Y,Z), add(Z,Y,W).*/
/*does not stop*/
/*mult(s(X),Y,W) :- add(Z,Y,W), mult(X,Y,Z).*/
/*stop*/
mult(s(X),Y,W) :- add(Y,Z,W), mult(X,Y,Z).



