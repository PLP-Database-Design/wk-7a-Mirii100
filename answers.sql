--QUESTION 1 
--i will showcase understanding on First, Second, and Third Normal Forms (1NF, 2NF, 3NF) to eliminate redundancy and optimize data storage.
-- Create a new table to store the data in 1NF
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert data into the new table by splitting the Products column
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail,
    (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3) numbers
WHERE 
    n <= 1 + (LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')))
ORDER BY 
    OrderID, n;

-- end of question  1

--QUESTION 2 

-- Create the Orders table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create the OrderDetails_2NF table to store OrderID, Product, and Quantity
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert unique OrderID and CustomerName into Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Insert OrderID, Product, and Quantity into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- END OF QUESTION 2 
