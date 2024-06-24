--При каких значениях оконные функции Row_number, Rank и Dense_rank вернут одинаковый результат?
--в случае если в колонке по которой мы ранжируем не будет повторяющихся строк например если проранжируем колонку с первичным ключом ID 

---------a
select * from [Production].[UnitMeasure]

select [UnitMeasureCode] 
from [Production].[UnitMeasure]
where [UnitMeasureCode] like 'T%'

select distinct count ([UnitMeasureCode])
from [Production].[UnitMeasure]

select * from [Production].[UnitMeasure]
insert [Production].[UnitMeasure]
values
('TT1','Test 1', getdate() - 1381),
('TT2','Test 2', getdate());

--DELETE FROM [Production].[UnitMeasure] WHERE [UnitMeasureCode]='TT1';

---------b
/*CREATE DATABASE Test

select *
into Test
from [Production].[UnitMeasure];

select *
from Test
*/

select *
into [Production].[UnitMeasureTest]
from [Production].[UnitMeasure];

insert into [Production].[UnitMeasureTest]
select *
from [Production].[UnitMeasure]
where UnitMeasureCode = 'CAN'

select *
from [Production].[UnitMeasureTest]

---------c

update [Production].[UnitMeasureTest]
set UnitMeasureCode = 'TTT'

---------d

delete
from [Production].[UnitMeasureTest]

---------e

select SalesOrderID, AVG(LineTotal)as avgg, MIN(LineTotal) as minn, MAX(LineTotal) as maxx
from [Sales].[SalesOrderDetail]
where SalesOrderID in ('43659','43664')
group by SalesOrderID

---------f

--Представление (VIEW) виртуальная таблица — объект базы данных, являющийся результатом выполнения запроса к базе данных, определенного с помощью оператора SELECT, в момент обращения к представлению.
--папка Views (по кнопке Design м/посмотреть оригинальный запрос)

--?Не поняла как нужно описать функцию Rank чтобы она мне проранжировала по Row Number и Row Number Last одновременно

select * from Sales.vSalesPerson
Order by SalesYTD DESC

SELECT concat (FirstName,' ', LastName) as seller, concat (upper (LEFT (LastName, 3)),'login', (isnull (TerritoryGroup,'_'))) as login,
ROW_NUMBER() OVER (ORDER BY SalesYTD DESC ) AS "Row Number",
ROW_NUMBER() OVER (ORDER BY [SalesLastYear] DESC ) AS "Row Number Last"
--RANK() OVER (Partition by , ORDER BY ) AS "Rank"  
from Sales.vSalesPerson  


