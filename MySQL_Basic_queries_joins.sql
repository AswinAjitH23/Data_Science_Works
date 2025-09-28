create database EmpProject;  -- To create a new database

use EmpProject;  -- To use the created database

create table Department(DeptId varchar(5) primary key,      
	DeptName varchar(15) not null, Dept_off varchar(10) not null,
    DeptHead int not null);
    
alter table Department add constraint foreign key(DeptHead) references Employees(EmpID);

create table Employees(EmpId int primary key,
	EmpName varchar(15) not null, Department varchar(5) not null,
    ContactNo int not null, EmailId varchar(25) not null, EmpHeadId int not null,
    foreign key(Department) references Department(DeptId));
    
alter table Employees add constraint foreign key(EmpHeadId) references Employees(EmpID);  -- altering a table by adding foreign constraint
    
create table EmpSalary(EmpId int primary key, Salary int not null, 
	IsPermanent varchar(3), foreign key(EmpId) references Employees(EmpId));
    
create table Project(ProjectId varchar(4) primary key, Duration int not null);

create table Country(CId varchar(3) primary key, CName varchar(12) not null);

create table Client(ClientId varchar(4) primary key, ClientName varchar(15) not null, CId varchar(3),
	foreign key (CId) references Country(CId));
 
create table EmployeeProject(EmpId int primary key, ProjectId varchar(4) not null,
	ClientId varchar(4) not null, StartYear int not null, EndYear int, 
    foreign key(EmpId) references Employees(EmpId),
    foreign key(ProjectId) references Project(ProjectId), 
    foreign key(ClientId) references Client(ClientID));
    

insert into Department values('E-101','HR', 'Monday', 105), ('E-102', 'Development', 'Tuesday', 101),
	('E-103', 'House Keeping', 'Saturday', 103), ('E-104', 'Sales', 'Sunday', 104),
    ('E-105', 'Purchase', 'Tuesday', 104);
    
insert into Employees values(101, 'Isha', 'E-101', 1234567890, 'isha@gamil.com', 105), 
	(102, 'Priya', 'E-104', 1234567890, 'priya@yahoo.com', 103),
    (103, 'Neha', 'E-101', 1234567890, 'neha@gmail.com', 101),
    (104, 'Rahul', 'E-102', 1234567890, 'rahul@yahoo.com', 105),
    (105, 'Abhishek', 'E-101', 1234567890, 'abhishek@gmail.com', 102);
    
insert into EmpSalary  values(101, 2000, 'Yes'), (102, 10000, 'Yes'), (103, 5000, 'No'), (104, 1900, 'Yes'), 
	(105, 2300, 'Yes');

insert into Project values('p-1', 23), ('p-2', 15), ('p-3',45), ('p-4', 2), ('p-5',30);

insert into Country values('c-1', 'India'), ('c-2','USA'), ('c-3', 'China'), ('c-4', 'Pakistan'), ('c-5', 'Russia');

insert into Client values('cl-1','ABC Group','c-1'), ('cl-2','PQR','c-1'), ('cl-3','XYZ','c-2'), ('cl-4','Tech Altum','c-3'),
	('cl-5','mnp','c-5');
    
insert into EmployeeProject values(101,'p-1','cl-1',2010,2010), (102,'p-2','cl-2',2010,2012), 
	(103,'p-1','cl-3',2013,null), (104,'p-4','cl-1',2014,2015), (105,'p-4','cl-5',2015,null);

-- 1.List all Employees.     
select EmpId, EmpName, Department, ContactNo, EmailId, EmpHeadId 
from Employees;

-- 2.List all Departments.
select DeptId, DeptName, Dept_off, DeptHead 
from Department;

-- 3.List all Projects.
select EmpId, Salary, IsPermanent 
from EmpSalary;

-- 4.List all Countries. 
select ProjectId, Duration 
from Project;

-- 5.List all Clients. 
select CId, CName 
from Country;

-- 6.List all employee salaries.
select ClientId, ClientName, CId 
from Client;

-- 7.List all employee project details.
select EmpId, ProjectId, ClientId, StartYear, EndYear 
from EmployeeProject;

-- 8. Select the employees who are not permanent.
select EmpId 
from EmpSalary 
where IsPermanent = 'No';

-- 9. Select all employees whose employeehead is 105. 
select EmpId, EmpName 
from Employees 
where EmpHeadId = 105;

-- 10.Select the details of the employee whose name starts with P.
select EmpId, EmpName, Department, ContactNo, EmailId, EmpHeadId 
from Employees 
where EmpName like 'P%';

-- 11.Select the details of the employee who work either for department E-104 or E-102. 
select EmpId, EmpName, Department, ContactNo, EmailId, EmpHeadId 
from Employees 
where Department='E-102' or Department = 'E-104';
-- select EmpId, EmpName, Department, ContactNo, EmailId, EmpHeadId from Employees where Department in ('E-102','E-104');

-- 12.What is the department name for DeptID E-102? 
select DeptName 
from Department 
where DeptId = 'E-102';

-- 13.What is total salary that is paid to permanent employees? 
select sum(Salary) as TotalSalaryPermanentEmp 
from EmpSalary 
where IsPermanent = 'Yes';

-- 14.How many permanent candidate take salary more than 5000. 
select count(EmpId) as Total_Emp 
from EmpSalary 
where IsPermanent = 'Yes' and Salary > 5000;

-- 15.Select the detail of employee whose emailId is in gmail.
select EmpId, EmpName, Department, EmailId, ContactNo, EmpHeadId 
from Employees 
where EmailId like '%gmail%';

-- 16.List name of all employees whose name ends with a.
select EmpName 
from Employees 
where EmpName like '%a';

-- 17.List the number of employees in each project. 
select count(EmpId) as Count_of_Emp, ProjectId 
from EmployeeProject 
group by ProjectId;

-- 18.How many project started in year 2010.
select count(ProjectId) as CountofProject, StartYear 
from EmployeeProject 
where StartYear = 2010;

-- 19.How many project started and finished in the same year. 
select count(ProjectId) as CountofProjectStartEndSameyear 
from EmployeeProject 
where StartYear = EndYear;

-- 20.select the name of the employee whose name's 3rd charactEr is 'h'.
select EmpName 
from Employees 
where EmpName like '__h%';

-- 21.Fetch the first record from employee project table. 
select EmpId, ProjectId, ClientId, StartYear, EndYear 
from EmployeeProject 
order by EmpId limit 1;

-- 22.Display first 50% records from the country table. 
select CId, CName 
from Country limit 3;

-- 23.Display all employees where name not in Isha and Neha.
select EmpName 
from Employees 
where EmpName not in('Isha','Neha');

-- 24.Display all departments whose Off day is Sunday.
select DeptName 
from Department 
where Dept_off = 'Sunday';

-- 25.Display only the odd rows from the employee table.
select EmpId, EmpName, Department, EmailId, ContactNo, EmpHeadId 
from Employees 
where mod(EmpId,2) = 1;
-- where EmpId % 2 = 1

-- 26.Display the names of all clients in uppercase
select ucase(ClientName) from Client; 

-- 27.Display the years in which the projects started.
select StartYear, ProjectId, ClientId 
from EmployeeProject 
where StartYear is not null;

-- 28.Display the first three characters of country name 
select left(CName,3) as Country 
from Country; 
-- substring(CName,1,3)

-- 29.Display the first three characters of country name in uppercase with the title country code.
select ucase(left(CName,3)) as CountryCode 
from Country;

-- 30.Sort and display employees in the ascending order of their names. 
select EmpId, EmpName, Department, EmailId, ContactNo, EmpHeadId 
from Employees 
order by EmpName;

-- 31.Sort and display employees in the descending order of their names.
select EmpId, EmpName, Department, EmailId, ContactNo, EmpHeadId 
from Employees 
order by EmpName desc;

-- Join Queries

-- 1.Select the department name of the company which is assigned to the employee whose employee id is greater 103.
select e.EmpId, d.DeptName 
from Employees e 
join Department d on e.Department = d.DeptId 
where EmpId > 103;

-- 2.Select the name of the employee who is working under Abhishek.
select e.EmpName 
from Employees e 
join Employees m on e.EmpHeadId = m.EmpId 
where m.EmpName = 'Abhishek';

-- 3.Select the name of the employee who is department head of HR.
select EmpName 
from Employees e 
join Department d on e.EmpId = d.DeptHead 
where DeptName = 'HR';

-- 4.Select the name of the employee head who is permanent.
select e.EmpName 
from Employees e 
join EmpSalary s on e.EmpId = s.EmpId 
where s.IsPermanent = 'Yes';

-- 5.Select the name and email of the Dept Head who is not Permanent.
select EmpName, EmailId 
from Employees e 
join Department d on e.Department = d.DeptId
join EmpSalary s on e.EmpId = s.EmpId
where s.IsPermanent = 'No';

-- 6.Select the employee whose department off is Monday.
select EmpName 
from Employees e 
join Department d on e.Department = d.DeptId
where Dept_off = 'Monday';

-- 7.Select the Indian client’s details.
select ClientName
from Client cn
join Country c on cn.CId = c.CId
where CName = 'India';

-- 8.Select the details of all employees working in development department.
select EmpId, EmpName, Department 'DeptId', ContactNo, EmailId, EmpHeadId 'ManagerId'
from Employees e
join Department d on e.Department = d.DeptId
where DeptName = 'Development';

-- 9.Select the name, email and salary of the employees
select EmpName, EmailId, Salary
from Employees e
join EmpSalary s on e.EmpId = s.EmpId;

-- 10.Select the name and email of the permanent employees
select EmpName, EmailId
from Employees e
join EmpSalary s on e.EmpId = s.EmpId
where IsPermanent = 'Yes';

-- 11.select employee name, department name, client name, country, project id, duration, start year, end year.
select EmpName, DeptName, ClientName, CName, ep.ProjectId, Duration, StartYear, EndYear
from Employees e
join Department d on e.Department = d.DeptId
join EmployeeProject ep on e.EmpId = ep.EmpId
join Client c on ep.ClientId = c.ClientId
join Country co on c.CId = co.CId
join Project p on ep.ProjectId = p.ProjectId;

-- 12.Display all clients and their respective projects.    
select ClientName, ProjectId
from Client c
join EmployeeProject ep on c.ClientId = ep.ClientId;

-- 13.Display all clients who doesn’t have projects.
select ClientName
from Client c
left join EmployeeProject ep on c.ClientId = ep.ClientId
where ProjectId is null;

-- 14.Display the projects not having employees assigned.
select p.ProjectId
from EmployeeProject ep 
right join Project p on ep.ProjectId = p.ProjectId 
where ep.ProjectId is null;

-- 15.Display all countries and client names
select CName, ClientName 
from Client c
right join Country co on c.CId = co.CId;

-- 16.Display employee name, department name and department head name.
select e.EmpName, DeptName, h.EmpName 'DeptHeadName'
from Employees e
join Department d on e.department = d.DeptId
join Employees h on h.EmpId = d.DeptHead;

-- 17.Display the employees belonging to the same department.
select group_concat(e.EmpName) 'EmpName', d.DeptName 
from Employees e
join Department d on d.DeptId = e.Department
group by d.DeptName;