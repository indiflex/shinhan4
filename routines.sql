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
 
select prof, count(*) cnt
  from Subject
 group by prof;
 
-- 초기값 세팅
update Prof p 
  inner join (select prof, count(*) cnt from Subject group by prof) sub
          on p.id = sub.prof
   set p.subjectcnt = sub.cnt
 where p.id > 0;
   
 
alter table Prof add column subjectcnt tinyint unsigned not null default 0 comment '담당 과목수';

insert into Subject(name, prof) values('체육', 4);

select * from Subject;
select * from Prof;
select s.*, p.subjectcnt
  from Subject s inner join Prof p on s.prof = p.id;
delete from Subject where id = last_insert_id();

create trigger tr_Subject_after_insert 
    after insert on Subject for each row
  update Prof set subjectcnt = subjectcnt + 1
   where id = NEW.prof;
   
create trigger tr_Subject_after_delete
    after delete on Subject for each row
  update Prof set subjectcnt = subjectcnt - 1
   where id = OLD.prof;

create trigger tr_Subject_after_update
    after update on Subject for each row
  update Prof set subjectcnt = if(id = NEW.prof, subjectcnt + 1, subjectcnt - 1)
   where id in (OLD.prof, NEW.prof) and OLD.prof <> NEW.prof;
   
drop trigger tr_Subject_after_update;

select * from Subject;
select * from Prof;
select * from Prof where id in (4,4);
update Subject set prof = 4 where id = 6; -- 3-> 4
update Subject set name = '사회과부도' where id = 7;
/*
conn.prepareStatement('select * from Emp where id = ?')
conn.statement('select * from Emp where id = 1')
*/
 
select profname from v_subject where id=4;
-- update v_subject set name='미술' where id = 4;
-- insert into v_subject(name, prof) value('미술', 2);