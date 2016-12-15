:-use_module(library(clpfd)).

test :- write('Hello world').

distance([_,_|[]],0).
distance([A,B,C|List], Distance):-
        Aux #= abs(B-A)/abs(C-B),
        Distance #= abs(B-A) + DR,
        Aux #> 0.8,
        Aux #< 1.2,
        distance([B,C|List],DR).



guest_speakers(NTalks, Budget, ChoosenSubjects) :-
       Subjects = [s1-1,s2-2,s3-3,s4-4,s5-5,s6-6,s7-7,s8-8,s9-9],
       length(ChoosenSubjects, NTalks),
       domain(ChoosenSubjects,1,9),
       all_distinct(ChoosenSubjects),
       length(SortedSubjects, NTalks),
       length(Aux, NTalks),
       sorting(ChoosenSubjects, Aux, SortedSubjects),
       distance(SortedSubjects,Distance),
       labeling([maximize(Distance)],ChoosenSubjects).