% Graph: edge(Node, Next).
edge(a, b). edge(a, c).
edge(b, d). edge(c, d).
edge(d, e). edge(c, f).

% Heuristic values
h(a, 5). h(b, 3). h(c, 2). h(d, 1). h(e, 0). h(f, 4).

% Best First Search
bestfs(Start, Goal, Path) :- bfs([[Start]], Goal, Path).

bfs([[Goal|Rest]|_], Goal, [Goal|Rest]).
bfs([Path|Paths], Goal, FinalPath) :-
    Path = [Node|_],
    findall([Next|Path],
        (edge(Node, Next), \+ member(Next, Path)),
        NewPaths),
    append(Paths, NewPaths, Temp),
    sort_paths(Temp, Sorted),
    bfs(Sorted, Goal, FinalPath).

sort_paths(Paths, Sorted) :-
    map_list_to_pairs(path_cost, Paths, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_values(SortedPairs, Sorted).

path_cost([Node|_], H) :- h(Node, H).
