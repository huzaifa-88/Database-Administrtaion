--Step 3_A
-- add columns to be used for importing into the destination tables

ALTER TABLE ZZZ_DIRECTORY ADD (PrimaryID     NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (EmployeeID    NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (AddressID     NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (SkillID       NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (SkillTypeID   NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (DepartmentID  NUMBER (15));
ALTER TABLE ZZZ_DIRECTORY ADD (SkillLevel    VARCHAR (50));

ALTER TABLE ZZZ_SALES ADD (PrimaryID    NUMBER (15));
ALTER TABLE ZZZ_SALES ADD (CustomerID   NUMBER (15));
ALTER TABLE ZZZ_SALES ADD (AddressID    NUMBER (15));
ALTER TABLE ZZZ_SALES ADD (PurchaseID   NUMBER (15));
ALTER TABLE ZZZ_SALES ADD (ProductID    NUMBER (15));
ALTER TABLE ZZZ_SALES ADD (ListedPrice  NUMBER (10, 2));

ALTER TABLE ZZZ_DIRECTORY ADD (FirstName    VARCHAR (50));
ALTER TABLE ZZZ_DIRECTORY ADD (LastName     VARCHAR (50));
ALTER TABLE ZZZ_DIRECTORY ADD (Street       VARCHAR (50));
ALTER TABLE ZZZ_DIRECTORY ADD (City         VARCHAR (50));
ALTER TABLE ZZZ_DIRECTORY ADD (ProvPostal   VARCHAR (50));
ALTER TABLE ZZZ_DIRECTORY ADD (Province     CHAR (2));
ALTER TABLE ZZZ_DIRECTORY ADD (PostalCode   CHAR (6));

ALTER TABLE ZZZ_SALES ADD (FirstName    VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (LastName     VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (Company      VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (Street       VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (City         VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (ProvPostal   VARCHAR (50));
ALTER TABLE ZZZ_SALES ADD (Province     CHAR (2));
ALTER TABLE ZZZ_SALES ADD (PostalCode   CHAR (6));

-- --------------------------------------------------------

-- split |LastName, FirstName|

UPDATE zzz_DIRECTORY
        SET LastName = TRIM(REGEXP_SUBSTR (EmployeeName, '[^,]+', 1, 1)),
        FirstName = TRIM(REGEXP_SUBSTR (EmployeeName, '[^,]+', 1, 2))
        WHERE EmployeeName LIKE '%,%' ;

-- split |FirstName LastName|

UPDATE zzz_DIRECTORY
        SET FirstName = TRIM(REGEXP_SUBSTR (EmployeeName, '[^ ]+', 1, 1)),
        LastName = TRIM(REGEXP_SUBSTR (EmployeeName, '[^ ]+', 1, 2))
        WHERE EmployeeName NOT LIKE '%,%';

-- ------------------------ 

-- split |LastName, FirstName|

UPDATE zzz_SALES
        SET LastName = TRIM(REGEXP_SUBSTR (CustomerName, '[^,]+', 1, 1)),
        FirstName = TRIM(REGEXP_SUBSTR (CustomerName, '[^,]+', 1, 2))
        WHERE CustomerName LIKE '%,%' AND CustomerName NOT LIKE '%     %';

-- split |FirstName LastName|

UPDATE zzz_SALES
        SET FirstName = TRIM(REGEXP_SUBSTR (CustomerName, '[^ ]+', 1, 1)),
        LastName = TRIM(REGEXP_SUBSTR (CustomerName, '[^ ]+', 1, 2))
        WHERE CustomerName NOT LIKE '%,%' AND CustomerName NOT LIKE '%     %';

-- ------------------------ 

-- split |Company     FirstName LastName|

UPDATE zzz_SALES
        SET Company = TRIM(REGEXP_SUBSTR (REPLACE(CustomerName, '   ', '|'), '[^|]+', 1, 1)),
        LastName = TRIM(REGEXP_SUBSTR (REPLACE(CustomerName, '   ', '|'), '[^|]+', 1, 2))
        WHERE CustomerName LIKE '%     %';

UPDATE zzz_SALES
        SET FirstName = TRIM(REGEXP_SUBSTR (LastName, '[^ ]+', 1, 1)),
        LastName = TRIM(REGEXP_SUBSTR (LastName, '[^ ]+', 1, 2))
WHERE CustomerName LIKE '%     %';

-- ---------------------------------------------------------------------------------

-- split |Street, City, Province, Province, PostalCode|

UPDATE zzz_DIRECTORY
        SET Street = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 1)),
        City = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 2)),
        ProvPostal = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 3));

UPDATE zzz_DIRECTORY
        SET Province = TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 1)),
        PostalCode = TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 2))
                 || TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 3));

UPDATE zzz_SALES
        SET Street = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 1)),
        City = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 2)),
        ProvPostal = TRIM(REGEXP_SUBSTR (Address, '[^,]+', 1, 3));

UPDATE zzz_SALES
        SET Province = TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 1)),
        PostalCode = TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 2))
                 || TRIM(REGEXP_SUBSTR (ProvPostal, '[^ ]+', 1, 3));


-- ---------------------------------------------------------------------------------

-- set up the IDs to normalize the data

UPDATE ZZZ_DIRECTORY
SET PRIMARYID = ROWNUM, SKILLID = ROWNUM;

UPDATE ZZZ_DIRECTORY ZD1
SET EmployeeID = (
    SELECT MIN(PrimaryID) FROM ZZZ_DIRECTORY ZD2
WHERE ZD1.EmployeeName = ZD2.EmployeeName
GROUP BY EmployeeName
);

UPDATE ZZZ_DIRECTORY ZD1
SET DepartmentID = (
    SELECT MIN(PrimaryID) FROM ZZZ_DIRECTORY ZD2
WHERE ZD1.DepartmentName = ZD2.DepartmentName
GROUP BY DepartmentName
);

UPDATE ZZZ_DIRECTORY ZD1
SET SkillTypeID = (
    SELECT MIN(PrimaryID) FROM ZZZ_DIRECTORY ZD2
WHERE ZD1.SkillName = ZD2.SkillName
GROUP BY SkillName
);

UPDATE ZZZ_DIRECTORY ZD1
SET AddressID = (
    SELECT MIN(PrimaryID) FROM ZZZ_DIRECTORY ZD2
WHERE ZD1.EmployeeName || ZD1.Address = 
ZD2.EmployeeName || ZD2.Address
GROUP BY ZD2.EmployeeName || ZD2.Address
);

COMMIT;

-- --------------------------------------------------------

UPDATE ZZZ_SALES
SET PrimaryID = ROWNUM,
PurchaseID = ROWNUM;

UPDATE ZZZ_SALES IS1
SET CustomerID =
    (
    SELECT MIN(PrimaryID) FROM ZZZ_SALES ZS2
WHERE IS1.CustomerName = ZS2.CustomerName
GROUP BY CustomerName
);

UPDATE ZZZ_SALES IS1
SET ProductID =
    (
    SELECT MIN(PrimaryID) FROM ZZZ_SALES ZS2
WHERE IS1.ProductName = ZS2.ProductName
GROUP BY ProductName
);

UPDATE ZZZ_SALES IS1
SET AddressID = (
    SELECT MIN(PrimaryID) + 9999 FROM ZZZ_SALES ZS2
WHERE IS1.CustomerName || IS1.Address = 
ZS2.CustomerName || ZS2.Address
GROUP BY IS1.CustomerName || IS1.Address
);

COMMIT;

-- --------------------------------------------------------

UPDATE ZZZ_DIRECTORY SET SkillLevel = 'Intermediate';

UPDATE ZZZ_SALES IS1
SET ListedPrice =
    (
    SELECT MAX(PurchasePrice) FROM ZZZ_SALES ZS2
WHERE IS1.ProductName = ZS2.ProductName
GROUP BY ProductName
);

COMMIT;


--Step 3_B
SET LINESIZE 200
COLUMN departmentname FORMAT A20
COLUMN position FORMAT A20
COLUMN skillname FORMAT A20

update ZZZ_DIRECTORY 
SET departmentname = Upper(DepartmentName), position = INITCAP(position), skillname = LOWER(skillname);

SELECT DepartmentName, Position, SkillName
FROM ZZZ_DIRECTORY WHERE ROWNUM <= 30;


--Step 11
DELETE FROM SKILL;
DELETE FROM EMPLOYEE;
DELETE FROM DEPARTMENT;
DELETE FROM SKILL_TYPE;

INSERT INTO DEPARTMENT(departmentid, departmentname)
SELECT DISTINCT departmentid, departmentname FROM ZZZ_DIRECTORY;

INSERT INTO SKILL_TYPE(skilltypeid, skilltypename)
SELECT DISTINCT skilltypeid, skillname FROM ZZZ_DIRECTORY;

INSERT INTO EMPLOYEE(employeeid, firstname, lastname, position, salary, departmentid)
SELECT DISTINCT employeeid, firstname, lastname, position, salary, departmentid FROM ZZZ_DIRECTORY;

INSERT INTO SKILL(skillid, skilllevel, employeeid, skilltypeid)
SELECT DISTINCT skillid, skilllevel, employeeid, skilltypeid FROM ZZZ_DIRECTORY;
--when run this query in SQLPLUS commit is neccessary
commit;

--Step 12
DELETE FROM PURCHASE;
DELETE FROM PRODUCT;
DELETE FROM CUSTOMER;

INSERT INTO CUSTOMER(customerid, firstname, lastname, company)
SELECT DISTINCT customerid, firstname, lastname, company FROM ZZZ_SALES
WHERE customerid IS NOT NULL;

INSERT INTO PRODUCT(productid, productname, listedprice)
SELECT DISTINCT productid, productname, listedprice FROM ZZZ_SALES
WHERE productid IS NOT NULL;

INSERT INTO PURCHASE(purchaseid, purchasedate, purchaseprice, deliverydate, customerid, productid)
SELECT DISTINCT purchaseid, purchasedate, purchaseprice, deliverydate, customerid, productid FROM ZZZ_SALES
WHERE purchaseid IS NOT NULL
    AND customerid IS NOT NULL
    AND productid IS NOT NULL;
    
--when run this query in SQLPLUS commit is neccessary
commit;
    
--Step 13
DELETE FROM ADDRESS;

INSERT INTO ADDRESS(addressid, street, city, province, postalcode, employeeid)
SELECT DISTINCT addressid, street, city, province, postalcode, employeeid
FROM ZZZ_DIRECTORY
WHERE addressid IS NOT NULL
  AND street IS NOT NULL
  AND city IS NOT NULL
  AND province IS NOT NULL
  AND postalcode IS NOT NULL;

INSERT INTO ADDRESS(addressid, street, city, province, postalcode, customerid)
SELECT DISTINCT addressid, street, city, province, postalcode, customerid
FROM ZZZ_SALES
WHERE addressid IS NOT NULL
  AND street IS NOT NULL
  AND city IS NOT NULL
  AND province IS NOT NULL
  AND postalcode IS NOT NULL;
  
--when run this query in SQLPLUS commit is neccessary
commit;


--Step 15_A
SET LINESIZE 1000
SET LONG 800

SELECT DBMS_XMLGEN.GETXML(
'
SELECT * FROM EMPLOYEE 
'
) AS XML_DOC
FROM DUAL;


--Step 15_B
SET LINESIZE 100
SET LONG 300
SELECT JSON_OBJECT(
    'EmployeeID' VALUE EmployeeID,
    'FirstName' VALUE FirstName,
    'LastName' VALUE LastName,
    'Position' VALUE Position,
    'Salary' VALUE Salary,
    'DepartmentID' VALUE DepartmentID
)
FROM EMPLOYEE;

