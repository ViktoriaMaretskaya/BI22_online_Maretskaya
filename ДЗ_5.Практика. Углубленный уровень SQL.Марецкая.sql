-----------------------№1
/*
Решите на базе данных AdventureWorks2017 следующую задачу.  
Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:  
a) StandardCost равен 0 или не обозначен – ‘Not for sale’  
b) StandardCost больше 0, но меньше 100  - ‘<$100’ 
c) StandardCost больше 100 (вкл), но меньше 500 - ‘<$500 
d) StandardCost больше 500 (вкл) - ‘>=$500 
*/
select * from [Production].[Product]
select StandardCost from [Production].[Product]

SELECT distinct StandardCost,
CASE 
when StandardCost = 0 or StandardCost is NULL then 'Not for sale'
when StandardCost > 0 and StandardCost <100 then '<$100'
when StandardCost >= 100 and StandardCost <500 then '<$500'
when StandardCost >= 500 then '>=$500'
ELSE ''
END as comment
FROM [Production].[Product]

--2) Попробовать написать это же задание с использованием IIF 

--?как склеить результат в одну колонку

SELECT distinct StandardCost,
IIF(StandardCost = 0 or StandardCost is NULL,'Not for sale','') as comment,
IIF(StandardCost > 0 and StandardCost <100,'<$100','') as comment,
IIF(StandardCost >= 100 and StandardCost <500,'<$500','') as comment,
IIF(StandardCost >= 500,'>=$500','') as comment
FROM [Production].[Product]

--3) Таблица Purchasing.ProductVendor, поле LastReceiptDate для работы с датой. Вывести 4 сезона (лето, осень, зима, весна) и суммарную прибыль (LastReceiptCost).
--Если сумма меньше 2000 – вывести «Do not include». В подсчетах учитывать только тех, у кого AverageLeadTime больше 15. 

--?есть ли проще реализация с преобразованием даты в сезон 

select * from Purchasing.ProductVendor
select AverageLeadTime,LastReceiptDate, LastReceiptCost from Purchasing.ProductVendor

select datepart (MM, LastReceiptDate) as season, sum(LastReceiptCost) as cost, AverageLeadTime,
CASE 
when datepart (MM, LastReceiptDate) in (12,1,2) then 'winter' --?как сгруппировать по сезонам
when datepart (MM, LastReceiptDate) in (3,4,5) then 'spring'
when datepart (MM, LastReceiptDate) in (6,7,8) then 'summer'
when datepart (MM, LastReceiptDate) in (9,10,11) then 'autumn'
when sum (LastReceiptCost) <2000 then 'Do not include' --?это условие не срабатывает и просится в отдельную колонку
ELSE ''
END as name_season
from Purchasing.ProductVendor
where AverageLeadTime > 15
group by datepart (MM, LastReceiptDate), AverageLeadTime

--4) Таблица  Purchasing.ProductVendor. Вывести все записи для AverageLeadTime = 15. Просчитать для каждой строки суммарную прибыль по BusinessEntityID и 
--максимальную прибыль по категориям UnitMeasureCode. Прибыль – колонка LastReceiptCost. 

--?запрос неверно работает

select * from Purchasing.ProductVendor

select AverageLeadTime, BusinessEntityID, sum(LastReceiptCost) as cost, UnitMeasureCode, MAX(LastReceiptCost) OVER(PARTITION BY UnitMeasureCode) AS Max_cost
from Purchasing.ProductVendor
where AverageLeadTime = 15
group by AverageLeadTime, BusinessEntityID, UnitMeasureCode, LastReceiptCost --?почему программа запросила сгруппировать по LastReceiptCost если в запросе колонка находится в агрегатной функции



