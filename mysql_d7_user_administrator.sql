use task_manager;
create table user_logs(
	user_logs_id int primary key auto_increment,
    log_timestamp datetime,
    user_id int,
    foreign key (user_id) references user(user_id)
);