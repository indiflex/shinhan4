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