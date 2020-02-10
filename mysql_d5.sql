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
	s.miasto, s.kraj_s, s.nazwa, ifnull(z.data, 'dopiero będą') as data_z 
from 
	skocznie as s
		left join
	zawody as z
		on (s.id_skoczni = z.id_skoczni)
order by 
	data_z = 'dopiero będą', z.data;

-- obok imienia i nazwisko skoczka wypisz nazwę jego skoczni domowej
select 
	z.imie, z.nazwisko, z.kraj, s.nazwa
from 
	zawodnicy as z
		left join
	skocznie as s
		on (s.kraj_s = z.kraj)
order by 
	kraj;

-- wypisz pary zawodników typu każdy z każdym, ale 
-- zawodnik nie może być w parze sam ze sobą
-- nie uwzględniamy par w odwrotnej kolejności tj, z1 - z2 to samo co z2 - z1
select
	z1.imie, z1.nazwisko, z2.imie, z2.nazwisko
from
	zawodnicy as z1
		join 
	zawodnicy as z2
where    
	z1.id_skoczka > z2.id_skoczka;


-- wodok -> to wynik zapytania osadzony w 'wirtualnej' tabelce 
create or replace view zawodnicy_trenerzy as 	-- definicja widoku
select 											-- > ciało widoku
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
union							
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
		on (z.kraj = t.kraj);					-- < ciało widoku

-- wywołanie wyidoku
select * from zawodnicy_trenerzy  order by country;



















    
    
    
    
    