% State: monkey(Pos), box(Pos), status(onfloor/onbox), hasbanana(yes/no)

goal(state(_, _, onbox, yes)).

move(state(P, P, onbox, no), grasp, state(P, P, onbox, yes)).
move(state(P, P, onfloor, no), climb, state(P, P, onbox, no)).
move(state(P, P, onfloor, H), push(P, Q), state(Q, Q, onfloor, H)).
move(state(P, B, onfloor, H), go(P, Q), state(Q, B, onfloor, H)).

solve :- 
  plan(state(door, window, onfloor, no), [state(door, window, onfloor, no)], Moves),
  write('Plan: '), nl, print_moves(Moves).

plan(S, _, []) :- goal(S).
plan(S, Visited, [M|Ms]) :-
  move(S, M, S1),
  \+ member(S1, Visited),
  plan(S1, [S1|Visited], Ms).

print_moves([]).
print_moves([M|Ms]) :- write(M), nl, print_moves(Ms).
