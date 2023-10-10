3-------------------
create table countries (
  countries_id varchar(25) primary key,
  countries_name varchar(50),
  region_id int,
  foreign key (region_id) references region(region_id)
);