/*3.pl*/

append([], Y, Y).
append([A|X],Y,[A|Z]) :- append(X,Y,Z).

three_line(P,[P,P,P,_,_,_,_,_,_]).
three_line(P,[P,_,_,P,_,_,P,_,_]).
three_line(P,[_,P,_,_,P,_,_,P,_]).
three_line(P,[_,_,P,_,_,P,_,_,P]).
three_line(P,[_,_,_,P,P,P,_,_,_]).
three_line(P,[_,_,_,_,_,_,P,P,P]).
three_line(P,[P,_,_,_,P,_,_,_,P]).
three_line(P,[_,_,P,_,P,_,P,_,_]).

/*終局であればtrue*/
end([]).
end([1|A]) :- end(A).
end([2|A]) :- end(A).

/*盤面の1と2を入れ替える*/
change([],[]).
change([0|X],Z) :- change(X,Y), append([0],Y,Z).
change([1|X],Z) :- change(X,Y), append([2],Y,Z).
change([2|X],Z) :- change(X,Y), append([1],Y,Z).

/*Pには1とか2が入り、0というundefな場所に自分の駒をおく*/
exist_step(P,B,NEW) :- append(X,[0|Y],B), append(X,[P|Y],NEW).

win(P,B) :- three_line(P,B).
win(P,B) :- change(B,C), \+three_line(P,C), exist_step(P,B,B1), change(B1,B2), lose(P,B2).

/*どっかの手では勝たない*/
exist_and_not_win(P,B) :- exist_step(P,B,B1), change(B1,B2), \+win(P,B2).

lose(P,B) :- change(B,B1), three_line(P,B1).
lose(P,B) :- \+end(B), \+exist_and_not_win(P,B).


