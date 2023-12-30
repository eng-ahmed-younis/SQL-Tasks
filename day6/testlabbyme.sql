use EidCenter
Go
--1- Scalar Function
Create Function GetMonth(@d date)
returns varchar(20)
as 
	begin
	declare @m varchar(20)
	set @m = format(@d , 'MMMM')
	return @m
	end

Select dbo.GetMonth('10-10-2020');
select dbo.GetMonth(GETDATE());

--2 
Create Function getbetween(@a int , @b int)
returns @t table (x int)
as
	Begin
		declare @Val int
		set @Val = @a+1
		while @val between @a+1 and @b-1
		begin
			insert into @t values (@Val)
			set @val +=1
		end
		return
	End

select * from getbetween(1,5)
select * from getbetween(1,9)

--3 --inline function
/*3. Create a tabled valued function that takes Student No and returns Department Name with Student full name.*/
Create Function GetdeptName(@a int)
returns table 
as 
	return(
	select dept_Name as "department Name" , CONCAT(st_Fname,' ',st_Lname) as "FullName" from Student s,Department d
	where s.Dept_id=d.dept_id and st_Id = @a
	)

	select * from GetdeptName(5)


	/*4.	Create a scalar function that takes Student ID and returns a message to user 
a.	If first name and Last name are null then display 'First name & last name are null'
b.	If First name is null then display 'first name is null'
c.	If Last name is null then display 'last name is null'
d.	Else display 'First name & last name are not null'

	*/
Create Function getMessage(@id int)
Returns  varchar(50)
as
	begin
	declare @fname varchar(50)
	declare @lname varchar(50)
	declare @mess varchar(50)
	select @fname=st_Fname,@lname=st_lname from dbo.Student s
	where s.st_id = @id
		if (@fname is null and @lname is null) select @mess='First name & last name are null'
		else if (@fname is null) select @mess='first name is null'
		else if (@lname is null ) select @mess='last name is null'
		else select @mess='first name and last name are  not null'

		return @mess
	end

select dbo.getMessage(3)
select dbo.getMessage(13)
select dbo.getMessage(14)


--5- inline func
/*
Create a function that takes integer which represents manager ID and displays department name, 
Manager Name and hiring date 
*/
Create function getdeptinfo(@t int)
returns table
as
	return(
		select d.Dept_Name,i.ins_Name,d.Manager_hiredate from Department d , instructor i
		where d.Dept_Manager = i.ins_id and d.Dept_Manager = @t
	)

	select * from getdeptinfo(1)
	select * from getdeptinfo(3)

--6
/*
6.	Create multi-statements table-valued function that takes a string
If string='first name' returns student first name
If string='last name' returns student last name 
If string='full name' returns Full Name from student table 
Note: Use “ISNULL” function
*/

Create function getString(@a varchar(20))
returns @t table (name varchar(50))
as 
	begin
		 if(@a = 'first name')
		 insert into @t
		 select isnull(s.st_Fname,'') from student s 
		 else if(@a = 'last name')
		 insert into @t
		 select isnull(s.st_Lname,'') from student s
		 else if(@a = 'full name')
		 insert into @t
		 select concat( isnull(s.st_fname,''),' ',isnull(s.st_lname,'')) from student s

		 Return
	end;
	
	select * from getstring('full name')
	select * from getstring('first name')
	select * from getstring('last name')

--7-
-- Write a query that returns the Student No and Student first name without the last char
select s.St_Id, SUBSTRING(s.st_fname,1,len(s.st_fname)-1) from student s
--without the last two char
select s.st_id , substring(s.st_Lname , 1,len(s.st_Lname)-2) from student s
