--information indexed view

--1.Create a view that displays student full name, course name if the student has a grade more than 50. 
Create view mark50 
as
	select FullName=Concat(st_Fname,' ',st_Lname) , Crs_Name from Student s ,Stud_Course sc ,Course c
	where s.St_id = sc.st_id and c.Crs_id = sc.Crs_id and Grade > 50
select * from mark50

--2.Create an Encrypted view that displays manager names and the topics they teach. 
create view viewName
with encryption 
as
select i.ins_Name , t.Top_Name from Instructor i 
join Ins_Course ic on i.Ins_Id=ic.Ins_Id 
join Course c on ic.Crs_Id=c.Crs_Id 
join Topic t on c.Top_id = t.Top_Id

select * from viewName

--3.Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
Create view insnamed 
as
	select i.Ins_Name , d.Dept_Name from Instructor i , Department d 
	where i.Dept_Id=d.Dept_Id
	and d.dept_Name in ('SD','Java')

	select * from insnamed

--44.Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;
Create view V1 
as
	select * from Student s
	where St_Address in ('Alex','Cairo')
	with check option

select * from V1

Update V1 set St_Address='tanta'
where St_Address='Alex'


--5.Create a view that will display the project name and the number of employees work on it. “Use Company DB”
Use [Company]
Go
Create view PNameN
as
	select p.Pname , w.Pno from Project p , Works_for w
	where p.Pnumber = w.Pno
	
select * from PNameN

/*
6.	Create the following schema and transfer the following tables to it 
a.	Company Schema 
i.	Department table (Programmatically)
ii.	Project table (visually)
b.	Human Resource Schema
i.	  Employee table (Programmatically)
*/
Create Schema Company
Create schema[Human Resources]

alter schema Company Transfer Departments
alter schema [Human Resources] Transfer employee

--7.Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?
Create nonclustered index cil on [Company].[Departments]([MGRStart Date])

--8.	Create index that allow u to enter unique ages in student table. What will happen?
create unique index cil2 on Student(st_age)

--9-Create a cursor for Employee table that increases Employee salary by 10% 
--if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB
Use company 
Go
Declare c1 cursor
for
select salary from [Human Resources].[Employee]
for update 

declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
	begin
		if @sal < 3000
		update [Human Resources].[Employee] 
		set salary = salary*1.1
		where current of c1

		else if @sal>=3000 
		update [Human Resources].[Employee] 
		set salary = salary*1.2
		where current of c1

		fetch c1 into @sal

	end
	close c1
	deallocate c1

--10.Display Department name with its manager name using cursor. Use ITI DB

-- select but row by row
declare c2 cursor
for
select d.Dept_Name,i.Ins_Name from Department d,Instructor i
where i.dept_id = d.dept_id

for read only
declare @N varchar(50) , @i varchar(50)

open c2
fetch c2 into @N , @i
while @@FETCH_STATUS=0
begin
select @N Dept_Name,@i Ins_Name 
fetch c2 into @N , @i
end

close c2
deallocate c2


--11.	Try to display all students first name in one cell separated by comma. Using Cursor 

declare c3 cursor
for
select [St_Fname] from [dbo].[Student]
where st_fname is not null
for read only
	
	declare @name varchar(20) ,@all_names varchar(300)=''

	open c3
	fetch c3 into @name
while @@FETCH_STATUS=0
Begin
set @all_names=concat(@name,',',@all_names)
fetch c3 into @name

End
select @all_names
close c3
deallocate c3


--12.Try to generate script from DB ITI that describes all tables and views in this DB
