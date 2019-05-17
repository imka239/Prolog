tree(number, atom, tree, tree).
print_tree(null) :- !.
print_tree(tree(K, V, L, R)) :-
	print_tree(L),
	write(K), write(V), nl,
	print_tree(R).


count([], 0).
count([_ | T], R) :- count(T, TR), R is TR + 1.

concat([], B, B).
concat([H | T], B, [H | R]) :- concat(T, B, R).

mega_build([], [], null) :- write(1), nl, !.
mega_build([], [(K1, V1)], tree(K1, V1, null, null)):- write(2), nl, !.
mega_build([], [(K1, V1) | Map], tree(K, V, L, R)) :-
    write(3), nl,
    mega_build([(K1, V1)], Map, tree(K, V, L, R)), !.
mega_build(T, [(K1, V1) | Map], tree(K, V, L, R)):-
    concat(T, [(K1, V1)], NewT),
    count(NewT, L1), count(Map, L2), L1 >= L2, write(5), nl,K is K1, V = V1,
    mega_build([], T, L),
    mega_build([], Map, R), !.
mega_build(T, [(K1, V1) | Map], tree(K, V, L, R)):-
    concat(T, [(K1, V1)], NewT),
    write(NewT), nl,
    mega_build(NewT, Map, tree(K, V, L, R)).

tree_build(Map, Tree) :- mega_build([], Map, Tree).


map_get(tree(K, V, _, _), K, V) :- !.
map_get(tree(Key, _, L, _), K, V) :-
    K < Key, map_get(L, K, V).
map_get(tree(Key, _, _, R), K, V) :-
    K > Key, map_get(R, K, V).
