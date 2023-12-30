--1--
select CONCAT(fname, ' ', lname) as Name, Sex
from Employee 
where Employee.Sex = 'F'
union all
select Dependent_name, Sex
from Dependent 
where Dependent.sex ='F'
union all
select CONCAT(fname, ' ', lname) as Name, Sex
from Employee 
where Employee.Sex = 'M'
union all
select Dependent_name, Sex
from Dependent 
where Dependent.sex ='M'

--2--
select Pname, sum(hours)
from Project,Works_for
where Pnumber = Pno
group by Pname

--3--
select Departments.* from Departments,employee
where  Employee.Dno = Departments.Dnum and SSN = (select MIN(SSN) from Employee)

--4--
select Dname, MAX(salary) maxSalary, AVG(salary) avgSalary, MIN(salary) minSalary 
from Departments,employee
where Employee.Dno = Departments.Dnum
group by Dname

--5--
select Lname from Employee,Departments
where MGRSSN = SSN and SSN not in (select SSn from Employee,Dependent where SSN = ESSN)

--6--
select Dnum,dname,count(dno) as emp_count from Employee,Departments
where Dnum=Dno
group by Dnum, Dname
having AVG(salary) < (select AVG(salary) from Employee)

--7--
select CONCAT(fname, ' ', lname) as empName ,Pname, Departments.dnum
from Employee, Works_for, Project, Departments
where SSN = ESSN and Pno = Pnumber and Departments.Dnum=Dno
order by Departments.Dnum, Lname,Fname

--8--
select MAX(salary) from Employee
where salary  not in(select MAX(salary) from Employee) 
union select MAX(salary) from Employee  

--9--
select CONCAT(fname, ' ', lname) as empName from Employee, Dependent
where  CONCAT(fname, ' ', lname)  like Dependent_name +'%'

--10--
--a -- updating the dept manager then updating the dept that he works in
update Departments 
	set MGRSSN = 968574
	where Dnum = 100
update Employee
	set Dno = 100
	where SSN = 968574
--- b --
update Departments 
	set MGRSSN = 102672
	where Dnum = 20
update Employee
	set Dno = 20
	where SSN = 102672
--c--
update Employee 
	set Superssn = 102672
	where SSN = 102660

--11--
update Departments 
	set MGRSSN = 
		case
			when MGRSSN = 223344 then 102672
			else MGRSSN
		end

update Employee 
	set Superssn = 
		case 
			when Superssn = 223344 then 102672
			else Superssn
		end

delete Dependent where ESSN = 223344;

delete Employee where SSN = 223344;

--12--
update Employee
	set salary = 1.3*salary
	from Employee join Works_for on  SSN = Works_for.ESSn 
	join project on Pno = Pnumber and Pname='al rabwah'
