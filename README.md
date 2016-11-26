# Oradores Convidados


* PROBLEM         

Taken from the second pratical assignment statment:

Uma  conferência  científica,  a  realizar  ao  longo  de  D  dias  numa  determinada  cidade,  tem  um conjunto  de  oradores  convidados,  que  falam  
sobre  temas  relacionados  com  a  conferência, cobrindo  um  leque  de tópicos  que  se  pretende  o  mais  vasto  possível.  Nesse  sentido,  os 
organizadores  da  conferência  preparam  uma  lista  de  tópicos,  juntamente  com  possíveis oradores para cada tópico.
Na conferência caberão N palestras, em que N é tipicamente menor do que o número de tópicos possíveis.  Os  oradores  a  convidar  têm  que  ser  todos  
de  países  diferentes.  Adicionalmente,  a conferência  promove  igualdade  de  género,  pelo  que  metade  dos  oradores  convidados  deve  ser do 
sexo feminino, e metade do sexo masculino. A organização tem um orçamento limitado para despesas com oradores, que não pode jamais ser ultrapassado.

As  despesas  de  deslocação  e  estadia  de  cada  orador  são  cobertas  pela  organização  da conferência. Para cada orador, a organização estuda 
o custo de deslocação (viagem desde o seu ponto de origem até ao local de realização da conferência, tendo em conta que alguns oradores exigem  viajar  
em  primeira  classe).  A  estadia  terá,  em  princípio,  um  custo  fixo  por  orador. 
Contudo, pode haver casos de oradores que se saiba de antemão  não poderem ficar  na cidade onde vai ocorrer a conferência mais do que uma noite, o 
que faz com que o custo relacionado com o seu alojamento seja menor.
No que toca aos tópicos das palestras, os organizadores elaboraram uma tabela de proximidade, com o  objetivo  de  maximizar  a  “distância”  entre  os  
tópicos  a  abordar.  Por  exemplo,  numa conferência com 2 palestras e 3 tópicos possíveis, uma palestra sobre “Programação em Lógica” cobre  sempre  
aspectos  de  “Lógica  Computacional”,  pelo  que  será  preferível  ter apenas  um destes tópicos como tema central de uma palestra, ficando a outra com 
“Jogos”, pois este é um tópico mais “distante” dos dois tópicos anteriores.
Defina o problema como um problema de satisfação de restrições e resolva-o com PLR, de modo a  que  seja  possível  resolver  problemas  desta  classe  
com  diferentes  parâmetros,  isto  é, diferentes números de palestras, tópicos, oradores possíveis, custos de deslocação/alojamento, orçamento, etc.


* DECOMPOSITION 

An attempt to rewrite the problem in a way that is easier to better visualize the constraints and variables

1) A scientific conference will be hosted for D days.

2) Such conference has a set of guest speakers

3) Each speaker will talk about one subject

4) Two speakers cannot have the same subject to talk about

5) The subjects are prepared beforehand with a list of possible speakers for each subject

6) There is room for N speeches

7) N is typically less than the number of available subjects.

8) The speakers all have to be from different countries

9) Half of the speakers have to be female and the other half male

10) The budget allocated for the speakers must never be exceeded

11)The expenses for transportation and stay of each speaker are covered by the organization

12)The cost of transportation varies from speaker to speaker

13)Some speakers demand to travel first-class

14)The cost for stay may be constant among speakers

15)Should a speaker stay in the city where the conference will be held for more than a night, the cost of stay is reduced

16) =TOCONTINUE=  


* DOMINION/VARIABLES

Identification of possible variables and their corresponding dominion

* CONSTRAINTS

A more formal writing of the constraints that the variables shall have to abide
