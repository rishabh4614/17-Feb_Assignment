
--1]	Write a T-SQL Program to generate complete payslip of a given employee with respect to the following condition
--	a) HRA as 10% Of sal
--	b) DA as 20% of sal
--	c) PF as 8% of sal
--	d) IT as 5% of sal
--	e) Deductions as sum of PF and IT
--	f) Gross Salary as sum of SAL,HRA,DA and Deductions
--	g) Net salary as Gross salary- Deduction



use zensarDB
select * from employee

select empname,
salary,
salary/10010 as HRA,
salary/10020 as DA,
salary/1008  as PF,
salary/1005  as IT ,
salary/1008 + salary/1005 as Deduction,
salary + salary/10010 + salary/10020 as GrossSalary,
(salary + salary/10010 + salary/10020) - (salary/1008 + salary/1005)
as NetSalary
from employee;

--2] Write a T-SQL Program to Display complete result of a given student.
   (Note: Consider 10th standard result sheet and Student table structure as
   (sno,sname,maths,phy,comp)



create table student (sno int,sanme varchar(10),maths float,phy float,comp float)

insert into student values(1,'Sakshi',99,75,86),
(2,'Saurabh',96,63,81),(3,'Pranav',89,56,89),
(4,'Girish',78,59,65),(5,'Shivam',78,41,65)

select * from student

create table ResultSheet10 (Sno int ,Maths float,Phy float,Comp float,total float,aggregate float)
insert into resultSheet10 select sno , maths,phy,comp,maths+phy+comp,(maths+phy+comp)*100/300 from student
select * from ResultSheet10


--3] Write a T-SQL Program to find the factorial of a given number.



create procedure factorial @num int
as
begin
declare @fact int
set @fact = 1
print 'Factorial of ' + convert(varchar,@num) + ':'
while(@num > 0)
begin
set @fact = @num * @fact
set @num = @num - 1
end
print @fact
end

exec dbo.factorial 10

Factorial of 10:
3628800
Completion time: 2022-02-18T15:56:35.5895937+05:30


--4] Create a stored procedure to generate multiplication tables up to a given number.


create procedure multiplication1  @num int
as
begin
declare @i int
set @i = 1;
declare @j int
set @j = 1;
print 'Multipliction tables upto ' + convert(varchar, @num) + ':'
while (@j <= @num)
begin
while (@i <= 10)
begin
print convert(varchar, @j) + ' x ' + convert(varchar,@i) + '= ' + convert(varchar, @i*@j);
set @i = @i + 1;
end
print '------------------'
set @i = 1
set @j = @j + 1;
end
end


exec dbo.multiplication1 3


--5]  Create a user defined function calculate Bonus for all employees of a  given job
  --  using following conditions
   --        a. For Deptno10 employees 15% of sal as bonus.
   --        b. For Deptno20 employees  20% of sal as bonus
    --       c. For Others employees 5%of sal as bonus





create table Emp (Empid int,Empname varchar(20),Salary float,Dept int)

insert into Emp values (1,'Sakshi',5000,10),
(2,'Saurabh',8000,30),(3,'Pranav',7000,20),
(4,'Girish',6000,10),(5,'Sana',2500,40),
(6,'Shivam',12000,20),(7,'Shubham',9000,10),
(8,'Manavi',7800,20),(9,'Sanskruti',6300,30),
(10,'Sanyami',8560,20)

select * from Emp

—select Empid, Empname, Salary,Salary/100*15 as Bonus,Dept from Emp where Dept = 10
—select Empid, Empname, Salary,Salary/100*20 as Bonus,Dept from Emp where Dept = 20
—select Empid, Empname, Salary,Salary/100*5 as Bonus ,Dept from Emp where Dept not in(10,20)

create or alter function Emp_bonus1 (@deptid int)
returns @EmpBonus table (Empid int,Empname varchar(20),Salary float,bonus float,Dept int)
as begin
if @deptid = 10
begin
insert into @EmpBonus
select Empid, Empname, Salary,Salary/100*15 as Bonus,Dept from Emp where Dept = @deptid
end
else if @deptid = 20
begin
insert into @EmpBonus
select Empid, Empname, Salary,Salary/100*20 as Bonus,Dept from Emp where Dept = @deptid
end
else
begin
insert into @EmpBonus
select Empid, Empname, Salary,Salary/100*5 as Bonus,Dept from Emp where Dept = @deptid
end
return
end

select * from Emp_bonus1(10)
select * from Emp_bonus1(20)
select * from Emp_bonus1(30)
select * from Emp_bonus1(40)



--6]       Create a trigger to restrict data manipulation on EMP table during General holidays.
	-- Display the error message like “Due to Independence day you cannot manipulate data”
   --      Note: Create holiday table as (holiday_date,Holiday_name) store at least 4 holiday details




 create table Holiday (Holiday_date varchar(20),Holiday_Name varchar(20))
 
insert into Holiday values
('26-JAN','Republic Day'),
('15-AUG','Independence Day'),
('5-SEP','Teachers Day'),
('25-DEC','Christmas'),
('2-OCT','Gandhi Jayanthi')
 
select *from Holiday
 
create or alter trigger RestrictDataManipulation
on Holiday
instead of update
as
  Raiserror('Due to Public Holiday you cannot manipulate data',16,1)

  update Holiday set Holiday_date='21-Jan' where Holiday_date='26-JAN'
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
Loading complete