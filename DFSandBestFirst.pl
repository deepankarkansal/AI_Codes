assertFacts :- csv_read_file('Desktop/AI-A2-DeepankarKansal-MT20007/distances.csv', Data, [functor(distance)]), maplist(assert, Data).


distance2(X,Y,D) :- distance(X,Y,D).
distance2(X,Y,D) :- distance(Y,X,D).

next_node(Current, Next, Path, Cost) :- distance2(Current, Next, Cost), not(member(Next, Path)).

print_list([]) :- write(' Goal Reached...'),nl. 
print_list([H|T]):- write(H), write(' -> '),print_list(T).

depth_first(Goal, Goal, C, [Goal], Cost) :- nl,write('Cost for the following path is : '),write(Cost),nl,nl, reverse(C, C1), print_list(C1),nl.
depth_first(Start, Goal, Visited, [Start|Path], Cst) :- next_node(Start, Next_node, Visited, Cost), MCst is Cst+Cost,
depth_first(Next_node, Goal, [Next_node|Visited], Path, MCst).


dfs( Start, Goal, Path) :- depth_first( Start, Goal, [Start], Path, 0).



assertFacts1 :- csv_read_file('Desktop/AI-A2-DeepankarKansal-MT20007/hueristics.csv', Data, [functor(hueristic)]), maplist(assert, Data).


hueristic_min(Current, Next, Goal, Cost) :- aggregate(min(Cost, Next), hueristic(Current,Next,Goal,Cost), min(_, Next)).

next_node1(Current, Next, Goal, Path, Cost) :- hueristic_min(Current, Next, Goal, _), distance2(Current, Next, Cost), not(member(Next, Path)).


best_first(Goal, Goal, C, [Goal], Cost) :- nl,write('Cost for the following path is : '),write(Cost), nl,nl, reverse(C, C1), print_list(C1),nl.
best_first(Start, Goal, Visited, [Start|Path], Cst) :- next_node1(Start, Next_node, Goal, Visited, Cost), MCst is Cst+Cost,
best_first(Next_node, Goal, [Next_node|Visited], Path, MCst).


best_first_search( Start, Goal, Path) :- best_first( Start, Goal, [Start], Path, 0).


assertAll :- assertFacts, assertFacts1.

options(X, Z) :-  nl, write('What you want to apply (d for Depth First, b for Best First)?'), nl,
	read(Y),((Y == b, best_first_search(X, Z, Path)) | dfs(X, Z, Path)).




