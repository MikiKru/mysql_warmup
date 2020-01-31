-- CTRL + ENTER
-- CTRL + SHIFT + ENTER
-- złączanie tabel
select * from zawodnicy;
select * from trenerzy;

-- JOIN
select
	zawodnicy.*,	-- wszystkie kolumny z tabelki zawodników
    trenerzy.*		-- wszystkie kolumny z tabelki zawodników
from
	zawodnicy 		-- iloczyn kartezjański - każdy z każdym
		join 
	trenerzy;

-- JOIN with ON
select 
	z.*,
    t.*
from
	zawodnicy as z		
		join 
	trenerzy as t
		on (z.kraj = t.kraj);	-- warunkek złączenia rekordów 
								-- -> jeśli true to złączany rekord jest tab wynikowej

-- złącz zawodników wraz z treenrami, jeśli jakiś zawodnik nie posiada trenera 
-- też niech będzie na liści
select 
	z.*,
    t.*
from
	zawodnicy as z		
		left join 				-- złączenie lewostronne
	trenerzy as t
		on (z.kraj = t.kraj);

 -- wypisz wszyskich zawodników wraz z ich trenerami, jeżli jakiś trener 
 -- nie trenuje żadnego zawodnika to niech też będzie na liście wynikowej
 select 
	z.*,
    t.*
from
	zawodnicy as z		
		right join 				-- złączenie prawostronne
	trenerzy as t
		on (z.kraj = t.kraj);

-- full join -> wynikiem będzie suma złączeń prawo i lewostronnych
select 
	z.imie as name,
    z.nazwisko as lastname,
    z.kraj as country,
    t.imie_t as 'coach name',
    t.nazwisko_t as 'coach lastname'
from
	zawodnicy as z		
		 left join 				
	trenerzy as t
		on (z.kraj = t.kraj)
union							-- > suma dwóch zbiorów -> nie zwraca duplikatów
select 
	z.imie,
    z.nazwisko,
    t.kraj,
    t.imie_t,
    t.nazwisko_t
from
	zawodnicy as z		
		 right join 				
	trenerzy as t
		on (z.kraj = t.kraj)
        
-- wypisz trenrów wraz z liczbą trenowanych zawodników































    
    
    
    
    