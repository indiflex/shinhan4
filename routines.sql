select * from Prof;
select * from Subject;

create view v_subject AS
select s.*, p.id profid, p.name profname
 from Subject s left outer join Prof p on s.prof = p.id;
 
create view v_student_guest AS
select id, name, major from Student;

insert into Subject(name, prof) values ('미술', 2), ('역사', 3);

select profid, max(profname) profname, count(*)
  from v_subject
 group by profid;
 
alter table Prof add column subjectcnt tinyint unsigned not null default 0 comment '담당 과목수';

insert into Subject(name, prof) values('사회', 4);

select * from Subject;
select * from Prof;

create trigger tr_Subject_after_insert 
    after insert on Subject for each row
  update Prof set subjectcnt = subjectcnt + 1
   where id = NEW.prof;

/*
conn.prepareStatement('select * from Emp where id = ?')
conn.statement('select * from Emp where id = 1')
*/
 
select profname from v_subject where id=4;
-- update v_subject set name='미술' where id = 4;
-- insert into v_subject(name, prof) value('미술', 2);