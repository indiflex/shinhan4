create table Major(
    id smallint unsigned auto_increment primary key comment '학과번호',
    name varchar(31) not null comment '학과명'
);

select * from Major;

insert Major(name) values('철학과');
insert Major(name) values('컴퓨터공학과');
insert Major(name) values('건축과');

create table Student (
  id int unsigned not null auto_increment primary key,
  createdate timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  updatedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시',
  birthdt date null comment '생년월일',
  major smallint unsigned not null default 2 comment '학과id',
  mobile varchar(11) not null default '' comment '휴대전화',
  email varchar(255) not null default '' comment '이메일주소',
  gender boolean not null default 0 comment '성별(0:여,1:남)',
  graduatedt varchar(10) null comment '졸업일'
);

show index from Student;
show table status;

alter table Student add column name varchar(31) not null default '' comment '이름';
alter table Student modify column name varchar(31) not null default '' comment '이름' after updatedate;

alter table Student add constraint fk_Student_major_Major_id
    foreign key (major) references  Major(id)
    on update cascade
    on delete restrict;
    


select * from Student;
desc Student;











