--DDL create alter drop 

create table ahmed (noha int,mona int,ola int , omnia int);

alter table mahmoud add omnia int;

backup database Company_SD to disk = 'Desktop';

drop table ahmed;

truncate table mahmoud;

alter table mahmoud add abdo int;

alter table mahmoud alter column abdo varchar(50);

alter table mahmoud drop column omnia;

grant select on table mahmoud to ahmed;

-- DML insert & update & delete

insert into mahmoud (ola) values (90);

insert into mahmoud values (10 , 20 ,30 ,40);

update mahmoud set ola = 90 where abdo = 40;

delete mahmoud;

select * from mahmoud;

-- delete vs truncate
/* delete can use where truncate cannot
	delete can be rolled back (undo) before commit because it is DML but truncate is DDL
*/

--SELECT 
select mona , ola from mahmoud 
where ola = 90;
