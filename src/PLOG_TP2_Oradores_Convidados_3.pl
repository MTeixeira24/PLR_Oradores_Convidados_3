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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getCountries([S|SpeakerInfo], [C|SpeakerInfoCountriesList]) :-
        nth1(1,S,C),
        getCountries(SpeakerInfo, SpeakerInfoCountriesList).
getCountries([],[]).

listCountries([S|Speakers], [C|SpeakerCountries], SpeakerInfoCountriesList) :-
        element(S, SpeakerInfoCountriesList, C1),
        C #= C1,
        listCountries(Speakers, SpeakerCountries, SpeakerInfoCountriesList).
listCountries(_,[],_).

getCosts([LS|SpeakerInfo], [Cost|SpeakerInfoCostsList]) :-
                nth1(1, LS, D),
                nth1(3, LS, N),
                nth1(4, LS, FC),
                Cost is ((100 * D) + (200 * FC) + (150 * N)),
                getCosts(SpeakerInfo, SpeakerInfoCostsList).
getCosts([],[]).
listCost([S|Speakers], [Cost|SpeakerCosts], SpeakerInfoCostsList) :-
        element(S, SpeakerInfoCostsList, Cost),
        listCost(Speakers, SpeakerCosts, SpeakerInfoCostsList).
listCost([],[],_).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
printResult(N, [S|Speakers], [C|SpeakerCountries], [ChS|ChoosenSubjects], SpeakerNames, CountriesNames, Topics) :-
		write(N),
		write(' - '),
		nth1(S, SpeakerNames, Name),
		write(Name),
		nth1(C, CountriesNames, Country),
		write(' ('),
		write(Country),
		write('): *'),
		nth1(ChS, Topics, T),
		write(T),
		write('*;'),
		nl,
		N1 is N + 1,
		printResult(N1, Speakers, SpeakerCountries, ChoosenSubjects, SpeakerNames, CountriesNames, Topics).
printResult(_,[],[],[],_,_,_).

printEnd(NTalks, Males, Females, TotalCost, Budget, TotalDistance) :-
		write('Total number of speakers - '),
		write(NTalks),
		write(' ('),
		write(Males),
		write(' males and '),
		write(Females),
		write(' females)'),
		nl,
		write('Total costs = '),
		write(TotalCost),
		MoneyLeft is Budget - TotalCost,
		write('$ ('),
		write(MoneyLeft),
		write('$ left)'),
		nl,
		write('Total distance between chosen subjects = '),
		write(TotalDistance).

guest_speakers(NTalks, Budget) :-
       
        CountriesNames = ['Portugal',
			'Spain',
			'France',
			'Germany',
			'Ukraine',
			'Russia',
			'China',
			'USA',
			'Canada'],
        SpeakerNames = ['Mauro Raymundo',
			'Melisande Cadieux',
			'Lesya Derkach',
			'Boris Lazarenko',
			'Antoine Franchet',
			'Mary N. Smith',
			'Casandra Mayor',
			'Gary L. Shull',
			'Mattie K. Jordan',
			'Igor Golov',
			'Katharina Fenstermacher',
			'Francisca Mojica',
			'Rafael Martins',
			'Cai Ning'	], 
        Topics = ['The role of engineers in the development of the earth`s resources',
			'Computerixed maintenance management system',
			'Technical design: effective use of machines',
			'Testing and communication in programming efforts',
			'Security in cloud computing masters',
			'Information security management frameworks',
			'What methods are used to develop java applications',
			'Disadvantages to a distributed system',
			'Importance of qa testing during software development process'],
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
                            5,
                            8,
                            1
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
                        [2,1,2,0],
                        [1,0,0,0],
                        [7,1,2,1]
                        ],
        length(Speakers, NTalks),
        length(ChoosenSubjects, NTalks),
        length(Genders, NTalks),
        length(SpeakerCountries, NTalks),
        length(SpeakerCosts, NTalks),
        domain(Speakers, 1, 12),
        domain(ChoosenSubjects,1,9),
        domain(Genders, 0, 1),
        domain(SpeakerCountries,1,9),
        domain(SpeakerCosts,1,Budget),
        all_distinct(Speakers),
        all_distinct(ChoosenSubjects),
        global_cardinality(Genders,[0-Males,1-Females]),
        Males #= Females,
        getGenders(SpeakerInfo, SpeakerInfoGenderList),
        listGenders(Speakers, Genders, SpeakerInfoGenderList),
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        all_distinct(SpeakerCountries),
        getCountries(SpeakerInfo, SpeakerInfoCountriesList),
        listCountries(Speakers, SpeakerCountries, SpeakerInfoCountriesList),
        getCosts(SpeakerInfo, SpeakerInfoCostList),
        listCost(Speakers, SpeakerCosts,SpeakerInfoCostList),
        sum(SpeakerCosts, #=, TotalCost),
        TotalCost #< Budget #\/ TotalCost #= Budget,
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        isSorted(ChoosenSubjects),
        checkSpeeches(Speakers, ChoosenSubjects, SubjectSpeakers),
        getDistanceList(ChoosenSubjects, SubjectDistance, DistanceList),
        sum(DistanceList, #= ,TotalDistance),
        labeling([down,first_fail,maximize(TotalDistance)], ChoosenSubjects),
        nl,
	printResult(1, Speakers, SpeakerCountries, ChoosenSubjects, SpeakerNames, CountriesNames, Topics),
	nl,
	printEnd(NTalks, Males, Females, TotalCost, Budget, TotalDistance).
