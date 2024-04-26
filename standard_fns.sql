select power(2, 3), conv('EF', 16, 10), conv('101', 2, 10);

insert into T(id, name, 
select id, cast(id AS char), CONVERT(1.567, Signed Integer) from Dept order by id;

update Dept set createdate = '2018-12-03' where id = 1;  -- Bad
update Dept set createdate = str_to_date('2018-30-03', '%Y-%d-%m') where id = 2; -- Good

-- 단방향 암호화
select sha2('data', 256), sha2('data', 512);

select dname, AES_ENCRYPT(dname, '암호키'), HEX(AES_ENCRYPT(dname, '암호키')) from Dept;
select dname, AES_ENCRYPT(dname, '3a6eb0790f39ac87c94f3856b2dd2c5d110e6811602261a9a923d3bb23adc8b7'),
              HEX(AES_ENCRYPT(dname, '3a6eb0790f39ac87c94f3856b2dd2c5d110e6811602261a9a923d3bb23adc8b7')) from Dept;

select enc1, enc2,
       cast(aes_decrypt(sub.enc1, '암호키') as char),
       cast(aes_decrypt(unhex(enc2), '암호키') as char)
 from (select AES_ENCRYPT(dname, '암호키') enc1, HEX(AES_ENCRYPT(dname, '암호키')) enc2
         from Dept) sub;

select concat('A', '--', 'B', ',', 'C'), concat('A', ',', null, 'B'), 
       concat_ws(',', 'A', null, 'B');
select concat('A', '--', 'B', ',', 'C'), concat('A', ',', ifnull(null, ''), ',', 'B');

select e.dept, d.dname, max(salary) maxsal, count(*) cnt,
    group_concat(e.id) empIds
  from Emp e inner join Dept d on e.dept = d.id
             inner join (select dept, max(salary) maxsal from Emp group by dept) maxdept
                     on e.dept = maxdept.dept and e.salary = maxdept.maxsal
 group by e.dept, e.salary;

-- 직원명,부서명
select e.ename, concat(e.ename, ',', d.dname), concat_ws(',', e.ename, d.dname)
  from Emp e right outer join Dept d on e.id = d.captain;

select ifnull(e.ename, '공석'), if(d.id = 2, 'Two', ''),
       d.id, nullif(d.id, 2), 
    nullif(d.id, 3),
    (CASE WHEN d.id = 3 THEN NULL ELSE d.id END)
  from Emp e right outer join Dept d on e.id = d.captain;


select ascii('A'), CAST(char(65, 66) as char), char(65, 66);

select length('AB한글'), char_length('AB한글'), bit_length('A'), sign(-2), sign(22);

--              1       2       3                   1     2      3
--             내권한   팀권한    others
select elt(1, 'str1', 'str2', 'str3'), field('s1', 's0', 's1', 's2');
select find_in_set('s1', 's0,s1,s2'), find_in_set('s3', 's1,s2,s3,s4');
--                                                        12/5
select instr('str', 'x'), locate('s1', 's0s1s2'), insert('12345', 3, 2, '/');

select format(12345, 2), format(12345, 0), format(7890.12345, 4), truncate(7890.123, 2);

select left('abc', 2), upper('ab한글'), lower('AB한글'), lpad('5', 3, '0'), rpad('15', 4, 'x');
select reverse('abc'), repeat('a', 30);
select concat('A', space(5), 'B'), replace('abcdefg', 'cde', 'xxx');
select concat('A', trim('  ab  '), 'B');
select trim(both 's' from 'stress'), trim(leading '\t' from '\tsTs'), trim(trailing 's' from 'sTs');
select concat('A', LTRIM(' abc '), 'B'), concat('A', RTRIM(' abc '), 'B');

select substring('abcdef', 2, 3); -- 두 번째 자리부터 3개
select substring_index('a,b,c,d', ',', 2);  -- , 를 기준으로 두 번째까지
-- 2번째 (arr[1]) 인자만 구하기
select substring_index(substring_index('a,b,c', ',', 2), ',', -1);


select now(), sysdate(), curdate(), curtime(), current_date();
select year(now()), month(now()), day(now()), month('2024-11-29'),
	   hour(now()), minute(now()), second(now()), quarter(now()), week(now());
select weekday('2024-04-22'), weekday('2024-04-28');   -- 월요일(0) ~ 일요일(6)
select dayofweek('2024-04-28'), dayofweek('2024-04-27'); -- 일요일() ~ 토요일(7)
select DATE(now()), TIME(now()), MAKEDATE(2024, 336), MAKETIME(19,3,50);
select dayofyear(now()), monthname(now()), last_day(now());
select time_to_sec('0:1:30'), period_add(202012, 12), period_diff(202103, 202011);
select datediff('2024-12-25', '2024-04-23'), timediff('12:20:33', '11:30:20');
select datediff(now(), '2024-01-17');

select adddate(now(), interval 31 day), subdate(now(), interval 31 day);
select date_add(now(), interval -31 day), adddate(now(), interval -1 month);
select now(), addtime(now(), '1:1:1'), subtime(now(), '1:1:1');

select DATE_FORMAT(now(), '%Y-%m-%d %h:%i:%s (%w)');
select DATE_FORMAT(now(), '%Y-%m-%d %H:%i:%s (%W)');
select DATE_FORMAT(now(), '%Y-%m-%d %T %p (%W) %U주 %j일째');
select DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 1 DAY), '%Y-%m-%d');
select DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 1 DAY), '%Y-%m-%d');