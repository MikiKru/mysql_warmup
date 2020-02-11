-- składnia DCL - data control language
-- utworzenie użytkownika
create user 'task_manager_user'@'localhost' identified by '123';
-- przypisywanie uprawnień dla uzytkownika Data Manipulation Language
grant SELECT, INSERT, UPDATE, DELETE on task_manager.* to 'task_manager_user'@'localhost';
