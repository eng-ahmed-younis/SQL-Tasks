--Weak entity??
create table Instructor (
	ID int primary key identity,
	salary int default 3000,
	hiredate date default getdate(),
	address varchar(50),
	overtime int unique,
	BD date,
	fname varchar(20),
	lname varchar(20),
	age as (year(getdate()) - year(BD)),
	netsalary as (salary + overtime) persisted,
	constraint c1 check(address in ('cairo','alex')),
	constraint c2 check (salary between 1000 and 5000),
);
create table Course (
	CID int primary key identity,
	cname varchar(50),
	duration int unique,
);
create table Lab (
	LID int,
	CID int,
	location varchar(50),
	capacity int,
	constraint c3 foreign key (CID) references Course(CID)
		on delete cascade on update cascade,
	constraint c4 primary key (LID, CID),
	constraint c5 check(capacity <= 20)
);
create table instructor_course (
	ID int,
	CID int,
	constraint c6 foreign key (ID) references Instructor(ID)
		on delete cascade on update cascade,
	constraint c7 foreign key (CID) references Course(CID)
		on delete cascade on update cascade,
	constraint c8 primary key (ID,CID)
);