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

-- fk_Student_major
alter table Student add constraint fk_Student_major_Major_id
    foreign key (major) references  Major(id)
    on update cascade
    on delete restrict;
    
select * from Student;
desc Student;

create table Prof (
  id smallint unsigned not null auto_increment primary key,
  name varchar(31) not null comment '교수명',
  likecnt int unsigned not null default 0 comment '좋아요 수'
);

-- insert into Prof (name) select '교수' from testdb.Emp where id <= 6;
-- insert into Prof (name) select concat('교수', id) from Emp where id <= 6;
select floor(rand() * 100);
update Prof set name = concat(name, id);
update Prof set likecnt = floor(rand() * 100);

select * from Prof;

create table Subject (
  id tinyint unsigned not null auto_increment primary key,
  name varchar(31) not null comment '과목명',
  prof smallint unsigned null comment '담당쌤',
  foreign key fk_Subject_prof (prof) references Prof(id)
    on update cascade on delete set null
);

-- create temporary table ...

create table Enroll (
  id int unsigned not null auto_increment primary key,
  createdate timestamp DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
  updatedate timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '등록일시',
  subject tinyint unsigned not null comment '신청과목ID',
  student int unsigned not null comment '신청학생',
  foreign key fk_Enroll_subject (subject) references Subject(id)
    on update cascade on delete cascade,
  foreign key fk_Enroll_student (student) references Student(id)
    on update cascade on delete cascade
);

desc student;

show table status;

















