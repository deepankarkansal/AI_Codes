% Advise M.Tech Student the career according to his/her experience in Field

shortkey(X) :- X == ai, write('Artificial Intelligence Field').
shortkey(X) :- X == de, write('Data Engineering Field').
shortkey(X) :- X == is, write('Information Security Field').
shortkey(X) :- X == mc, write('Mobile Computing Field').
shortkey(X) :- X == ws, write('Computer Science Field').


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

stream(X) :- write('Are you interested to work in Artificial Intelligence :'), read(Y), Y == y,
write('Have you done something in research and robotics '), read(Z), Z == y, X = ai.  
stream(X) :- write('Are you interested to work in Data Engineering '), read(Y), Y == y,
write('Have you done something in Data Handling and processing '), read(Z), Z == y, X = de.  
stream(X) :- write('Are you interested to work in Information security Profile '), read(Y), Y == y,
write('Have you done something in internet security and terms like that '), read(Z), Z == y, X = is.  
stream(X) :- write('Are you interested to work in Mobile Computing field '), read(Y), Y == y,
write('Have you done something in clouds and mobile computing '), read(Z), Z == y, X = mc.  
stream(X) :- write('Are you interested to work in Computer Science field '), read(Z), Z == y, X = ws.  


subject(_, 0):- !.
subject(D, Z) :- topic(D), retract(topics(X)),write('Have you done project work in '),write(X), read(Y),(Y==y,recommended(X) | nl),
C is Z-1, subject(D, C). 


suggest() :- retractall(topics(_)), stream(X), subject(X, 6),nl,nl, write('You have done great work in '), shortkey(X),nl,careerfor(X).

careerfor(_) :- convert_to_list(List), remove_duplicates(List,Result), nl, write('You should go for an organisation which provides any of these career paths'),
nl,write(Result).

convert_to_list([Px|Tail]):- retract(recommend(Px)), convert_to_list(Tail), !.
convert_to_list([]).

remove_duplicates([], []).
remove_duplicates([Head | Tail], Result) :- member(Head, Tail),!, remove_duplicates(Tail,Result).
remove_duplicates([Head | Tail], [Head | Result]) :- remove_duplicates(Tail, Result).

