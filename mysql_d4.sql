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

    
    
    
    
    