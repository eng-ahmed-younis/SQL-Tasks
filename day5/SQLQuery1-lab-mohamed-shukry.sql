--LAB 5--
use ITI
--1--
select count(st_age) from Student;

--2--
select distinct Ins_Name from Instructor

--3--
select  St_Id as [Student ID],
		CONCAT(St_Fname,' ',St_Lname) [Student full name],
		ISNULL(dept_name,'') [Department Name]
from Student s, Department d
where s.Dept_Id = d.Dept_Id

--4--
select ins_name,d.Dept_Name from Instructor I 
left join Department d 
on I.Dept_Id = d.Dept_Id;

--5--
select s.St_Id as sid, CONCAT(St_Fname,' ',St_Lname) [Student full name], c.Crs_Name as csrsn
from Student s,Course c, Stud_Course sc
where s.St_Id = sc.St_Id and sc.Crs_Id=c.Crs_Id and sc.Grade is not null
order by c.Crs_Name;

--6--
select count(c.crs_id) [num of courses], t.Top_Name from Course c, Topic t
where t.Top_Id = c.Top_Id
group by t.Top_Name;

--7--
select MIN(i.Salary) min_sal, MAX(i.salary) [max sal] from Instructor i

--8--
select i.Ins_Name from Instructor i 
where Salary <(select AVG(salary) from Instructor );

--9--
select d.Dept_Name from Instructor i, Department d
where d.Dept_Id = i.Dept_Id and i.Salary = (
select MIN(salary) from Instructor);

--10--
select top(2) Salary
from Instructor 
order by Salary desc;

--11--
select coalesce (ins_degree,'NO DEGREE') degrees from instructor;

--12--
select x.St_Fname, y.St_Fname from Student x , Student y
where x.St_super = y.St_Id

--13--
select * from
(select salary, dept_id, DENSE_RANK() over(partition by dept_id order by salary desc) as DR from Instructor
) as newTable
where dr <=2 and Salary != 0;

--14--
select St_Id from(
select st_id, DENSE_RANK() over (order by newid()) as dr from Student
) as newtable
where dr = 1
-------------------
select top (1) st_id from Student order by newid();

--15--??
delete from stud_course
where St_Id in(
select sc.st_id from Stud_Course sc, Student s
where sc.St_Id = s.st_id and s.St_Id in(
select st_id from Student s, Department d
where s.Dept_Id = d.Dept_Id and d.Dept_Name = 'SD')
) 

--16--
create table daily_transaction(
	id int,
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

merge into daily_transaction as t
using last_transaction as s
on s.id = t.id
	when matched then
		update set t.trans = s.trans
	when not matched then
		insert values (s.id, s.trans)
	when not matched by source then 
		delete ;

select * from daily_transaction
select * from last_transaction

-------------------------------------------------------------------
-------------------------------------------------------------------
use AdventureWorks2012;
--1--
select SalesOrderID, ShipDate from Sales.SalesOrderHeader
where OrderDate between '7/28/2002'  and '7/29/2014'

--2--
select pp.ProductID, pp.Name from Production.Product pp
where pp.StandardCost < 110;

--3--
select pp.ProductID, pp.Name from Production.Product pp
where pp.Weight is null;

--4--
select pp.ProductID, pp.Name, pp.Color from Production.Product pp
where pp.Color in ('silver','black','red');

--5--
select pp.ProductID, pp.Name from Production.Product pp
where pp.Name like 'b%'

--6--
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select * from Production.ProductDescription pd
where pd.Description like '%[_]%';

--7--
select sum(TotalDue) totaldue, OrderDate from Sales.SalesOrderHeader soh
where OrderDate between '7/1/2001' and '7/31/2014'
group by OrderDate;

--8--
select distinct e.HireDate from HumanResources.Employee e;

--9--
select AVG(ListPrice) from(
select distinct ListPrice from Production.Product) as newtable;

--10-- -------??
select 'The '+pp.Name+' is only! '+CONVERT(varchar(20), pp.ListPrice) from Production.Product pp
where ListPrice between 100 and 120 
order by ListPrice;

--11--
	--a--
	select ss.rowguid, ss.Name, ss.SalesPersonID, ss.Demographics into store_archive from Sales.Store ss;

	--b--
	select ss.rowguid, ss.Name, ss.SalesPersonID, ss.Demographics into store_archive from Sales.Store ss
	where 1 =2;
	
--12--
select CONVERT(varchar,getdate(),1)
union
select CONVERT(varchar,getdate(),2)
union
select CONVERT(varchar,getdate(),3)
union
select CONVERT(varchar,getdate(),10)
union
select CONVERT(varchar,getdate(),20)
union
select CONVERT(varchar,getdate(),23)
union
select CONVERT(varchar,getdate(),109);

--part-3
create schema st 
alter schema st transfer student;
alter schema st transfer course;
