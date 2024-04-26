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
select * from Student;

insert into Student(name, birthdt, major, mobile, email)
      values('홍길동', '2002-01-02', 1, '01012341234', 'hong@gmail.com');
      
insert into Student(name, birthdt, major, mobile, email) values 
      ('홍길동', '2002-01-02', 1, '01012341234', 'hong@gmail.com'),
      ('박길동', '2003-01-22', 1, '01012341235', 'park@gmail.com');

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

insert into Subject(name, prof) values('국어', 1);
insert into Subject(name, prof) values ('수학', 2), ('과학', 2), ('미술', 2);

select * from Subject;
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

ALTER TABLE `schooldb`.`Enroll` 
ADD UNIQUE INDEX `uniq_Enroll_subject_student` (`subject` ASC, `student` ASC) VISIBLE;

insert into Enroll(subject, student) values(1, 1);
insert into Enroll(subject, student) values(2, 2);

-- Error Code: 1062. Duplicate entry '2-2' for key 'enroll.uniq_Enroll_subject_student'
insert ignore into Enroll(subject, student) values
  (2, 1), (2, 2);
  
-- 2 row(s) affected
insert into Enroll(subject, student) values (2, 2)
  on duplicate key update createdate = now();
  
insert into Enroll(subject, student) values(2, 3);
insert into Enroll(subject, student) values(3, 3);
insert into Enroll(subject, student) values(3, 1);
insert into Enroll(subject, student) values(3, 2);

select * from Subject;
select * from Enroll;
select mod(2, 10);

select * from Student;
select distinct mobile from Student;

select e.id, sbj.name as '과목명', stu.name '학생명', 
    (case when mod(e.id, 2) = 1 then '홀수' else '짝수' end) as '홀짝1',
    (case mod(e.id, 2) when 1 then '홀수' else '짝수' end) as '홀짝2',
    (case when e.id = 5 then '55' when e.id = 2 then '22' else '100' end) as 'XX',
    (case e.id when 5 then '55' when 2 then '22' else '100' end) as 'YY',
    if(mod(e.id, 2) = 1, '홀수', '짝수') '홀짝3'
  from Enroll e inner join Subject sbj on e.subject = sbj.id
                inner join Student stu on stu.id = e.student
 where e.subject between 1 and 2 -- in (1,2)  -- e.subject = 1 or e.subject = 2
   and stu.name like '_길%' -- like '홍%'; 
 order by stu.id desc;

desc student;

show index from Enroll;
show table status;

analyze table Enroll;

select * from Student;
select * from Subject;

-- 과목 - 담당쌤
select s.*, p.name
  from Subject s inner join Prof p on s.prof = p.id;

update Subject set prof = (select id from Prof where name='교수3')
 where id = 4;
 
-- 교수명이 '교수3'인 과목의 이름 '음악'으로 변경하시오.
select * from Subject s inner join Prof p on s.prof = p.id
 where p.name = '교수3';

/*
update Subject s inner join Prof p on s.prof = p.id
 set s.name = '음악'
 where p.name = '교수3';
*/

select * from Subject;
-- update Subject set prof = null
 where id = 3;
 
select * from Subject where prof is not null;










