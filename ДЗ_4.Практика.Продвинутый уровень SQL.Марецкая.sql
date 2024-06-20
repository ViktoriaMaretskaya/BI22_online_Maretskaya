-------------------------------------------------------------------№3

--a)Найти людей из таблицы Person.Person (вывести только их имена в 1 колонку: вместе Имя и Фамилию), 
--у которых более, чем 1 телефон (самостоятельно найти таблицу, которая хранит телефоны людей и связаться с ней). 

select * from Person.Person

--?ВОПРОС не уверена по какому признаку мы должны точно определить что номер принадлежит одному человеку
--?запрос не срабатывает из-за ошибки

select FirstName, LastName,
cast (concat (FirstName,' ',LastName) as int) as full_name
from Person.Person as pp
inner join [Person].[PersonPhone] as ppp
on pp.[BusinessEntityID] = ppp.[BusinessEntityID]
where full_name > 1
order by full_name

--b)Найти продукты (вывести названия), у которых Вендор (нужная таблица находится на схеме Purchasing) выставил среднюю 
--цену по продукту больше 10. Также в имени вендора должна присутствовать буква А или номер аккаунта вендора должен начинаться на А. 

select * from Purchasing.Vendor
select * from Purchasing.ProductVendor
select * from Production.Product

--?ВОПРОС не уверена по какой стоимости нужно анализировать так как в обоих таблицах Purchasing.ProductVendor и Production.Product есть колонки с названием Price  

select pp.Name, pv.Name, AccountNumber, avg([StandardPrice]) as avg_price
from Purchasing.ProductVendor as ppv 
inner join Production.Product as pp
on pp.ProductID = ppv.ProductID
inner join [Purchasing].[Vendor] as pv
on pv.[BusinessEntityID] = ppv.[BusinessEntityID]
where pv.Name like '%a%' or [AccountNumber] like 'A%'
group by pp.Name, pv.Name, AccountNumber --!все что написано в селекте должно дублироваться в группировке иначе ошибка
having avg ([StandardPrice]) > 10
order by avg_price

--с)Найти имена всех вендоров, продукция которых не продавалась никогда (нет записей в таблице Purchasing.ProductVendor). 
---Для решения этой задачи использовать JOIN, который нарисован ниже: 

select * from Purchasing.Vendor
select * from Purchasing.ProductVendor
order by BusinessEntityID 

--?ВОПРОС правильно ли понимаю если у нас левое соединение то в запросе записи дублируются столько раз сколько совпадают с правой таблицей 
--с которой мы соединяем по ключу, т к в левой таблице записи уникальны и нет повторов а в правой неуникальны и есть повторяющиеся записи по ключу

select pv.Name, pv.[BusinessEntityID] as pv, ppv.[BusinessEntityID] as ppv
from Purchasing.Vendor as pv 
left join Purchasing.ProductVendor as ppv 
on pv.[BusinessEntityID] = ppv.[BusinessEntityID]
where ppv.BusinessEntityID is null

-----------------------------------------------------------------№4

--a)  Вывести имена всех сотрудников и департаменты, в которых они работают 

select emp_name
from emp 
inner join dep
on emp.dep_id = dep.dep_id

--b)  Вывести департаменты и кол-во сотрудников, работающих в них 

select dep_name, count(DISTINCT emp_id) --считаем кол уникальных сотрудников
from emp 
inner join dep
on emp.dep_id = dep.dep_id
group by dep_name

--c) Сделать из имени сотрудника емейл, чтобы из «Maryia Paulava» получилось «maryia_paulava@gmail.com» 

SELECT emp_name
concat (lower (replace(emp_name, ' ', '_')), '@gmail.com')
FROM emp 

--d) Найти департамент с самой большой прибылью, вывести имя и суммарную прибыль только 1го (лучшего) департамента. NULL – неизвестный департамент, его ОБЯЗАТЕЛЬНО учитываем! Если нужно – заменяем на «N.D.»

select top 1 COALESCE(dep_name, N.D.)
from emp 
inner join dep
on emp.dep_id = dep.dep_id
inner join rev
on emp.emp_id = rev.emp_id
group by dep_name
order by revenue desc

----------------------------------------------------------------№5 
--Задачи с ДАТАМИ. Для этих задач используйте тфблицу Purchasing.ProductVendor, колонка для работы с фильтрами по датам – LastReceiptDate. 
--Все запросы должны быть универсальны и не привязаны к конкретной сегодняшней дате. 

select * from Purchasing.ProductVendor

--a) Вывести данные за последние 10 лет. (используй DATEDIFF и CURRENT_TIMESTAMP) 

select * ,
--select LastReceiptDate, CURRENT_TIMESTAMP as day_today,
DATEDIFF (yy, LastReceiptDate, CURRENT_TIMESTAMP) as result
from Purchasing.ProductVendor
--where result <=10 --?вопрос почему не срабатывает строка которая закомменчена, ведь я сделала альяс на функцию чтобы укоротить запрос а так получается что функцию нужно писать два раза
where DATEDIFF (yy, LastReceiptDate, CURRENT_TIMESTAMP) <=10

--b) Вывести данные о событиях, которые произошли в такой же месяц как сегодня. 

select CURRENT_TIMESTAMP + 20

select * 
--month (LastReceiptDate) as lrd,
--month (CURRENT_TIMESTAMP + 20) as result -- ?вопрос есть ли такой синтаксис для изменения текущей даты в запросе, чисто интуитивно попробовала и сработало
from Purchasing.ProductVendor
where month (LastReceiptDate) = month (CURRENT_TIMESTAMP + 20) 

--c) Вывести дни недели (словами) и количество событий в них. (Результат – максимум 7 строк на каждый день недели).  

--?Мне кажется или можно было бы упростить здесь мне пришлось 2 раза продублировать функцию dataname чтобы обратиться к  колонке, а если обращаюсь через альяс выдает ошибку

select datename (dw, LastReceiptDate) as dweek, count (datename (dw, LastReceiptDate)) as dcount
from Purchasing.ProductVendor
group by datename (dw, LastReceiptDate), datepart (dw, LastReceiptDate)
order by datepart (dw, LastReceiptDate)

--d) Вывести в отдельные колонки: день, месяц, год и дополнительно 3 колонки: сколько событий было в такое число, в такой месяц, в такой год (можно использовать подзапросы тут) 

--?не поняла как реализовать через подзапросы и эта тема вызывает затруднения можешь скинуть материалов чтобы разобраться, можно видео

select LastReceiptDate, day (LastReceiptDate) as d, month (LastReceiptDate) as m, year (LastReceiptDate) as y,
count(*) over (partition by day (LastReceiptDate)) as cd,
count(*) over (partition by month (LastReceiptDate)) as cm,
count(*) over (partition by year (LastReceiptDate)) as cy
from Purchasing.ProductVendor
group by LastReceiptDate, day (LastReceiptDate), month (LastReceiptDate), year (LastReceiptDate)
