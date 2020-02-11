use task_manager;

select * from user;
select * from subtask;
insert into user values (default, 'user');
-- zwiększ date_stop dla subtasków o 10 dni
update subtask set date_stop = adddate(date_stop, interval 10 day);
-- usuń użytkownika o user_id = 3
delete from user where user_id = 3;

-- utwórz tablekę o nazwie user_logs
create table user_logs(
	user_logs_id int primary key auto_increment,
    log_timestamp datetime,
    user_id int,
    foreign key (user_id) references user(user_id)
);
drop database task_manager;
create user 'test_user'@'localhost' identified by '123';

