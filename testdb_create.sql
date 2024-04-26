select power(2, 32);
select length(conv(65535, 10, 2));

select * from Emp;
select * from Dept;
-- 
update Dept set captain = id * 10 
 where id > 0;
 
select d.*, e.ename as '부서장'
  from Dept d inner join Emp e on d.captain = e.id;

select d.*, ifnull(e.ename, '-공석-') as '부서장'
  from Dept d left outer join Emp e on d.captain = e.id;

alter table Dept drop column captain;
desc Emp;
show index from Dept;

select d.*, e.ename
  from Emp e inner join Dept d on d.captain = e.id;

delete from Emp where id = 20;

alter table Dept add column captain int unsigned null comment '부서장';
alter table Dept modify column captain int unsigned null default 3 comment '부서장';
alter table Dept add constraint fk_Dept_captain_Emp_id 
  foreign key (captain) references Emp(id)
  on update cascade;
  
alter table Dept drop constraint fk_Dept_captain_Emp_id;
alter table Dept drop index fk_Dept_captain_Emp_id;

analyze table Dept;
desc Emp;

alter table Emp add column auth tinyint(1) not null default 9 comment '0:sys, 1:super, …, 9:guest';

alter table Emp modify column auth tinyint(1) not null default 9 comment '0:sys, 1:super, …, 9:guest' after dept;


