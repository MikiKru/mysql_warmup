-- do danych o zawodnikach dodaj ich indeks bmi = waga[kg]/(wzrost[m]^2) zaokrąglone do 1 miejsca po przecinku
select *, round(waga/power(wzrost/100,2),1) as bmi from zawodnicy;

-- sprawdz wartośc indeksu bmi 
-- bmi < 19 					- poniżej normy 
-- bmi w przedziale <19,21> 	- w normie
-- bmi > 21						- ponad normę

select 
	*, 
    round(waga/power(wzrost/100,2),1) as bmi,
    case 
		when waga/power(wzrost/100,2) < 19 					then 'poniżej normy'
        when waga/power(wzrost/100,2) between 19 and 21 	then 'w normie'
		else 													 'powyżej normy'
    end as opis_1,
    if(waga/power(wzrost/100,2) < 19, 
		'poniżej normy',	
        if(waga/power(wzrost/100,2) between 19 and 21,
			'w normie',
            'powyżej normy')
	) as opis_2
from 
	zawodnicy;
    
 -- utworzenie własnej funkcji
create function bmi(waga int, wzrost int)		-- nazwa_funkcji([argumenty])
	returns double(5,2) deterministic			-- typ zwracanej wartości
    return round(waga/power(wzrost/100,2),2);	-- ciało funkcji
    
select *, bmi(waga, wzrost) as bmi from zawodnicy;

-- utwórz funkcję sprawdzająca wartośc indeksu bmi 
-- bmi < 19 					- poniżej normy 
-- bmi w przedziale <19,21> 	- w normie
-- bmi > 21						- ponad normę
    
create function bmi_check(waga int, wzrost int)
	returns varchar(15) deterministic
    return if(bmi(waga,wzrost) < 19, 
					'poniżej normy', 
                    if(bmi(waga,wzrost) between 19 and 21, 
						'w normie', 
						'powyżej normy')
	);
-- drop function bmi_check;

select 
	*, 
    bmi(waga, wzrost) as bmi, 
    bmi_check(waga, wzrost) as bmi_check 
from 
	zawodnicy;
    
select * from trenerzy;
select * from titanic;

-- zastąp null wartośćią N/A dla kolumny cabin, embarked w tabeli titanic
select
	name, 
    ifnull(cabin,'N/A') as cabin,				-- zastępuje null wartości podaną w drugim argumencie
    coalesce(embarked, 'N/A') as embarked
from 
	titanic;
    
-- sortowanie po wartości bmi max-min 
select 
	*,
	bmi(waga,wzrost) as bmi
from 
	zawodnicy
order by
	bmi desc;
-- zgrupuj zawodników w kadry narodowe, a w ramach tech kad posortuj ich po nazwisku A-Z
select
	*
from 
	zawodnicy
order by
	kraj asc, 
    nazwisko asc;

-- zgrupuj zawodników w kadry narodowe, a w ramach tech kad posortuj ich po nazwisku A-Z 
-- ale nie uwzględniaj Niemców
select
	*
from 
	zawodnicy
where 
	kraj != 'ger'
order by
	kraj asc, 
    nazwisko asc;

-- posortuj trenerów trenerzy po dacie urodzenia asc, ale trenrzy bez daty urodzenia mają być na końcu
select 
	*
from 
	trenerzy 
order by 
	data_ur_t is not null desc,		 -- 0 lub 1
    data_ur_t asc;
    
-- wypisz drugiego najcięższego zawodnika
select * from zawodnicy order by waga desc limit 1 offset 1;
-- wypisz 10 najstarszych pasażerów na tytaniku i posortuj ich po wieku malejąco
select * from titanic order by age desc, name asc limit 10;
-- wypisz najwyższego zawodnika w kadrze niemiec
select * from zawodnicy where kraj = 'ger' order by wzrost desc limit 1;
select max(wzrost) as max_wzrost from zawodnicy where kraj = 'ger' or kraj = 'aut';

-- jaka jest wartość drugiego z kolei wzrostu wśród zawodników, jeśli jest kilku zawodników posiadających 
-- tą wartośc to wypisz ich wszystkich
set @second_max_height = (select distinct wzrost from zawodnicy order by wzrost desc limit 1 offset 1);

select 
	* 
from 
	zawodnicy
where 
	wzrost = @second_max_height
order by 
	wzrost desc;

INSERT INTO zawodnicy VALUES (20, 'Marian', 'Duży', 'POL', '1982-09-04', 187, 56);
select * from zawodnicy;

-- podzapytania - zapytania zagnieżdżone
select 
	* 
from 
	zawodnicy
where 
	wzrost = (select distinct wzrost from zawodnicy order by wzrost desc limit 1 offset 1)
order by 
	kraj, nazwisko;
    
-- randomizowanie - wprowadzenie losowości
select * from zawodnicy order by rand(); 
select * from zawodnicy order by rand() limit 1; 

-- agregacja

-- wypisz liczebność poszczególnych reprezentacji
select 
	kraj,
    count(*) as repr_count
from 
	zawodnicy
group by 
	kraj
order by 
	repr_count desc;

-- wypisz liczebność poszczególnych reprezentacji ale nie uwzględniaj reprezentacji 
-- mniej licznych niż 3 osoby i niemiec
select 
	kraj,
    count(*) as repr_count
from 
	zawodnicy
where 
	kraj != 'ger'
group by 
	kraj
having 
	repr_count >= 3
order by 
	repr_count desc;

-- jaka jest średni wiek w poszczególnych drużynach narodowych
select 
	kraj, 
    truncate(avg(timestampdiff(YEAR, data_ur, now())),0) as wiek_avg 
from 
	zawodnicy
group by 
	kraj
order by 
	wiek_avg;

-- jaka jest najwyższa wartość bmi w poszczegolnych drużynach narodowych
select
	kraj,
    max(bmi(waga,wzrost)) as max_bmi
from 
	zawodnicy
group by 
	kraj
order by 
	max_bmi desc;

-- ilu jest zawodników w poszczególnych drużynach narodowych wyższych od małysza, jeśli nikt wypisz zero
select 
	kraj,
    count(*) as upper_malysz_count
from 
	zawodnicy
where 
	wzrost > (select wzrost from zawodnicy where id_skoczka = 1)
group by
	kraj
order by 
	2 desc;

select * from zawodnicy;

-- sprawdz jaka jest srednia liczebnosc druzyny narodowej
select 
	count(*)/count(distinct kraj) as 'średnia ilość zawodników w drużynie' 
from 
	zawodnicy;
    
    
    
    
    

    
    
    
    
    
    
    
    