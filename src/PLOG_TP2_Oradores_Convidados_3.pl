:-use_module(library(clpfd)).
:-use_module(library(lists)).


getGenders([LS|SpeakerInfo], [G|SpeakerInfoGenderList]) :-
        nth1(2, LS, G),
        getGenders(SpeakerInfo, SpeakerInfoGenderList).
getGenders([],[]).

listGenders([S|Speakers], [G|Genders],SpeakerInfoGenderList) :-
        element(S, SpeakerInfoGenderList, G1),
        G #= G1,
        listGenders(Speakers, Genders, SpeakerInfoGenderList).
listGenders([],[],_).

checkSpeeches([S|Speakers], [CS|ChoosenSubjects], SubjectSpeakers) :-
        element(S, SubjectSpeakers, CS),
        checkSpeeches(Speakers, ChoosenSubjects, SubjectSpeakers).
checkSpeeches(_,[],_).

getDistanceList([C|ChoosenSubjects], SubjectDistance, [Distance|DistanceList]) :-
        member(AuxLength, SubjectDistance),
        length(AuxLength, N),
        N1 is N - 1,
        length(Aux, N1),
        Distances = [C|Aux],
        table([Distances], SubjectDistance),
        getSubDistances(ChoosenSubjects, Distances, DAux),
        sum(DAux, #=, Distance),
        getDistanceList(ChoosenSubjects, SubjectDistance, DistanceList).
getDistanceList([],_,[]).

getSubDistances([Subject|ChoosenSubjects],[Ds|Distances], [D|List]) :-
        element(Subject, Distances, D),
        getSubDistances(ChoosenSubjects, [Ds|Distances], List).
getSubDistances([],_,[]).

isSorted([_]).
isSorted([A,B|List]) :-
        A #< B,
        isSorted([B|List]).


guest_speakers(NTalks, Budget, Speakers, ChoosenSubjects) :-
       
        %%Lists
        %%Speakers >> Topics
        
        SubjectSpeakers = [ 
                            2, %%Index being the speaker and the value the topic
                            1,
                            5,
                            4,
                            3,
                            2,
                            9,
                            7,
                            3,
                            6,
                            4,
                            5
                         ],
       SubjectDistance = [
        [1,0,29,60,3,95,55,29,39,12],%%Line is the subject, Column is other subject, contents are the distance
        [2,0,0,71,88,24,25,60,24,84],
        [3,0,0,0,62,37,15,17,61,63],
        [4,0,0,0,0,55,82,57,21,37],
        [5,0,0,0,0,0,64,93,82,34],
        [6,0,0,0,0,0,0,45,14,26],
        [7,0,0,0,0,0,0,0,21,62],
        [8,0,0,0,0,0,0,0,0,150],
        [9,0,0,0,0,0,0,0,0,0]
                         ],
       SpeakerInfo = [
                        [2,0,5,1], %%Distance,Gender,Nights,FirstClass
                        [3,1,1,0], %% 0 = Male, 1 = Female
                        [5,1,3,1], %%Index number is the id of the speaker
                        [5,0,5,0],
                        [3,0,2,0],
                        [8,1,5,0],
                        [2,1,5,0],
                        [9,0,1,1],
                        [8,1,5,0],
                        [5,0,3,0],
                        [4,1,5,1],
                        [2,1,2,0]
                        ],
        length(Speakers, NTalks),
        length(ChoosenSubjects, NTalks),
        length(Genders, NTalks),
        domain(Speakers, 1, 6),
        domain(ChoosenSubjects,1,9),
        domain(Genders, 0, 1),
        all_distinct(Speakers),
        all_distinct(ChoosenSubjects),
        global_cardinality(Genders,[0-Males,1-Females]),
        Males #= Females,
        getGenders(SpeakerInfo, SpeakerInfoGenderList),
        listGenders(Speakers, Genders, SpeakerInfoGenderList),
        isSorted(ChoosenSubjects),
        checkSpeeches(Speakers, ChoosenSubjects, SubjectSpeakers),
        getDistanceList(ChoosenSubjects, SubjectDistance, DistanceList),
        sum(DistanceList, #= ,TotalDistance),
        labeling([maximize(TotalDistance)], ChoosenSubjects),
        write(TotalDistance).


