use ITI

--1
select COUNT([St_Age]) From Student

--2
select Distinct Ins_Name From Instructor

--3
select St_id as "Student ID" , St_fname +' '+St_Lname as "Student Full Name" ,IsNull (Dept_Name,'') as "Department Name"
from Student s join Department D on s.Dept_Id=d.Dept_Id

--another solution
select  St_Id as [Student ID],
		CONCAT(St_Fname,' ',St_Lname) [Student full name],
		ISNULL(dept_name,'') [Department Name]
from Student s, Department d
where s.Dept_Id = d.Dept_Id

--4
select Ins_Name ,Dept_Name from Instructor i left  join Department d on i.Dept_Id=d.Dept_Id
--5
select CONCAT(St_Fname,'',St_Lname)[Student full name] , Crs_Name as "Course Name"
from Student s, Course c,Stud_Course sc
where s.St_Id = sc.St_Id and c.Crs_Id=sc.Crs_Id and  sc.Grade is not null
order by c.Crs_Name

--6
select COUNT(crs_name) as "Course Name" , Top_Name as "Topic Name" 
from Course c,Topic t where c.Top_Id = t.Top_Id
group by t.Top_Name

--7
select min(i.Salary) as min_sal, max(i.Salary) as max_sal from Instructor i

--8

select i.Ins_Name from Instructor i
where salary < (select AVG(salary) from Instructor)

--9
select Dept_Name from Instructor i , Department d 
where i.Dept_Id=d.Dept_Id and
salary = (select Min(Salary) from Instructor)

--10
select top(2) i.salary from Instructor i 
order by salary desc

--11
select coalesce (ins_degree,'NO DEGREE') degrees from instructor;

--12
select * from Student
select x.St_Fname , y.St_Fname from Student x , Student y
where x.St_super=y.St_Id

--13
select * from
(select salary , dept_id , Dense_Rank() over(partition by dept_id order by salary desc) as DR from Instructor) 
as Newtable 
where DR <=2 and salary !=0

--14
select st_Id from
(select st_Id , DENSE_RANK() over( order by newId()) as DR  from Student) as Newtable
where DR=1
--------
select top (1) st_id from Student order by newid();

--15
/*15.	Delete all grades for the students whose Located in SD Department*/
delete from Stud_Course
where St_Id in(select sc.st_ID from Stud_Course sc , Student s 
where sc.St_Id=s.St_Id and s.St_Id in (select st_Id from Student s , Department d 
where s.Dept_Id=d.Dept_Id and d.Dept_Name='SD')
)

--16
create table daily_transaction(
id int ,
trans int
)
create table last_transaction(
id int,
trans int
)

insert into daily_transaction values
(1,1000),(2,2000),(3,1000);
insert into last_transaction values
(1,4000),(4,2000),(2,10000);

Merge into daily_transaction as t
	using last_transaction as s 
		on s.id = t.id 
		when matched then
		update set t.trans = s.trans
		when not matched then
		insert values (s.id, s.trans)
		when not matched by source then
		Delete;

select * from daily_transaction
select * from last_transaction

-------------------
-------------------
