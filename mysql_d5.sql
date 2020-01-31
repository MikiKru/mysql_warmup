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
		on (z.kraj = t.kraj);
        
-- wypisz trenrów wraz z liczbą trenowanych zawodników
select
	t.imie_t,
    t.nazwisko_t,
    t.kraj,
    ifnull(c.liczba,0) as liczba
from 
	trenerzy as t
		left join
	(select kraj, count(*) as liczba from zawodnicy group by kraj) as c		-- zwraca kraj, count(*)	
		on (t.kraj = c.kraj)
order by 
	c.liczba desc;

-- wypisz liczebność wszystkich ekip narodowych
select
	kraj,
    count(*)
from 
	zawodnicy
group by 
	kraj;
    
select * from skocznie;
select * from zawody;
select * from zawodnicy;

-- wypisz wszyskie skocznie wraz z terminami, w krótych odbyły się na nich zawody, 
-- jeśli jeszcze nie odbyły się na danej skoczni zawody wypisz 'dopiero będą'
select 
	s.miasto, s.kraj_s, s.nazwa, ifnull(z.data, 'dopiero będą') as data 
from 
	skocznie as s
		left join
	zawody as z
		on (s.id_skoczni = z.id_skoczni)
order by 
	z.data desc;



























    
    
    
    
    