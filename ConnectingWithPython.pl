% Advise M.Tech Student the career according to his/her experience in Field


topic(ai) :- assert(topics('robotics')),assert(topics('artificial intelligence')),
assert(topics('machine learning')),assert(topics('data mining')),
assert(topics('advanced machine learning')), assert(topics('data analytics')).

topic(de) :- assert(topics('languages processing')),assert(topics('data analytics')),
assert(topics('training machines')),assert(topics('data mining')),
assert(topics('advanced machine learning')),assert(topics('algorithms')).

topic(mc) :- assert(topics('mobile or cloud computing')),assert(topics('machine learning')),
assert(topics('data mining')),assert(topics('deep learning')),
assert(topics('advanced machine learning')),assert(topics('image processing')).

topic(is) :- assert(topics('internet security')),assert(topics('training machines')),
assert(topics('data mining')),assert(topics('deep learning')),
assert(topics('Cryptography')),assert(topics('computer visions')).

topic(ws) :- assert(topics('compilers')),assert(topics('artificial intelligence')),
assert(topics('training machines')),assert(topics('image processing')),
assert(topics('Cryptography')),assert(topics('computer visions')).

recommended('robotics'):- assert(recommend('AI Applied Scientist')).
recommended('algorithms'):- assert(recommend('Software developer')).
recommended('deep learning') :- assert(recommend('DL Scientist')).
recommended('languages processing') :- assert(recommend('NLP Scientist')).
recommended('artificial intelligence') :- assert(recommend('AI Applied Scientist')).
recommended('training machines') :- assert(recommend('ML Scientist')).
recommended('data analytics') :- assert(recommend('Data Analyst')).
recommended('data mining') :- assert(recommend('Data Scientist')).
recommended('mobile or cloud computing') :- assert(recommend('Cloud Computing Engineer')).
recommended('machine learning') :- assert(recommend('ML Scientist')).
recommended('internet security') :- assert(recommend('Information Security Associate')).
recommended('Cryptography') :- assert(recommend('Ethical Hecking Profile')).
recommended('compilers') :- assert(recommend('Compiler Designs Engineer')).
recommended('image processing') :- assert(recommend('DL scientist')).
recommended('computer visions') :- assert(recommend('Computer Visions Analyst')).
recommended('advanced machine learning') :- retractall(recommend('ML Scientist')), assert(recommend('Expert Machine Learning Scientist')). 


subject(_, 0):- !.
subject(D, Z) :- topic(D), retract(topics(X)), recommended(X), C is Z-1, subject(D, C). 


suggest(X, Result) :- retractall(topics(_)), subject(X, 6),careerfor(X, Result), !.

careerfor(_, Result) :- convert_to_list(List), remove_duplicates(List,Result).

convert_to_list([Px|Tail]):- retract(recommend(Px)), convert_to_list(Tail), !.
convert_to_list([]).

remove_duplicates([], []).
remove_duplicates([Head | Tail], Result) :- member(Head, Tail),!, remove_duplicates(Tail,Result).
remove_duplicates([Head | Tail], [Head | Result]) :- remove_duplicates(Tail, Result).


suggest():-consult('/Users/deepankar/Desktop/PycharmProjects/OOPD/careers.txt'), interested_in(Y),
write('Your interest is in '), write(Y), nl, write('Suggested careers are:'), nl, suggested_careers(X), write(X), nl.

