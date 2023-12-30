alter schema st transfer dbo.student------------
alter schema st transfer dbo.course
--1--
create function getmonth(@d date)
	returns varchar(20)
	begin 
		declare @m varchar(20)
		set @m = format(@d,'MMMM')
		return @m
	end
select dbo.getmonth(GETDATE());

--2--
create function getbetween(@a int , @b int)
returns @t table (x int)
as 
	begin
		declare @val int
		set @val = @a+1
		while @val between @a+1 and @b-1
			begin
				insert into @t values ( @val )
				set @val +=1
			end
		return
	end
	
select * from getbetween(1,9)

--3--
create function getsname(@a int)
returns table
as 
	return(
		select d.Dept_Id,name = CONCAT(s.St_Fname, ' ' , s.St_Lname) from Department d,st.Student s
		where d.Dept_Id = s.Dept_Id and s.St_Id = @a
	)
select * from getsname(2);

--4--
create function getnameinfo(@a int)
returns varchar(90) 
	begin 
		declare @fname varchar(50)
		declare @lname varchar(50)
		declare @msg varchar(90)
		select @fname= s.St_Fname,@lname = s.St_Lname from st.Student s
		where s.St_Id = @a 
			if (@fname is null) select @msg= 'first name is null'
			else if (@lname is null) select @msg= 'last name is null'
			else if (@fname is null and @lname is null) select @msg= 'first name and last name are null'
			else select @msg= 'first name and last name are not null'
		return @msg
	end
select dbo.getnameinfo(3)

--5--
create function getdeptinfo(@a int)
returns table
as
	return(
		select d.Dept_Name, i.Ins_Name, d.Manager_hiredate from Department d, Instructor i
		where d.Dept_Manager = i.Ins_Id and d.Dept_Manager =@a
	)

select * from getdeptinfo(2)

--6--
create function getnames(@a varchar(20))
returns @t table (name varchar(50))
as 
begin
		if( @a = 'first name')
			insert into @t
			select ISNULL(s.St_Fname,'') from st.Student s
		else if( @a = 'last name')
			insert into @t
			select ISNULL(s.St_Lname,'') from st.Student s
		else if( @a = 'full name')
			insert into @t
			select CONCAT(ISNULL(s.St_Fname,''), ' ' ,ISNULL(s.St_Lname,'')) from st.Student s
	return
end;
select * from dbo.getnames('full name')

--7--
select s.St_Id, SUBSTRING(s.St_Fname,1,len(s.St_Fname)-1) from st.Student s