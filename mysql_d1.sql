-- CTRL + ENTER - wykonanie linijki kodu pod kursorem
-- CTRL + SHIFT + ENTER - wykonanie zaznaczonego fragmentu lub całego skryptu

select 2+2;
select 2+2, 3*4, 2.15;

CREATE DATABASE MyFirstDataBase;	-- utworzenie db
DROP DATABASE myfirstdatabase;
-- DROP DATABASE company; 			-- usunięcie db
CREATE DATABASE company DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci;
use company;						-- ustaw jako domślną bazę danych
-- DROP TABLE employee
create table employee(
	employee_id int primary key auto_increment, -- klucz główny tabeli
    name varchar(55) not null,					-- pole obowiązkowe
    lastname varchar(55) not null, 				-- pole obowiązkowe
    salary_net double(8,2) default 1000,		-- pole opcjonalne
	gender enum('M','K') not null,				-- pole obowiązkowe
    empl_date date not null,					-- pole opcjonalne YYYY-MM-DD
    enable bool default 1						-- pole opcjonalne
);
-- polecenie zwaracające opis tabelki
describe employee; 
-- dodaj do tabelki employee kolumnę possition varchar(55) not null
alter table employee add possition varchar(55) not null; 
-- zmodyfikuj typ kolumny lastname na varchar(65)
alter table employee modify lastname varchar(65) not null;
-- ustaw kodowanie znaków w tabelce employee na utf8_polish_ci
alter table employee character set utf8 collate utf8_polish_ci;
-- dodaj unikatową kolumnę pesel do tabelki employee  
alter table employee modify pesel varchar(11) unique not null; 

-- wprowadzanie rekordów do tabeli
insert into employee 
values 
(default, 'Michał','Kruczkowski',8000,'M','2010-03-02', default, 'developer'),
(default, 'Adam','Kot',5000,'M','2010-02-21', default, 'developer');

-- pobieranie danych z tabeli
select * from employee;

-- polecenie modyfikujące wybrane rekord/y spełniające warunek 
update employee set pesel = '1231231233', salary_net = salary_net + 1000 where employee_id = 1;
update employee set pesel = '1231231232' where employee_id = 2;

-- polecenie modyfikujące wszystkie rekordy
update employee set salary_net = salary_net * 1.1;

-- polecenia zwracające rekordy
select * from employee;
-- wybiórcze zwracanie wartości w kolumnach
select name, lastname, gender, possition from employee;
-- wybiórcze zwracanie wartości w wierszach
select 
	name, 
    lastname, 
    salary_net 
from 
	employee 
where 
	salary_net > 8000;
    
select *, salary_net * 1.23 as salary_gross from employee;

-- polecenie usuwające rekordy z tabeli
-- delete from employee;							- polecenie usuwające wszystkie rekordy z tabelki employee	
-- delete from employee where salary < 5000;		- polecenie usuwające rekordy z tabelki employee spełniające warunek	

-- delete vs truncate
select * from employee;
delete from employee;	-- usuwa rekord, ale nie zeruje global_id
insert into employee values (default, 'test', 'test', 5000, 'M', now(), default, 'test', '1233212342');
insert into employee values (default, 'test', 'test', 5000, 'M', now(), default, 'test', '1233212343');
insert into employee values (default, 'test', 'test', 5000, 'M', now(), default, 'test', '1233212344');
select last_insert_id();

truncate table employee;
insert into employee values (4, 'test', 'test', 5000.12, 'M', now(), default, 'test', '1233212349');

select *, truncate(salary_net, 1) as salary_truncated from employee;

truncate table employee;

-- 'YYYY-MM-DD'


select 
	@empl_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' as regex, 
    year(@empl_date) as year, 
    month(@empl_date) as month,
    day(@empl_date) as day;
 
-- zapytanie sprawdzająca poprawność daty
SET @empl_date = '2001-13-31';
select 
	@empl_date as date_to_valid,
    @empl_date regexp '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' as regex,
    mid(@empl_date,1,4) between 1900 and year(now()) as year_valid,
    mid(@empl_date,6,2) between 1 and 12 as month_valid,
    if(mid(@empl_date,6,2) in (1,3,5,7,8,10,12),
		mid(@empl_date,9,2) between 1 and 31,
		if(mid(@empl_date,6,2) in (4,6,9,11),
			mid(@empl_date,9,2) between 1 and 30,
			if(mid(@empl_date,6,2) = 2 and (year(@empl_date) % 4) = 0, 
				mid(@empl_date,9,2) between 1 and 29,
				mid(@empl_date,9,2) between 1 and 28)
		)
	) as day_valid;






