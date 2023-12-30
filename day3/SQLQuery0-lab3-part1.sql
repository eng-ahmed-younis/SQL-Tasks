--1--
select  Dnum ,Dname ,ssn as mgrssn , concat(fname,' ',lname) mgrname
from employee , Departments
where ssn = mgrssn;

--2--
select dname , pname from Departments d , Project p where p.dnum = d.dnum order by Dname;

--3--
select CONCAT(fname,' ',lname)as empname , Dependent_name, D.Sex , D.Bdate
from employee , Dependent as D
where ssn = essn;

--4--
select pnumber ,pname, plocation from Project where City='cairo' or city= 'alex';

--5--
select *  from Project where pname like 'a%';

--6--
select * from employee where Dno = 30 and Salary between 1000 and 2000;

--7-----------------
select CONCAT(fname , ' ',lname) as empName from  Employee,Departments, Works_for,Project
where Dno = Departments.Dnum and Dno=10 and ssn=essn and Hours >= 10 and Pno = Pnumber and Pname = 'AL Rabwah';
-- why departments up there?
-- another sol.
select CONCAT(fname , ' ',lname) as empName 
from Employee inner join Departments on Dnum = Dno and Dno=10
inner join Works_for on SSN=ESSn and Hours >= 10
inner join Project on Pno=Pnumber and Pname = 'al rabwah'

--8--
select CONCAT(x.fname , ' ',x.lname) as empName from Employee x , Employee y
where x.Superssn = y.SSN 
and CONCAT(y.fname,' ', y.lname) = 'kamel mohamed';

--9--
select CONCAT(fname , ' ',lname) as empName,pname from employee , Works_for , Project
where ssn = essn and Pno = Pnumber order by Pname;

select CONCAT(fname , ' ',lname) as empName,pname 
from employee left join Works_for on ssn = ESSn
join Project on Pno = Pnumber order by Pname;

--10--
select Pnumber, Dname, Fname, Address, Bdate
from Project join Departments on project.Dnum = Departments.Dnum and City = 'cairo'
join Employee on MGRSSN = SSN

--11--
select Employee.* from Employee, Departments
where MGRSSN = SSN

--12--
select * from Employee left join Dependent on SSN = ESSN;

--13--
insert into employee (ssn, fname,lname, Bdate, Address, Sex, Salary, Superssn, Dno)
values (102672,'mohamed', 'shukry', 11/1/1997, 'tanta', 'M', 10000, 112233, 30)

--14--
insert into employee (ssn, fname,lname, Bdate, Address, Sex, Dno)
values (102660,'ahmed', 'shukry', 6/5/1997, 'tanta', 'M', 30);

--15--
insert into Departments
values ('DEPT IT', 100, 112233, 11/1/2006);