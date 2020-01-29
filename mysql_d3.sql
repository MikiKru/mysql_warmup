select * from zawodnicy;
-- xx.xx.xxxxr.
select 
	imie, 
	nazwisko, 
    date_format(data_ur, '%d.%m.%Yr.') as data_ur 
from 
	zawodnicy;
-- sforamtuj date urodzenia zawodnika następująco: dzień_cyfra (nazwa dnia tygodnia) / nazwa miesiąca / rok 4 cyfrowy
select 
	imie, 
	nazwisko, 
    date_format(data_ur, '%d(%W)/%M/%Y') as data_ur 
from 
	zawodnicy;

-- wypisz w którym kwartale danego roku urodził się każdy zawodnik

select 
	imie, 
	nazwisko, 
    concat_ws(' : ', 
		elt(quarter(data_ur),'I','II','III','IV'), 
        elt(month(data_ur),'Sty','Lut','Mar','Kwi','Maj','Cze','Lip','Sie','Wrz','Paz','Lis','Gru'),
        year(data_ur))  as data_ur 
from 
	zawodnicy;

-- ile lat ma kążdy skoczek
select 
	*, 
    year(now()) - year(data_ur) as wiek_rocznikowy, 
	timestampdiff(YEAR, data_ur, now()) as 'wiek_dokładny' 
from 
	zawodnicy;

-- do danych o zawodnikach dodaj ich indeks bmi = waga[kg]/(wzrost[m]^2) zaokrąglone do 1 miejsca po przecinku

-- localhost:3306	// server321342:3306
-- user:root
-- password: ???
select 
	company.zawodnicy.id_skoczka,
    company.zawodnicy.imie
from 
	company.zawodnicy
where 
	company.zawodnicy.id_skoczka = 1;










