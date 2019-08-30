/* 1.pl */
male(kobo).
male(koji).
male(iwao).
male(taro).

female(sanae).
female(mine).
female(miho).
female(hanako).

parent(miho, koji).
parent(miho, sanae).
parent(kobo, koji).
parent(kobo, sanae).
parent(sanae, iwao).
parent(sanae, mine).

father(X, Y) :- parent(X, Y), male(Y).
mother(X, Y) :- parent(X, Y), female(Y).

sibling(X, Y) :- father(X, Z), father(Y,Z), mother(X,W), mother(Y,W).

grandparent(X, Z) :- parent(X,Y),parent(Y,Z).

ancestor(X,Y) :- ancestor(Z,Y), parent(X,Z). 
ancestor(X,Y) :- parent(X,Y).

bloodrelative(X,Y) :- ancestor(X,Y).
bloodrelative(X,Y) :- ancestor(Y,X).
bloodrelative(X,Y) :- ancestor(X,Z), ancestor(Y,Z).
