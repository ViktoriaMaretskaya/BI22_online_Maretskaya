USE [AdventureWorks2017];
SELECT
*
FROM Production.Product
Order by ProductSubcategoryID

--a) ����� ����� ����������� ��� � ����� ������������ ������ �������� �� Production.Product. 

select MAX(Size) as Size, MIN(Weight) as Weight from Production.Product

--b) ����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product. 

select MAX(Size) as Size, MIN(Weight) as Weight, ProductSubcategoryID  from Production.Product
Group by ProductSubcategoryID

--c) ����� ����� ����������� ��� � ����� ������������ ������ �������� ��� ������ ������������ ProductSubcategoryID �� Production.Product, ��� �������� ������ ����� ���������� ���� (Color). 

select MAX(Size) as Size, MIN(Weight) as Weight, ProductSubcategoryID, Color  from Production.Product
WHERE Color is not null
Group by ProductSubcategoryID, Color
Order by ProductSubcategoryID

--d) ����� ��� ������������ ��������� ProductSubcategoryID �� Production.Product, ��� ����� ����������� ��� �������� ������ 50.

select MIN(Weight) as Weight, ProductSubcategoryID from Production.Product
Group by ProductSubcategoryID
HAVING MIN(Weight) > 50
Order by ProductSubcategoryID

--e) ����� ��� ������������ ��������� ProductSubcategoryID �� Production.Product, ��� ����� ����������� ��� �������� � ������ Black ������ 50. 

select MIN(Weight) as Weight, ProductSubcategoryID, Color from Production.Product
WHERE Color = 'Black'
Group by ProductSubcategoryID, Color
HAVING MIN(Weight) > 50
Order by ProductSubcategoryID

--f) ������� TaxType �� Sales.SalesTaxRate, ��� ����������� TaxRate ������ 7.

SELECT * FROM Sales.SalesTaxRate
SELECT MIN(TaxRate) as TaxRate, TaxType FROM Sales.SalesTaxRate
Group by TaxType
HAVING MIN(TaxRate) < 7 
Order by TaxType
