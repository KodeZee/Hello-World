/*
Author: KodeZee
Start Date: 6/3/2017

------------ SQL Query Practice ------------
Was refreshing myself on SQL concepts and snytax for an upcoming interview by making up a few problem scenarios and writing queries to solve them.

1. What is the top product by gross profit? By quantity sold? 
2. Who is the top purchaser of our highest selling/most profitable product
3. Who are our most profitable customers?

Queried from W3 Schools test database
*/

--Select the top 10 most grossing products
SELECT TOP 10 Products.ProductID, Products.ProductName, Count(OrderDetails.OrderID)  as [# of Orders], 
SUM(OrderDetails.Quantity) as [Total Sold], Products.Price, 
SUM(OrderDetails.Quantity * Products.Price) as [Total Profit]
FROM Products INNER JOIN OrderDetails ON OrderDetails.ProductID = Products.ProductID
Group BY Products.ProductID
ORDER BY [Total Profit] DESC /*Change 'Profit' to 'Sold' for top quantities*/
;

--Select the top 10 purchasers of a given product
SELECT TOP 10 Customers.CustomerID, Customers.CustomerName, OrderDetails.Quantity, OrderDetails.Quantity * Products.Price as [Total Profit]
FROM (((Customers INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID)
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
Where OrderDetails.ProductID = 38 /*Cote de Blaye*/
ORDER BY Quantity Desc
;

--Select the top 10 customers by sales profit
SELECT TOP 10 Customers.CustomerID, Customers.CustomerName, SUM(OrderDetails.Quantity) as [Order Size], SUM(OrderDetails.Quantity * Products.Price) as [Cost] 
FROM (((Customers INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID)
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
GROUP BY Customers.CustomerID, Customers.CustomerName
Order By SUM(OrderDetails.Quantity * Products.Price) desc
;
