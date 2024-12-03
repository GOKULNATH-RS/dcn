:- use_module(library(clpfd)).  % Import the CLP(FD) library for constraint logic programming over finite domains

% Main predicate to find a solution
place_queens(Queens) :-
    length(Queens, 4),             % There will be 4 queens
    Queens ins 1..4,               % Each queen must be in a valid row
    all_different(Queens),         % No two queens in the same column
    safe_diagonals(Queens),        % Ensure queens do not attack diagonally
    label(Queens).                 % Generate solutions

% Ensure that no two queens attack each other diagonally
safe_diagonals([]).
safe_diagonals([Q|Rest]) :-
    safe_diagonals(Rest),
    no_attack(Q, Rest, 1).

% Check for diagonal attacks
no_attack(_, [], _).
no_attack(Q, [Q2|Rest], Dist) :-
    abs(Q - Q2) #\= Dist,         % Queens must not be in the same diagonal
    D1 #= Dist + 1,
    no_attack(Q, Rest, D1).

% Display the solution in a 4x4 grid format
display_board(Queens) :-
    format('  1 2 3 4~n'),
    format('  --------~n'),
    forall(between(1, 4, Row),
           (   format('~d |', [Row]),
               forall(between(1, 4, Col),
                      (   nth1(Row, Queens, Col) ->
                          format(' Q |')
                      ;   format('   |')
                      )),
               nl
           )).

% Query to run the program
solve :-
    place_queens(Queens),
    display_board(Queens).

% Entry point
:- solve.
