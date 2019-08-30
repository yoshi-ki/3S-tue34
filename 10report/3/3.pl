/* 3.pl */

append([], Y, Y).
append([A|X],Y,[A|Z]) :- append(X,Y,Z).

reverse([],[]).
reverse([X|Y],Z) :- reverse(Y,W), append(W,[X],Z).

concat([],[]).
concat([X|Y],Z) :- concat(Y,W), append(X,W,Z).

