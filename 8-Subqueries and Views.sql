CREATE DATABASE CountryDB;
USE CountryDB;

CREATE TABLE Country (
    Country_Id INT PRIMARY KEY AUTO_INCREMENT,
    Country_Name VARCHAR(50) NOT NULL,
    Population INT NOT NULL
);

CREATE TABLE Persons (
    Person_Id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Country_Id INT NOT NULL,
    Rating FLOAT NOT NULL,
    FOREIGN KEY (Country_Id) REFERENCES Country(Country_Id)
);


INSERT INTO Country (Country_Name, Population)
VALUES
('USA', 331002651),
('India', 1380004385),
('Germany', 83783942),
('France', 65273511),
('Japan', 126476461);

INSERT INTO Persons (Name, Country_Id, Rating)
VALUES
('Alice', 1, 4.5),
('Bob', 1, 3.2),
('Charlie', 2, 3.8),
('Diana', 2, 2.9),
('Eve', 3, 4.0),
('Frank', 4, 3.6),
('Grace', 5, 4.2);

#1. Find the number of persons in each country.
SELECT Country.Country_Name, COUNT(Persons.Person_Id) AS Number_of_Persons
FROM Country
LEFT JOIN Persons ON Country.Country_Id = Persons.Country_Id
GROUP BY Country.Country_Name;

#2. Find the number of persons in each country sorted from high to low.
SELECT Country.Country_Name, COUNT(Persons.Person_Id) AS Number_of_Persons
FROM Country
LEFT JOIN Persons ON Country.Country_Id = Persons.Country_Id
GROUP BY Country.Country_Name
ORDER BY Number_of_Persons DESC;


#3. Find out the average rating for persons in respective countries if the average is greater than 3.0.

SELECT Country.Country_Name, AVG(Persons.Rating) AS Average_Rating
FROM Country
JOIN Persons ON Country.Country_Id = Persons.Country_Id
GROUP BY Country.Country_Name
HAVING AVG(Persons.Rating) > 3.0;

# 4. Find the countries with the same rating as the USA.
SELECT Country_Name
FROM Country
WHERE Country_Id IN (
    SELECT Country_Id
    FROM Persons
    WHERE Rating = (
        SELECT AVG(Rating)
        FROM Persons
        JOIN Country ON Persons.Country_Id = Country.Country_Id
        WHERE Country_Name = 'USA'
    )
);


SELECT Country_Name, Population
FROM Country
WHERE Population > (SELECT AVG(Population) FROM Country);

CREATE DATABASE Product;
USE Product;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY AUTO_INCREMENT,
    First_name VARCHAR(50) NOT NULL,
    Last_name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone_no VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip_code VARCHAR(10),
    Country VARCHAR(50)
);

CREATE VIEW customer_info AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email
FROM Customer;

SELECT * FROM customer_info;



CREATE VIEW US_Customers AS
SELECT *
FROM Customer
WHERE Country = 'US';


CREATE VIEW Customer_details AS
SELECT CONCAT(First_name, ' ', Last_name) AS Full_name, Email, Phone_no, State
FROM Customer;

UPDATE Customer
SET Phone_no = 'New_Phone_Number'
WHERE State = 'California';

SELECT State, COUNT(Customer_Id) AS Number_of_Customers
FROM Customer
GROUP BY State
HAVING COUNT(Customer_Id) > 5;

SELECT State, COUNT(*) AS Number_of_Customers
FROM Customer_details
GROUP BY State;

SELECT *
FROM Customer_details
ORDER BY State ASC;



