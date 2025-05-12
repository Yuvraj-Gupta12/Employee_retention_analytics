-- Creating table
create table hr(
EmpID varchar(10) primary key,
Age int,
AgeGroup varchar(10),
Attrition char(10),
BusinessTravel varchar(50),
DailyRate int,
Department varchar(50),
DistanceFromHome int,
Education int,
EducationField varchar(50),
EmployeeCount int,
EmployeeNumber int,
EnvironmentSatisfaction int,
Gender char(10),
HourlyRate int,
JobInvolvement int,
JobLevel int,
JobRole varchar(50),
JobSatisfaction int,
MaritalStatus varchar(20),
MonthlyIncome int,
SalarySlab varchar(50),
MonthlyRate int,
NumCompaniesWorked int,
Over18 char(5),
OverTime char(5),
PercentSalaryHike int,
PerformanceRating int,
RelationshipSatisfaction int,
StandardHours int,
StockOptionLevel int,
TotalWorkingYears int,
TrainingTimesLastYear int,
WorkLifeBalance int,
YearsAtCompany int,
YearsInCurrentRole int,
YearsSinceLastPromotion int,
YearsWithCurrManager int
);
--importing data
copy hr
from 'D:\Data\HR_Analytics.csv'
delimiter ','
csv header;

--data cleaning
--1.Cleaning business travel column
update hr 
set businesstravel='Travel_Rarely' where businesstravel='TravelRarely';

--2.yearswithcurrmanager column
select yearswithcurrmanager,count(yearswithcurrmanager) from hr group by 1 order by 2 desc limit 1;
				--highest frequency is 2
update hr
set yearswithcurrmanager=2 where yearswithcurrmanager is null;

-----------------------------EXPLORATORY DATA ANALYSIS------------------------------------

--1. Total employee
select gender,count(*) as total_count, 
round(count(*)*100/sum(count(*)) over(),2) ||'%' as total_percent
from hr 
group by 1 order by 2 desc;

--2.What is overall attrition rate?
select Round(cast(
	(select count(*) from hr where attrition='Yes') as numeric)*100/
	cast((select count(*) from hr) as numeric),2) || '%' 
as attrition_rate;

--3. Attrition on the basis of gender
select gender,count(*) as total_attrition, 
round(count(*)*100/sum(count(*)) over(),2) ||'%' as attrition_rate
from hr 
where attrition = 'Yes'
group by 1 order by 2 desc;


--4.Which departments and job role have the highest attrition rates?
select department,jobrole,count(*) as atr,
round(count(*)*100/sum(count(*)) over(),2) ||'%' as attrition_rate 
from hr 
where attrition='Yes' 
group by 1,2 order by 3 desc;

--5.Attrition by education
select educationfield,count(*) as Total_attrition,
round(count(*)*100/sum(count(*)) over(),2) ||'%' as attritoin_rate
from hr where attrition='Yes' 
group by 1  order by 2 desc;

--6.Salary vs attrition
select salaryslab,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--7.hike vs attrition
select percentsalaryhike,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--8.attrition by performance rating
select performancerating,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--9.tenure affecting attrition
select totalworkingyears,count(*) as Total_attriton
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--10.attrition by age and gender
select gender,age,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1,2 order by 3 desc;

--11. Worklifebalance vs attrition
select WorkLifeBalance,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--12.jobsatisfaction vs attrition
select jobsatisfaction,count(*) as attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--13. promotion vs attrition
select yearssincelastpromotion,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--14. currentrole vs attrition
select YearsInCurrentRole,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--15. Manager vs attrition.
select yearswithcurrmanager,count(*) as Total_attririon
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;

--16. Attrition on the  basis of businesstravel
select businesstravel,count(*) as Total_attrition
from hr 
where attrition='Yes' 
group by 1 order by 2 desc;




