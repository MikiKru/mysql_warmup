-- składnia DCL - data control language
-- utworzenie użytkownika
create user 'task_manager_user'@'localhost' identified by '123';
-- przypisywanie uprawnień dla uzytkownika Data Manipulation Language
grant SELECT, INSERT, UPDATE, DELETE on task_manager.* to 'task_manager_user'@'localhost';

-- utwórz użytkownika user_administrator z uprawniniami 
-- 1. do bazy task_mananger
-- 2. do tabel user i user_role i role
-- 3. polecenia SELECT, DELETE, UPDATE, INSERT	DML
-- 4. polecenia CREATE, DROP, ALTER DDL
create user 'user_administrator'@'localhost' identified by '123';
grant SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER 
		on task_manager.user to 'user_administrator'@'localhost';
grant SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER 
		on task_manager.user_role to 'user_administrator'@'localhost';
grant SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER 
		on task_manager.role to 'user_administrator'@'localhost';