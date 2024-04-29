select * from Emp;
select * from Dept;
desc Emp;

select * from Emp;
select count(*) from Emp;
select count(*) from Dept;
select * from Emp where id <= 10;

select Emp.*, Dept.dname
  from Emp, Dept
 where Dept.id = Emp.dept;

select Emp.*, Dept.dname
  from Emp inner join Dept
 where Dept.id = Emp.dept;
 
select Emp.*, Dept.dname
  from Emp inner join Dept on Emp.dept = Dept.id;
  
select e.*, d.dname
  from Emp e inner join Dept d on e.dept = d.id;
  
select e.*, d.dname
  from Emp e inner join Dept d on d.id = e.dept;
  
select e.*, d.dname
  from Dept d inner join Emp e on d.id = e.dept;

select e.*, d.dname
  from Dept d inner join Emp e on d.id = e.dept
 where e.id <= 10;

select e.*, d.dname
  from Dept d inner join Emp e on d.id = e.dept and e.id <= 10;



explain select Emp.*, Dept.dname
  from Emp inner join Dept on Emp.dept = Dept.id;

show index from Dept;

alter table Dept add column captain int unsigned null comment '부서장';

alter table Dept add constraint fk_Dept_captain_Emp_id
  foreign key (captain) references Emp(id)
  on update cascade
  on delete set null;
  
alter table Dept drop constraint fk_Dept_captain_Emp_id;
alter table Dept drop index fk_Dept_captain_Emp_id;

create table EmailLog(
  id int unsigned not null auto_increment primary key,
  sender int unsigned not null comment '발신자',
  receiver varchar(1024) not null comment '수신자',
  subject varchar(255) not null  comment '제목',
  body text null comment '내용',
  foreign key fk_EmailLog_sender_Emp (sender)
    references Emp(id) on update cascade on delete cascade
) ENGINE = MyIsam;

alter table EmailLog engine = InnoDB;
alter table EmailLog engine = MyISAM;

desc EmailLog;
show index from EmailLog;
analyze table EmailLog;
show table status;

insert into schooldb.Prof (name) select '교수' from testdb.Emp where id <= 6;

show variables like '%dir';

select * from Emp
 order by id asc limit 230, 11;
 
select sub.*
  from (select * from Emp order by id desc limit 10, 11) sub
 order by sub.id;
 
select dept, max(ename) maxname, min(ename), count(*) cnt,  -- 4
      max(salary), min(salary) minsal
  from Emp                                                  -- 1
 group by dept                                              -- 2
 having cnt >= 40 -- count(*) >= 40                         -- 3
 order by max(ename); -- maxname;                           -- 5
 
select * from Emp
-- update Emp set salary = salary + dept
 where salary = 900;
 
-- ex) 부서별 최고 연봉자의 수를 부서명과 함께 출력하시오.
select e.dept, d.dname, max(salary) maxsal, count(*) cnt
  from Emp e inner join Dept d on e.dept = d.id
 group by dept, salary
 order by dept, maxsal desc;

select e.dept, d.dname, max(salary) maxsal, count(*) cnt
  from Emp e inner join Dept d on e.dept = d.id
 where salary = (select max(salary) from Emp)
 group by dept, salary
 order by dept, maxsal desc;
 
select dept, max(salary) from Emp group by dept;

-- 부서별 최고 연봉자 수
select e.dept, d.dname, max(salary) maxsal, count(*) cnt,
    group_concat(e.id) empIds
  from Emp e inner join Dept d on e.dept = d.id
             inner join (select dept, max(salary) maxsal from Emp group by dept) maxdept
                     on e.dept = maxdept.dept and e.salary = maxdept.maxsal
 group by e.dept, e.salary;

/*
[
  {dept: 1, salary: 2, data: [{id:1, ename: '홍길동', ...}, {id: 2, ename: '박길동', ...}]},
  {dept: 1, salary: 2, [emps...]},
]
*/
 
select count(*) from Emp where dept = 5 and salary=905;

select * from Dept;

/*
select sub.dname, sub.maxsal
  from (select e.dept, d.dname, max(salary) maxsal, count(*) cnt
          from Emp e inner join Dept d on e.dept = d.id
         group by dept, salary
         order by dept, maxsal desc) sub
 where ;
 */
/*
[
  {dept: 1, data: [{id:1, ename: 홍길동,sa..}, ]},
  {dept: 2, data: [emps..]},
  ...
]
*/
 
select * from Dept;
select d1.dname '상위부서', d2.dname '하위부서'
  from Dept d1 inner join Dept d2 on d1.id = d2.pid;
 
select * from Emp;
 
alter table Emp add column outdt date null comment '퇴사일';

update Emp set outdt='2024-04-25' 
 where id in (3,5);
select curdate(), current_date();

update Emp set outdt=curdate()
 where id in (4,6);
 
select * from Dept
-- update Dept set captain = null
 where captain in (select id from Emp where outdt is not null);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

