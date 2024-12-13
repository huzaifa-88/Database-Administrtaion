INSERT INTO Employee (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Deena', 'Donor', 'Hotel Manager', 'Washingtion', 'ST', 60000, 'Salary');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Bob', 'Smith', 'Service Manager', 'Chicago', 'ST', 50000, 'Salary');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Bob', 'Smith', 'Desk Clerk', 'Los Angeles', 'ST', 35000, 'Hourly');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Tanya', 'Duncan', 'Maintenance', 'Chicage', 'ST', 40000, 'Salary');
--Update ManagerID to establish a connection
UPDATE EMPLOYEE
SET ManagerID = (SELECT EmployeeID FROM EMPLOYEE WHERE FirstName = 'Deena' AND LastName = 'Donor')
WHERE FirstName = 'Bob' AND LastName = 'Smith' AND Title = 'Service Manager';
UPDATE EMPLOYEE
SET ManagerID = (SELECT EmployeeID FROM EMPLOYEE WHERE FirstName = 'Bob' AND LastName = 'Smith' AND Title = 'Service Manager')
WHERE FirstName = 'Bob' AND LastName = 'Smith' AND Title = 'Desk Clerk';
UPDATE EMPLOYEE
SET ManagerID = (SELECT EmployeeID FROM EMPLOYEE WHERE FirstName = 'Bob' AND LastName = 'Smith' AND Title = 'Service Manager')
WHERE FirstName = 'Tanya' AND LastName = 'Duncan';