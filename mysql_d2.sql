select * from titanic;
describe titanic;

-- ustaw passengerId jako klucz główny z klauzula a_i tabeli titanic 
alter table titanic modify PassengerId int primary key auto_increment;

-- wypisz wszystkich pasażerów, którzy przeżyli katastrofę
select Name, Survived from titanic where Survived = 1; 

-- wypisz ilość pasażerów którzy przeżyli katastrofę
select count(*) as survived_passengers from titanic where Survived = 1;

-- wypisz wszystkich pasażerów z klasy 1
select * from titanic where pclass = 1;

-- wypisz wszystkich pasażerów kótrzy przeżyli katastrofę z klasy 1
select * from titanic where pclass = 1 and survived = 1;

-- *wypisz wszystkie klasy pasażerów dostępna na tytaniku
select distinct pclass from titanic;

-- **wypisz liczebność wszystkich klas 
select pclass, count(*) as quantity from titanic group by pclass; 
select count(*) from titanic;

-- wypisz pasażerów w wieku od 20 do 30 lat
select * from titanic where age between 20 and 30;

-- zmodyfikuj dane w kolumnie cabin tak aby brak wartości był reprezenotowany przez null
update titanic set cabin = null where cabin = '';
update titanic set embarked = null where embarked = '';
select * from titanic;

-- wypisz wszystkich pasażerów bez informacji o porcie 
select * from titanic where embarked is null;

-- wypisz imiona pasażerów wraz z ich ceną za bilety zaokągloną do 2 m-ca po przecinku
select name, round(fare, 2) as fare from titanic;

-- sprawdz jaka jest średnia cena biletu
select round(avg(fare), 2) as fare_avg from titanic;

-- konwersja między systemami
select conv(5, 10, 2), conv(15, 10, 2);
select conv(7, 10, 16), conv(16, 10, 16), conv(21, 10, 16), conv(29, 10, 16), conv(32, 10, 16), conv(124, 10, 16);
select conv('7C', 16, 10), conv('7C', 16, 2);

-- wykorzystanie funkcji napisowych
select upper(name) as name, lower(ticket) as ticket from titanic;

-- funkcje szyfrujące 
select 'qwe123' as password, md5('qwe123'), md5('qwe122') as encrypted_password;
select 'qwe123' as password, sha('qwe123') as encrypted_password;

-- wypisz wszystkich pasażerów, ale w komumnie sex niech pierwa litera będzie wielka Male, Female 
select 
	concat(upper(substring(sex, 1, 1)), lower(substring(sex, 2, length(sex) - 1))) as sex 
from 
	titanic;

-- *niech kolumna sex rozpoczyna się i kończy wielką literą reszta liter ma być jak w zdaniu
-- MalE / FemalE
select 
	concat(
		upper(mid(sex, 1, 1)),						-- X	pierwsza
        lower(mid(sex, 2, length(sex) - 2)),		-- xxxx	od drugiej do przedostatniej
        upper(mid(sex, length(sex), 1))) as sex		-- X	ostania
from 
	titanic;

-- *niech kolumna sex zwraca tylko pierwszą literę i tyle * ile jest kolejnych liter w zdaniu
-- M*** / F*****
select
	concat(
		upper(mid(sex, 1, 1)),						-- X 	pierwsza
        repeat('*', length(sex) - 1)				-- ***	* powtórzona tyle razy jak długi jest ciąg - 1
    ) as sex
from 
	titanic;

-- porównanie za pomocą like - wypisz pasażerów których nazwisko zaczyna się na literę c
select * from titanic where 'C' = upper(substring(name,1,1)); 
select * from titanic where name like 'C%'; 
select * from titanic where upper(name) like 'C%' and upper(name) like '%A'; 











