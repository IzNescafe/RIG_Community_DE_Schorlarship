create database HR_system;
use HR_system;

create table employees (
	employee_id int primary key auto_increment,
    employee_code varchar(4),
    first_name varchar(10),
    last_name varchar(10),
    gender varchar(6),
    date_of_birth date,
    phone long,
    email varchar(50),
    address varchar(200),
    hire_date date,
    department_id int not null,
    position_id int not null,
    manager_id int,
    foreign key(department_id) references departments(department_id),
    foreign key(position_id) references job_positions(position_id),
    foreign key(manager_id) references departments(manager_id),
    employment_status varchar(20),
    national_id varchar(25),
     photo_path varchar(50),
     create_at datetime
);