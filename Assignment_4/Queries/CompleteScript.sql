-- Step 7B
INSERT INTO EMPLOYEE (EmployeeID, FirstName, LastName, EmployeeType, Title, DepartmentID, ManagerID)
SELECT 
    EMPLOYEEID, 
    EMPLOYEEFIRSTNAME AS FirstName, 
    EMPLOYEELASTNAME AS LastName, 
    'FullTime' AS EmployeeType, 
    EMPLOYEETITLE AS Title,
    NULL AS DepartmentID,  -- DepartmentID is not available, so setting it to NULL
    NULL AS ManagerID  -- ManagerID is not provided, so we set it to NULL
FROM IMPORT_MANAGERS
WHERE EMPLOYEEID NOT IN (SELECT EmployeeID FROM EMPLOYEE);
COMMIT;

-- Step 8
-- Update the ManagerID for employees
UPDATE EMPLOYEE e
SET e.ManagerID = 
(
    -- Subquery to get the Manager's EmployeeID
    SELECT m.EMPLOYEEID
    FROM EMPLOYEE m
    JOIN IMPORT_MANAGERS im ON 
        im.MANAGERFIRSTNAME = m.FirstName
        AND im.MANAGERLASTNAME = m.LastName
    WHERE im.EMPLOYEEFIRSTNAME = e.FirstName
      AND im.EMPLOYEELASTNAME = e.LastName
      AND im.EMPLOYEETITLE = e.Title
)
WHERE EXISTS
(
    SELECT 1
    FROM IMPORT_MANAGERS im
    WHERE im.EMPLOYEEFIRSTNAME = e.FirstName
      AND im.EMPLOYEELASTNAME = e.LastName
      AND im.EMPLOYEETITLE = e.Title
);
COMMIT;

-- Step 9
INSERT INTO EMPLOYEE (EmployeeID, FirstName, LastName, EmployeeType, Title, DepartmentID, ManagerID)
SELECT 
    NVL(EMPLOYEEID, 0) AS EmployeeID,
    SALESMANFIRSTNAME AS FirstName,
    SALESMANLASTNAME AS LastName,
    'Sales' AS EmployeeType,
    'Sales Person' AS Title,
    NULL AS DepartmentID,
    NULL AS ManagerID
FROM IMPORT_SALES
WHERE EMPLOYEEID NOT IN (SELECT EmployeeID FROM EMPLOYEE);
COMMIT;


-- Step 10
-- Update EmployeeType to 'Sales' for employees found in IMPORT_SALES table
UPDATE EMPLOYEE
SET EmployeeType = 'Sales'
WHERE EmployeeID IN (SELECT EMPLOYEEID FROM IMPORT_SALES);


-- Step 11
--Part1
SELECT * FROM EMPLOYEE e1
WHERE e1.LastName IN 
(
    SELECT e2.LastName 
    FROM EMPLOYEE e2
    WHERE e1.LastName = e2.LastName
    AND e1.FirstName <> e2.FirstName
);
--Part2
SELECT * FROM PURCHASE p1
WHERE p1.ProductID IN
(
    SELECT p2.ProductID
    FROM PURCHASE p2
    WHERE p1.CustomerID = p2.CustomerID
    AND p1.ProductID = p2.ProductID
    AND p1.PurchasePrice = p2.PurchasePrice
    AND p1.PurchaseDate = p2.PurchaseDate
    AND p1.PurchaseID <> p2.PurchaseID
);

-- Step 12
--Part 1
SELECT * FROM EMPLOYEE e
WHERE e.DepartmentID NOT IN
(
    SELECT d.DepartmentID
    FROM DEPARTMENT d
    WHERE d.DepartmentID IS NOT NULL
);
--Part 2
SELECT * FROM DEPARTMENT d
WHERE d.DepartmentID NOT IN
(
    SELECT e.DepartmentID
    FROM EMPLOYEE e
    WHERE e.DepartmentID IS NOT NULL
);


-- Step 13
--Part 1
SELECT * 
FROM EMPLOYEE
WHERE REGEXP_LIKE(FirstName, '\W')
   OR REGEXP_LIKE(LastName, '\W');
--Part 2
SELECT * 
FROM PURCHASE
WHERE PURCHASEPRICE IS NULL
   OR REGEXP_LIKE(PURCHASEPRICE, '^\d{6,}\.')
   OR REGEXP_LIKE(PURCHASEPRICE, '\.\d{3,}$');
   
-- Step 14
-- Add primary key constraints to parent tables
ALTER TABLE CUSTOMER
ADD CONSTRAINT PK_CUSTOMER PRIMARY KEY (CustomerID);

ALTER TABLE PRODUCT
ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (ProductID);

ALTER TABLE EMPLOYEE
ADD CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EmployeeID);

-- Add primary key constraint to the PURCHASE table
ALTER TABLE PURCHASE
ADD CONSTRAINT PK_PURCHASE PRIMARY KEY (PurchaseID);

-- Add foreign key constraints to PURCHASE
ALTER TABLE PURCHASE
ADD CONSTRAINT FK_PURCHASE_CUSTOMER
FOREIGN KEY (CustomerID)
REFERENCES CUSTOMER (CustomerID);

ALTER TABLE PURCHASE
ADD CONSTRAINT FK_PURCHASE_PRODUCT
FOREIGN KEY (ProductID)
REFERENCES PRODUCT (ProductID);

ALTER TABLE PURCHASE
ADD CONSTRAINT FK_PURCHASE_EMPLOYEE
FOREIGN KEY (EmployeeID)
REFERENCES EMPLOYEE (EmployeeID);


-- Step 15
-- 1. Run CST2355_A4_Users.sql first
-- 2. Then Do step 15 step by step







