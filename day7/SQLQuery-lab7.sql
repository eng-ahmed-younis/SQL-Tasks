alter schema dbo transfer st.student------------??
alter schema dbo transfer st.course
--1--
create view marksabove50
as 
select fullname = CONCAT(s.St_Fname,' ', s.St_Lname), c.Crs_Name from Student s, Stud_Course sc, Course c
where sc.St_Id =s.St_Id and sc.Crs_Id = c.Crs_Id and sc.Grade >50;

select * from marksabove50

--2--

create view mgrwithtopics
with encryption
as	select i.Ins_Name, t.Top_Name from Instructor i
	join Ins_Course ic on ic.Ins_Id = i.Ins_Id
	join Course c on c.Crs_Id=ic.Crs_Id
	join Topic t on t.Top_Id=c.Top_Id

select * from mgrwithtopics

--3--
create view sd_java_inst
as
	select i.Ins_Name, d.Dept_Name from Instructor i, Department d
	where i.Dept_Id=d.Dept_Id and d.Dept_Name in ('SD','JAVA')

select * from sd_java_inst

--4--
alter view V1
as 
	select * from student
	where St_Address in ('alex','cairo')
	with check option
select * from V1;

Update v1 set st_address='tanta'
Where st_address= 'alex';

--5--
use Company_SD
alter view EmpNumInProject
as 
	select e.Fname, w.Pno from Employee e, Works_for w
	where e.SSN=w.ESSn 

select * from EmpNumInProject

--6--
create schema company
create schema [Human Resources]

alter schema company transfer departments
alter schema [Human Resources] transfer employee


--7--
create nonclustered index ci1 on company.departments(hiredate)

--8--
use ITI
--can't create a unique index on a column containing non unique values
create unique index ci2 on student(st_age)
-- we can only create a nonclustered index
create nonclustered index ci2 on student(st_age)

--9--
use Company_SD
declare c1 cursor  
for	
	select salary from [Human Resources].Employee
for update

declare @sal int

open c1
fetch c1 into @sal

while @@FETCH_STATUS = 0
	begin
		if @sal < 3000
			update [Human Resources].Employee 
				set salary = 1.1 * @sal
				where current of c1
		else if @sal > 3000
			update [Human Resources].Employee
				set salary = 1.2 * @sal
				where current of c1
	fetch c1 into  @sal
	end
close c1
deallocate c1

--10--
use ITI
declare c1 cursor  
for	
	select Dept_Name,i.Ins_Name  from department d, Instructor i
	where i.Ins_Id=d.Dept_Manager
for read only

declare @name varchar(20), @mgrname varchar(20)

open c1
fetch c1 into @name, @mgrname
while @@FETCH_STATUS = 0
	begin
		select @name DepName, @mgrname ins_name
	fetch c1 into  @name, @mgrname
	end
close c1
deallocate c1

--11--
declare c1 cursor
for select St_Fname
	from Student
	where st_fname is not null
for read only

declare @name varchar(20), @all_names varchar(300)=''

open c1
fetch c1 into @name
while @@FETCH_STATUS=0
	begin
		set @all_names = concat(@name,',',@all_names)
		fetch c1 into @name
	end
select @all_names
close c1
deallocate C1

--12--
-- script attached