/* 4.pl */

append([], Y, Y).
append([A|X],Y,[A|Z]) :- append(X,Y,Z).

/*judge whether X is included in V*/
vertexin(X,[X|_]).
vertexin(X,[_|V]) :- vertexin(X,V).

/*search edges that starts with A return B; end of the edge*/
edges(A,[[A|[B]]|_],B).
edges(A,[_|Z],B) :- edges(A,Z,B).
/*edges(A,[_|Y],Z) :- edges(A,Y,Z).*/

/*pick out a vertex X from a vertex set V*/
pick(X,[X|R],R).
pick(X,[A|R],V) :- pick(X,R,W), append(W,[A],V).

/*search hamilton path that starts with A; rest vertex is V*/
/*return R which represent the next rest vertex*/
search(_,_,[]).
search(A,E,V) :- edges(A,E,B), pick(B,V,R), search(B,E,R).

hamilton([],[]).
hamilton(V,E) :- vertexin(Z,V), pick(Z,V,R), search(Z,E,R).

