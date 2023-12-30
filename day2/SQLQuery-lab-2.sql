select * from employee;

select Fname , Lname , Salary , Dno from employee;

select Pname, Plocation, Dnum from Project;

select Fname ,[ANNUAL COMM]= 1.1* Salary from employee;

select SSN,name = Fname + Lname from employee where salary > 1000;

select SSN,name = Fname + ' '+ Lname, annusal = salary * 12 from employee where salary*12 > 10000;

select name = Fname + ' ' + Lname , salary from employee where sex = 'f';

select dnum , dname from Departments where MGRSSN = 968574;

select pnumber , pname , plocation from Project where dnum = 10;