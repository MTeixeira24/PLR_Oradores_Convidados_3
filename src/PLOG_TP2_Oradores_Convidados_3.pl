:-use_module(library(clpfd)).
:-use_module(library(lists)).

listGenders([S|Speakers], [G|Genders],SpeakerInfo) :-
        member(S-L,SpeakerInfo),
        nth1(3,L,G),
        listGenders(Speakers, Genders, SpeakerInfo).
listGenders([],[],_).

guest_speakers(NTalks, Budget, Speakers) :-
       length(Speakers, NTalks),
       length(ChoosenSubjects, NTalks),
       SubjectSpeakers = [
                            1-'Topic1'-[1,2,3], %%Subject Id, Subject Name, Speakers
                            2-'Topic2'-[6],
                            3-'Topic3'-[2,4,5,6],
                            4-'Topic4'-[1,4],
                            5-'Topic5'-[2,3,5],
                            6-'Topic6'-[5,6],
                            7-'Topic7'-[3],
                            8-'Topic8'-[2,5],
                            9-'Topic9'-[3,4,5]
                         ],
       SubjectDistance = [
                            1-2-97,
                            1-3-17,
                            1-4-39,
                            1-5-99,
                            1-6-45,
                            1-7-32,
                            1-8-46,
                            1-9-25,
                            2-3-71,
                            2-4-88,
                            2-5-24,
                            2-6-25,
                            2-7-60,
                            2-8-24,
                            2-9-84,
                            3-4-62,
                            3-5-37,
                            3-6-15,
                            3-7-17,
                            3-8-61,
                            3-9-63,
                            4-5-55,
                            4-6-82,
                            4-7-57,
                            4-8-21,
                            4-9-37,
                            5-6-64,
                            5-7-93,
                            5-8-82,
                            5-9-34,
                            6-7-45,
                            6-8-14,
                            6-9-26,
                            7-8-21,
                            7-9-62,
                            8-9-15
                         ],
       SpeakerInfo = [
                        1-['Speaker1','USA',0,5,1], %%Id-[Name,Country,Gender,Nights,FirstClass]
                        2-['Speaker2','France',1,1,0], %% 0 = Male, 1 = Female
                        3-['Speaker3','Spain',1,3,1],
                        4-['Speaker4','Germany',0,5,0],
                        5-['Speaker5','Poland',0,2,0],
                        6-['Speaker6','China',1,5,0]
                        ],
        CountriesDistance = [
                            'Spain'-2,
                            'France'-3,
                            'Poland'-5,
                            'Germany'-5,
                            'China'-8 
                             ],
        domain(Speakers, 1, 6),
        domain(ChoosenSubjects,1,9),
        all_distinct(Speakers),
        listGenders(Speakers, Genders,SpeakerInfo),
        global_cardinality(Genders,[0-Males,1-Females]),
        Males #= Females,
        all_distinct(ChoosenSubjects)
        .
