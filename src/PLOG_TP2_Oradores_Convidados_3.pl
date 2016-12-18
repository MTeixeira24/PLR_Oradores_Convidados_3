:-use_module(library(clpfd)).


listGenders([S|Speakers], [G|Genders],SpeakerInfo) :-
        table([[S,_,G,_,_]],SpeakerInfo),
        listGenders(Speakers, Genders, SpeakerInfo).
listGenders([],[],_).

checkSpeeches(Speakers, [CS|ChoosenSubjects], SubjectSpeakers) :-
        table([LS], SubjectSpeakers),
        element(1,LS, CS),
        element(_,LS,A),
        element(_,Speakers, B),
        B#=A,
        checkSpeeches(Speakers, ChoosenSubjects, SubjectSpeakers).
checkSpeeches(_,[],_).

getDistanceList([C|ChoosenSubjects], SubjectDistance, [Distance|DistanceList]) :-
        getSubDistances(C, ChoosenSubjects, SubjectDistance,Distances),
        sum(Distances, #=, Distance),
        getDistanceList(ChoosenSubjects, SubjectDistance, DistanceList).
getDistanceList([],_,[]).

getSubDistances(C, [CC|ChoosenSubjects], SubjectDistance,[D|Distances]) :-
        table([[C,CC,D]], SubjectDistance),
        getSubDistances(C, ChoosenSubjects, SubjectDistance, Distances).
getSubDistances(_,[],_,[]).

guest_speakers(NTalks, Budget, Speakers, ChoosenSubjects) :-
       length(Speakers, NTalks),
       length(ChoosenSubjects, NTalks),
       SubjectSpeakers = [ 
                            [1,1,2,3], %%Subject Id, Speakers
                            [2,6],
                            [3,2,4,5,6],
                            [4,1,4],
                            [5,2,3,5],
                            [6,5,6],
                            [7,3],
                            [8,2,5],
                            [9,3,4,5]
                         ],
       SubjectDistance = [
        [1,2,1],  %%Subject 1, Subject 2, Distance
        [1,3,1],
        [1,4,1],
        [1,5,1],
        [1,6,1],
        [1,7,1],
        [1,8,1],
        [1,9,1],
        [2,3,71],
        [2,4,88],
        [2,5,24],
        [2,6,25],
        [2,7,60],
        [2,8,24],
        [2,9,84],
        [3,4,62],
        [3,5,37],
        [3,6,15],
        [3,7,17],
        [3,8,61],
        [3,9,63],
        [4,5,55],
        [4,6,82],
        [4,7,57],
        [4,8,21],
        [4,9,37],
        [5,6,64],
        [5,7,93],
        [5,8,82],
        [5,9,34],
        [6,7,45],
        [6,8,14],
        [6,9,26],
        [7,8,21],       
        [7,9,62],
        [8,9,1500000]
                         ],
       SpeakerInfo = [
                        [1,2,0,5,1], %%Id,Distance,Gender,Nights,FirstClass
                        [2,3,1,1,0], %% 0 = Male, 1 = Female
                        [3,5,1,3,1],
                        [4,5,0,5,0],
                        [5,3,0,2,0],
                        [6,8,1,5,0]
                        ],
        domain(Speakers, 1, 6),
        domain(ChoosenSubjects,1,9),
        all_distinct(Speakers),
        listGenders(Speakers, Genders,SpeakerInfo),
        global_cardinality(Genders,[0-Males,1-Females]),
        Males #= Females,
        all_distinct(ChoosenSubjects),
        checkSpeeches(Speakers, ChoosenSubjects, SubjectSpeakers),
        getDistanceList(ChoosenSubjects, SubjectDistance, DistanceList),
        sum(DistanceList, #=, TotalDistance),
        labeling([maximize(TotalDistance)], ChoosenSubjects)
        .
