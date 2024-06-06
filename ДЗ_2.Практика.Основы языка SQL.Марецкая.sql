--a) Вывести только BusinessEntityID и LoginID из таблицы HumanResources.Employee для людей женского пола и младше 1969-01-29 (BirthDate). 

select BusinessEntityID, LoginID from HumanResources.Employee
where Gender = 'F' and BirthDate > '1969-01-29'

--вариант для проверки
select * from HumanResources.Employee
select BusinessEntityID, LoginID, Gender, BirthDate from HumanResources.Employee
where Gender = 'F' and BirthDate > '1969-01-29'
order by BirthDate

--b) Вывести уникальные PersonType для людей из Person.Person, где LastName начинается с буквы М или с буквы N и обязательно заполнено поле MiddleName. 

select distinct PersonType from Person.Person
where (LastName like 'M%' or  LastName like 'N%') and MiddleName is not NULL

--вариант для проверки
select * from Person.Person
select PersonType, LastName, MiddleName from Person.Person
where (LastName like 'M%' or  LastName like 'N%') and MiddleName is not NULL
order by LastName

--c) Вывести данные из Sales.SpecialOffer начиная с наибольшего DiscountPct, которые начинали действовать с 2013-01-01 по 2014-01-01 (поле StartDate). 

select * from Sales.SpecialOffer
where StartDate between '2013-01-01' and '2014-01-01'
order by DiscountPct desc

--вариант для проверки
select * from Sales.SpecialOffer
select DiscountPct, StartDate from Sales.SpecialOffer
where StartDate between '2013-01-01' and '2014-01-01'
order by DiscountPct desc

--d) Найти ProductID и Name из Production.Product, где в имени ProductNumber вторая буква “B” и последняя заканчивается на цифру, а ProductID упорядочивается в порядке убывания. 

select ProductID, Name from Production.Product
where ProductNumber like '_B%[0-9]'
order by ProductID desc

--вариант для проверки
select * from Production.Product
select ProductID, Name, ProductNumber from Production.Product
where ProductNumber like '_B%[0-9]'
order by ProductID desc

--e) Вывести ProductId, Name из таблицы Production.Product где цвет либо Red, либо Silver или Black и Size имеет какое-либо значение. 

select ProductID, Name from Production.Product
where Color in ('Red','Silver','Black') and size is not NULL

--вариант для проверки
select * from Production.Product
select ProductID, Name, Color, Size from Production.Product
where Color in ('Red','Silver','Black') and size is not NULL

--f) Вывести уникальные JobTitle из HumanResources.Employee, где SickLeaveHours меньше или равно 15 или VacationHours не больше 20,но также необходимо исключить все JobTitle y которых есть слово ‘Vice President’ или ‘Manager’. 

select distinct JobTitle from HumanResources.Employee
where (SickLeaveHours <= 15 or VacationHours <=20) and (JobTitle not like '%Vice President%' or JobTitle not like '%Manager%')

--вариант для проверки
select * from HumanResources.Employee
select JobTitle, SickLeaveHours, VacationHours from HumanResources.Employee
where (SickLeaveHours <= 15 or VacationHours <=20) and (JobTitle not like '%Vice President%' or JobTitle not like '%Manager%')

--g) Опишите задачу, которая решается следующим выражением:
SELECT LastName, FirstName FROM Person.Person 
WHERE LastName LIKE 'R%' 
ORDER BY FirstName ASC, LastName DESC 

/*Ответ: 
ВЫВЕСТИ КОЛОНКИ LastName, FirstName ИЗ ТАБЛИЦЫ Person.Person 
ГДЕ LastName СОДЕРЖИТ ПЕРВАЯ БУКВА R И ЛЮБОЕ КОЛИЧЕСТВО СИМВОЛОВ 
И СОРТИРОВКА FirstName ПО ВОЗРАСТАНИЮ И LastName ПО УБЫВАНИЮ