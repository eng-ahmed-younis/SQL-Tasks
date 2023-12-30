--1--
use iti
alter procedure st_num
as 
	select COUNT(st_id),d.Dept_Name from Student s,Department d 
	where s.Dept_Id =d.Dept_Id
	group by d.Dept_Name

st_num 

--2--
use Company_SD	
alter procedure empnum @a int
as
	declare @x int
	select @x = COUNT(e.SSN) from Employee e , Works_for w
	where e.SSN = w.ESSn and w.Pno = @a
	if @x<3 
		select e.Fname,e.Lname from Employee e , Works_for w
		where e.SSN = w.ESSn and w.Pno = @a
	else 
		select 'The number of employees in the project '+convert(varchar(10),@a)+' is 3 or more'

empnum 300

--3--
alter procedure swaponproject @oldemp int, @newemp int, @pno int
as
	update Works_for set ESSn = @newemp 
	where ESSn = @oldemp and Pno = @pno

swaponproject 223344,512463,100

--4--
Create Table projectaudit
(
 projectNo int,
 userName varchar(20),
 ModefiedDate date,
 Budget_old int,
 Budget_new int
)
create trigger t2
on project
instead of update
as
	if update(budget)
		begin
			declare @old int,@new int, @pno int
			select @pno=Pnumber from deleted
			select @old=budget from deleted
			select @new=budget from inserted
			insert into projectaudit
			values(@pno,suser_name(),getdate(),@old,@new)
		end

update Project set budget = 7000 where pnumber=200
select * from projectaudit;

--5--
use ITI
create trigger t3
on department 
instead of insert
as
	select 'You can’t insert a new record in this table'

insert into Department values(70,'sd','qwqw','qwqwdwq',223344,'5/5/2015')

--6--
use Company_SD
create trigger t4
on employee
instead of insert
as
	if FORMAT(GETDATE(),'MMMM') = 'march'
	select 'You can’t insert a new record in this table in march'

insert into employee(Fname,Lname,SSN,Bdate) 
values ('mohamed','shukry',7532,'5/5/2020')

--7--
use ITI
create table student_audit(
	user_name varchar(100),
	date date,
	Note varchar(400)
)
alter trigger t5
on student
after insert
as
	declare @a int
	select @a = st_id from inserted
	insert into student_audit
	values (SUSER_NAME(),GETDATE(),USER_NAME()+' inserted a new redcord with key '+CONVERT(varchar(10),@a)+' in table student')

insert into Student(St_Id)
values (20)

select * from student_audit

--8--
alter trigger t6
on student
instead of delete
as
	declare @a int
	select @a = st_id from deleted
	insert into student_audit
	values (SUSER_NAME(),GETDATE(),USER_NAME()+' tried to delete a row with key '+CONVERT(varchar(10),@a))

delete from Student
where St_Id = 14

select * from student_audit

------------