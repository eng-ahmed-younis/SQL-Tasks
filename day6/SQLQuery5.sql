--1 
create function getmounth(@dt date)
returns varchar(20)
begin
	declare @mth varchar(20)
	select @mth= datename(m,@dt )
	return @mth
end

select dbo.getmounth(GETDATE())
--2
create function numBet(@num1 int ,@num2 int )
returns @t table 
	(
	number int
	)
begin
	while @num1<@num2-1
	begin 
		set @num1 +=1
		insert into @t values(@num1)
	  end
  return
end

select * from numBet(2,9)


--- 3 


create function valuedDat(@id int )
returns table 
as 
return
	(
	select concat(st_fname,' ' ,st_lname)as [std full name],dept.Dept_Name 
	from student std,Department dept
	where std.dept_id=dept.Dept_Id and std.st_id=@id
	)

select * from valuedDat(10)







--- 4 


create function retMesg(@id int )
returns varchar(50)

begin 
	declare @msg varchar(50)
	declare @fname varchar(50)
	declare @lname varchar(50)
	select @fname=st_fname ,@lname=st_lname from student 
	if (@fname is null and @lname is null  )
	       select @msg ='First name & last name are null'
	if (@fname is null  )
	       select @msg ='First name are null'
	if ( @lname is null  )
	       select @msg ='last name are null'
	else 
	      select @msg='First name and last name are not null'

    return @msg
end 

select dbo.retMesg(13)






-- 5 




create function dispMangInf(@id int)
returns table
as 
return
	(
		select dept.Dept_Name ,ins.Ins_Name as mnger_name ,dept.Manager_hiredate
		from Department dept ,Instructor ins
		where dept.Dept_Manager=ins.Ins_Id
	)
update  Department set Dept_Manager=10 where Dept_Id=20

select * from dispMangInf(10)






----- 6 
create function MultStat (@string varchar(20))
returns @t table
(
	student_Name varchar(20) 
)
as 
begin
	if(@string='firstname')
		insert into @t
		select isnull(st_fname,' ') from student
	else if(@string='lastname')
		insert into @t
		select isnull(st_lname,' ') from student	
	else if(@string='fullname')
		insert into @t
		select concat(isnull(st_fname,' '),' ',isnull(st_lname,' '))as fullName from student
	return
end

select * from MultStat('lastname')


--7

select st_id ,  SUBSTRING(st_fname , 1,len(st_fname)-1)
from Student