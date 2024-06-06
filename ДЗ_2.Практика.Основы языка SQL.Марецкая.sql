--a) ������� ������ BusinessEntityID � LoginID �� ������� HumanResources.Employee ��� ����� �������� ���� � ������ 1969-01-29 (BirthDate). 

select BusinessEntityID, LoginID from HumanResources.Employee
where Gender = 'F' and BirthDate > '1969-01-29'

--������� ��� ��������
select * from HumanResources.Employee
select BusinessEntityID, LoginID, Gender, BirthDate from HumanResources.Employee
where Gender = 'F' and BirthDate > '1969-01-29'
order by BirthDate

--b) ������� ���������� PersonType ��� ����� �� Person.Person, ��� LastName ���������� � ����� � ��� � ����� N � ����������� ��������� ���� MiddleName. 

select distinct PersonType from Person.Person
where (LastName like 'M%' or  LastName like 'N%') and MiddleName is not NULL

--������� ��� ��������
select * from Person.Person
select PersonType, LastName, MiddleName from Person.Person
where (LastName like 'M%' or  LastName like 'N%') and MiddleName is not NULL
order by LastName

--c) ������� ������ �� Sales.SpecialOffer ������� � ����������� DiscountPct, ������� �������� ����������� � 2013-01-01 �� 2014-01-01 (���� StartDate). 

select * from Sales.SpecialOffer
where StartDate between '2013-01-01' and '2014-01-01'
order by DiscountPct desc

--������� ��� ��������
select * from Sales.SpecialOffer
select DiscountPct, StartDate from Sales.SpecialOffer
where StartDate between '2013-01-01' and '2014-01-01'
order by DiscountPct desc

--d) ����� ProductID � Name �� Production.Product, ��� � ����� ProductNumber ������ ����� �B� � ��������� ������������� �� �����, � ProductID ��������������� � ������� ��������. 

select ProductID, Name from Production.Product
where ProductNumber like '_B%[0-9]'
order by ProductID desc

--������� ��� ��������
select * from Production.Product
select ProductID, Name, ProductNumber from Production.Product
where ProductNumber like '_B%[0-9]'
order by ProductID desc

--e) ������� ProductId, Name �� ������� Production.Product ��� ���� ���� Red, ���� Silver ��� Black � Size ����� �����-���� ��������. 

select ProductID, Name from Production.Product
where Color in ('Red','Silver','Black') and size is not NULL

--������� ��� ��������
select * from Production.Product
select ProductID, Name, Color, Size from Production.Product
where Color in ('Red','Silver','Black') and size is not NULL

--f) ������� ���������� JobTitle �� HumanResources.Employee, ��� SickLeaveHours ������ ��� ����� 15 ��� VacationHours �� ������ 20,�� ����� ���������� ��������� ��� JobTitle y ������� ���� ����� �Vice President� ��� �Manager�. 

select distinct JobTitle from HumanResources.Employee
where (SickLeaveHours <= 15 or VacationHours <=20) and (JobTitle not like '%Vice President%' or JobTitle not like '%Manager%')

--������� ��� ��������
select * from HumanResources.Employee
select JobTitle, SickLeaveHours, VacationHours from HumanResources.Employee
where (SickLeaveHours <= 15 or VacationHours <=20) and (JobTitle not like '%Vice President%' or JobTitle not like '%Manager%')

--g) ������� ������, ������� �������� ��������� ����������:
SELECT LastName, FirstName FROM Person.Person 
WHERE LastName LIKE 'R%' 
ORDER BY FirstName ASC, LastName DESC 

/*�����: 
������� ������� LastName, FirstName �� ������� Person.Person 
��� LastName �������� ������ ����� R � ����� ���������� �������� 
� ���������� FirstName �� ����������� � LastName �� ��������