:-use_module(library(clpfd)).

listGenders([S|Speakers], [G|Genders],SpeakerInfo) :-
        element(S,SpeakerInfo, _-L),
        element(3,L,G),
        listGenders(Speakers, Genders, SpeakerInfo).
listGenders([],[],_).
guest_speakers(NTalks, Budget, ChoosenSubjects) :-
       length(Speakers, NTalks),
       SubjectSpeakers = [
                            t1-[1,2,3],
                            t2-[6],
                            t3-[2,4,5,6],
                            t4-[1,4],
                            t5-[2,3,5],
                            t6-[5,6],
                            t7-[3],
                            t8-[2,5],
                            t9-[3,4,5]
                         ],
       SpeakerInfo = [
                        1-['name','USA',0,5,1], %%Id-[Name,Country,Gender,Nights,FirstClass]
                        2-['name','France',1,1,0], %% 0 = Male, 1 = Female
                        3-['name','Spain',1,3,1],
                        4-['name','Germany',0,5,0],
                        5-['name','Poland',0,2,0],
                        6-['name','China',1,5,0]
                        ],
        CountriesDistance = [
                            'Spain'-2,
                            'France'-3,
                            'Poland'-5,
                            'Germany'-5,
                            'China'-8 
                             ],
        domain(Speakers, 1, 6),
        all_distinct(Speakers),
        listGenders(Speakers, Genders,SpeakerInfo),
        global_cardinality(Genders,[0-Males,1-Females]),
        Males #= Females.
