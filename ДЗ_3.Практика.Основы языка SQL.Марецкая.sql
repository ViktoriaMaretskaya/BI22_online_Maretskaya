USE [AdventureWorks2017];
SELECT
*
FROM Production.Product
Order by ProductSubcategoryID

--a) Найти самый минимальный вес и самый максимальный размер продукта из Production.Product. 

select MAX(Size) as Size, MIN(Weight) as Weight from Production.Product

--b) Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product. 

select MAX(Size) as Size, MIN(Weight) as Weight, ProductSubcategoryID  from Production.Product
Group by ProductSubcategoryID

--c) Найти самый минимальный вес и самый максимальный размер продукта для каждой подкатегории ProductSubcategoryID из Production.Product, где продукты должны иметь конкретный цвет (Color). 

select MAX(Size) as Size, MIN(Weight) as Weight, ProductSubcategoryID, Color  from Production.Product
WHERE Color is not null
Group by ProductSubcategoryID, Color
Order by ProductSubcategoryID

--d) Найти все подкатегории продуктов ProductSubcategoryID из Production.Product, где самый минимальный вес продукта больше 50.

select MIN(Weight) as Weight, ProductSubcategoryID from Production.Product
Group by ProductSubcategoryID
HAVING MIN(Weight) > 50
Order by ProductSubcategoryID

--e) Найти все подкатегории продуктов ProductSubcategoryID из Production.Product, где самый минимальный вес продукта с цветом Black больше 50. 

select MIN(Weight) as Weight, ProductSubcategoryID, Color from Production.Product
WHERE Color = 'Black'
Group by ProductSubcategoryID, Color
HAVING MIN(Weight) > 50
Order by ProductSubcategoryID

--f) Вывести TaxType из Sales.SalesTaxRate, где минимальный TaxRate меньше 7.

SELECT * FROM Sales.SalesTaxRate
SELECT MIN(TaxRate) as TaxRate, TaxType FROM Sales.SalesTaxRate
Group by TaxType
HAVING MIN(TaxRate) < 7 
Order by TaxType
