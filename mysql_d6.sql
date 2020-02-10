-- TWORZENIE REALCJI
create database task_manager default character set utf8 collate utf8_polish_ci; 
use task_manager;

create table task(
	task_id int primary key auto_increment,
    name varchar(255) not null
);
create table subtask(
	subtask_id int primary key auto_increment,
	description text not null,
    date_start date not null,
    date_stop date not null,
    task_id int not null,
    foreign key (task_id) references task(task_id)	
    -- foreign key (nazwa klucza obcego) references nazwa tabeli skąd pochodzi foreign key (nazwa klucza głównego tej tabeli)
);
insert into task values (default, 'Nauka SQL');
insert into task values (default, 'Wyjazd w Bieszczady');

insert into subtask values (default, 'typy złączeń tabel', now(), '2020-02-10', 1);
insert into subtask values (default, 'zapytania agregujące rekordy', now(), '2020-02-10', 1);
insert into subtask values (default, 'praca na widokach', now(), '2020-02-10', 1);

insert into subtask values (default, 'opracowanie planu podróży', '2020-02-02', '2020-02-09', 2);

select 
	t.name,
    s.description,
    s.date_start,
    s.date_stop
from 
	task as t join subtask as s on (t.task_id = s.task_id);


create table category(
	category_id int primary key auto_increment,
	name varchar (255) not null
);
-- utworzenie relacji many to many dla task i category
create table task_category(
	task_category_id int primary key auto_increment,
    task_id int,
    category_id int,
	foreign key (task_id) references task(task_id),
	foreign key (category_id) references category(category_id)
    -- foreign key (nazwa klucza obcego) references nazwa tabeli skąd pochodzi foreign key (nazwa klucza głównego tej tabeli)
);
-- jak zmienić nazwę kolumny task_category na task_category_id w tabeli task_category ???
-- alter table task_category change task_category task_category_id int auto_increment; 
create table user(
	user_id int primary key auto_increment,
    name varchar(55) not null
);
-- utworzenie relacji many to many dla subtask i user
create table subtask_user(
	subtask_user_id int primary key auto_increment,
    subtask_id int,
    user_id int,
	foreign key (subtask_id) references subtask(subtask_id),
	foreign key (user_id) references user(user_id)
);

-- GENEROWANIE ERD -> database -> reverse engineering -> ... next -> wybierz bazę danych -> ... next
select * from role;
select * from user;
select * from user_role;
select * from category;
select * from task_category;
select * from subtask_user;
-- auto-generated
INSERT INTO `task_manager`.`user` (`name`) VALUES ('miki');
INSERT INTO `task_manager`.`user` (`name`) VALUES ('luca');

INSERT INTO `task_manager`.`user_role` (`role_id`, `user_id`) VALUES ('1', '1');
INSERT INTO `task_manager`.`user_role` (`role_id`, `user_id`) VALUES ('1', '2');
INSERT INTO `task_manager`.`user_role` (`role_id`, `user_id`) VALUES ('2', '1');
INSERT INTO `task_manager`.`user_role` (`role_id`, `user_id`) VALUES ('3', '2');

INSERT INTO `task_manager`.`category` (`category_id`, `name`) VALUES ('1', 'edukacja');
INSERT INTO `task_manager`.`category` (`category_id`, `name`) VALUES ('2', 'podróże');
INSERT INTO `task_manager`.`category` (`category_id`, `name`) VALUES ('3', 'rozwój osobisty');

INSERT INTO `task_manager`.`task_category` (`task_id`, `category_id`) VALUES ('1', '1');
INSERT INTO `task_manager`.`task_category` (`task_id`, `category_id`) VALUES ('1', '3');
INSERT INTO `task_manager`.`task_category` (`task_id`, `category_id`) VALUES ('2', '2');
INSERT INTO `task_manager`.`task_category` (`task_id`, `category_id`) VALUES ('2', '3');

-- wypisz wszystkich userow wraz z rolami

-- wypisz wszystkie zadania wraz z kategoriami i podzadaniami do nich przypisanymi














