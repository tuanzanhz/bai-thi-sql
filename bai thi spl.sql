CREATE DATABASE AZBank
GO
USE  AZBank
GO
CREATE TABLE CUSTOMER (
    CustomerId int not null PRIMARY KEY,
    Name NVARCHAR(50) null,
    City nvarchar(50) null,
    Country nvarchar(50) null,
    Phone nvarchar(15) null,
    Emaill nvarchar(50) null
)
CREATE TABLE CUSTOMERAccount(
    AccountNumber char(9) not null PRIMARY KEY,
    CustomerId int not null,
    Balance money not null,
    MinAccount money null
)
CREATE TABLE CUSTOMERTransaction(
    TransasctionId int not null PRIMARY KEY,
    AccountNumber char(9) null,
    TransactionDate smalldatetime null,
    Amount money null,
    DepositorWithdraw bit null
)
--Insert into each table at least 3 records.
INSERT INTO CUSTOMER 
VALUES ('100', 'Tuan', 'Ha Noi', 'Ha Dong', '0904567982', 'abc@gmail.com');
INSERT INTO CUSTOMER
VALUES ('102', 'Anh', 'Ho Chi Minh', 'Sai Gon', '0368465682', 'd123@gmail.com');
INSERT INTO CUSTOMER
VALUES ('103' , 'Ha', 'Ha noi', 'Thanh Xuan', '03523748234', 'h456@gmail.com');
SELECT * FROM CUSTOMER

INSERT INTO CUSTOMERAccount
VALUES ('14863834', '100', '100000', '1200');
INSERT INTO CUSTOMERAccount
VALUES ('12477483', '102', '120000', '1300');
INSERT INTO CUSTOMERAccount
VALUES ('11248743', '103', '130000', '1000');
SELECT * FROM CUSTOMERAccount

INSERT INTO CUSTOMERTransaction
VALUES ('100', '14863834', '2019-07-17', '2000','3');
INSERT INTO CUSTOMERTransaction
VALUES ('102', '12477483', '2022-07-12', '100000','5');
INSERT INTO CUSTOMERTransaction
VALUES ('103', '11248743', '2021-02-12', '120000','4');
SELECT * FROM CUSTOMERTransaction

--4. Write a query to get all customers from Customer table who live in ‘Hanoi’.
SELECT * FROM Customer WHERE City = 'Ha Noi'
--Write a query to get account information of the customers (Name, Phone, Email, AccountNumber, Balance).
SELECT [Name],Phone,Emaill,AccountNumber,Balance FROM CUSTOMER
join CustomerAccount ON
Customer.CustomerId = CustomerAccount.CustomerId
--A-Z bank has a business rule that each transaction (withdrawal or deposit) won’t beover $1000000 (One million USDs). Create a CHECK constraint on Amount column of CustomerTransaction table to check that each transaction amount is greater than 0 and less than or equal $1000000.
ALTER TABLE CUSTOMERTransaction
ADD CONSTRAINT CK_Checkwithdrawal CHECK (DepositorWithdraw > 0 and DepositorWithdraw <= 1000000)
--Create a view named vCustomerTransactions that display Name,AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer, CustomerAccount and CustomerTransaction tables.
CREATE VIEW vCUSTOMERTransaction AS
SELECT [Name],CUSTOMERAccount.AccountNumber,TransactionDate,Amount,DepositorWithdraw 
FROM CUSTOMER join CUSTOMERAccount ON Customer.CustomerId = CustomerAccount.CustomerId Join CUSTOMERTransaction ON CUSTOMERTransaction.AccountNumber = CustomerAccount.AccountNumber

SELECT * FROM vCUSTOMERTransaction