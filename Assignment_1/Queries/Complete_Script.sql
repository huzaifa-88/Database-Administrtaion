

-- Step 2
DROP TABLE FEE CASCADE CONSTRAINTS;
DROP TABLE GUEST CASCADE CONSTRAINTS;
DROP TABLE FEE_TYPE CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE CASCADE CONSTRAINTS;

CREATE TABLE FEE_TYPE (
    FeeTypeID Number(10) GENERATED AS Identity,
    FeeTypeName     VARCHAR2(30),
    DefaultAmount   NUMBER(6, 2),
    CONSTRAINT FeeTypePK PRIMARY KEY (FeeTypeID)
);

CREATE TABLE GUEST (
    GuestId   NUMBER(10) GENERATED AS IDENTITY,
    FirstName VARCHAR2(30) NOT NULL,
    LastName  VARCHAR2(30),
    City      VARCHAR2(40),
    Province  CHAR(2),
    CONSTRAINT GuestPK PRIMARY KEY (GuestId)
);
CREATE TABLE EMPLOYEE (
    EmployeeId NUMBER(10) GENERATED AS IDENTITY,
    FirstName  VARCHAR2(30),
    LastName   VARCHAR2(30),
    Title      VARCHAR2(30),
    City       VARCHAR2(40),
    Province   CHAR(2),
    Wage       NUMBER(8, 2),
    WageType   VARCHAR2(10),
    ManagerID  NUMBER(10),
    CONSTRAINT EmployeePK PRIMARY KEY (EmployeeID),
    CONSTRAINT ManagerFK FOREIGN KEY(ManagerID) REFERENCES Employee(EmployeeID)
);
CREATE TABLE FEE (
    FeeID               NUMBER(10)  GENERATED AS IDENTITY,
    FeeName             VARCHAR2(30) NOT NULL,
    FeeDescription      VARCHAR2(300),
    DateCharged         DATE,
    FeeCharged          NUMBER(6, 2),
    GuestID             NUMBER(10),
    FeeTypeID           NUMBER(10),
    EmployeeID          NUMERIC(10),
    CONSTRAINT FeePK PRIMARY KEY (FeeID),
    CONSTRAINT Fee_FeeTypeFK FOREIGN KEY (FeeTypeID) REFERENCES FEE_TYPE(FeeTypeID),
    CONSTRAINT FeeGuestFK FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID),
    CONSTRAINT FeeEmployeeFK FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

-- Step 3
--Inserting data into Tables
--Insert into Guest
Insert into GUEST(FirstName, LastName, City) 
Values('Justin', 'Hackman', 'Miami');
Insert into GUEST(FirstName, LastName, City) 
Values('Kristoff', 'Kurn', 'Columbia');
Insert into GUEST(FirstName, LastName, City) 
Values('Billy', 'Elliot', 'Columbia');
Insert into GUEST(FirstName, LastName, City) 
Values('Deena', 'Donor', 'New York');
commit;
select * from Guest;

--Insert into FEE_TYPE
Insert into FEE_TYPE(FeeTypeName, DefaultAmount) 
Values('Deposit', 2000);
Insert into FEE_TYPE(FeeTypeName, DefaultAmount) 
Values('Discount', 400);
Insert into FEE_TYPE(FeeTypeName, DefaultAmount) 
Values('Rate', 200);
Insert into FEE_TYPE(FeeTypeName, DefaultAmount) 
Values('SmokeDamage', 100);
Insert into FEE_TYPE(FeeTypeName, DefaultAmount) 
Values('CarpetDamage', 1000);
commit;
select * from FEE_TYPE;


--Insert into FEE
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-02', 'YYYY-MM-DD'), 50, 1, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-02', 'YYYY-MM-DD'), -30, 1, 2);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-02', 'YYYY-MM-DD'), 40, 1, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-08', 'YYYY-MM-DD'), 40, 1, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-17', 'YYYY-MM-DD'), 40, 1, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-27', 'YYYY-MM-DD'), 40, 1, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Discount', TO_DATE('23-02-27', 'YYYY-MM-DD'), -20, 1, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-03', 'YYYY-MM-DD'), 40, 2, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-03', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-04', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-05', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-06', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-07', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-08', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-09', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-10', 'YYYY-MM-DD'), 50, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-11', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-12', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-13', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-14', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-15', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-16', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-17', 'YYYY-MM-DD'), 60, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-17', 'YYYY-MM-DD'), 20, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-17', 'YYYY-MM-DD'), 30, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-17', 'YYYY-MM-DD'), -40, 2, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-01-20', 'YYYY-MM-DD'), 0, 3, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-01-20', 'YYYY-MM-DD'), 30, 3, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-01-01', 'YYYY-MM-DD'), 0, 4, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-01-01', 'YYYY-MM-DD'), 0, 4, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-01', 'YYYY-MM-DD'), 0, 4, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-02-01', 'YYYY-MM-DD'), 0, 4, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-03-01', 'YYYY-MM-DD'), 0, 4, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-03-01', 'YYYY-MM-DD'), 0, 4, 3);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-04-01', 'YYYY-MM-DD'), 0, 4, 1);
Insert into FEE(FeeName, DateCharged, FeeCharged, GuestID, FeeTypeID) 
Values('Deposit', TO_DATE('23-04-01', 'YYYY-MM-DD'), 0, 4, 3);
commit;

-- Step 4
UPDATE FEE f
SET f.FeeDescription = (
    SELECT g.FirstName || ' paid ' || ft.FeeTypeName || ' Fee'
    FROM GUEST g
    JOIN FEE_TYPE ft ON ft.FeeTypeID = f.FeeTypeID
    WHERE g.GuestID = f.GuestID
)
WHERE EXISTS (
    SELECT 1 
    FROM GUEST g 
    WHERE g.GuestID = f.GuestID
)
AND EXISTS (
    SELECT 1
    FROM FEE_TYPE ft 
    WHERE ft.FeeTypeID = f.FeeTypeID
);
commit;

--Inserting Data into Employee Table
--Step 8
INSERT INTO Employee (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Deena', 'Donor', 'Manager', 'Washingtion', 'ST', 60000, 'Salary');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Bob', 'Smith', 'Service Manager', 'Chicago', 'ST', 50000, 'Salary');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Bob', 'Smith', 'Desk Clerk', 'Los Angeles', 'ST', 35000, 'Hourly');
INSERT INTO EMPLOYEE (FirstName, LastName, Title, City, Province, Wage, WageType)
VALUES ('Tanya', 'Duncan', 'Employee', 'Chicage', 'ST', 40000, 'Salary');
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




--Queries
--Step 9
SELECT 
    E2.FirstName AS "SUBORDINATE FIRSTNAME", 
    E2.LastName AS "SUBORDINATE LASTNAME", 
    E2.Title AS "SUBORDINATE TITLE",
    E1.FirstName AS "MANAGER FIRSTNAME", 
    E1.LastName AS "MANAGER LASTNAME", 
    E1.Title AS "MANAGER TITLE"
FROM 
    Employee E2
LEFT JOIN 
    Employee E1 ON E2.ManagerID = E1.EmployeeID;

--Step 10
select guestid, SUM(feecharged) as TOTALFEE from Fee group by guestid order by TOTALFEE desc;

-- Step 11
SELECT GUESTID, 
       TOTALFEE AS TOTALFEE
FROM 
    (
        SELECT guestid, 
               SUM(feecharged) AS TOTALFEE
        FROM Fee
        GROUP BY guestid
        ORDER BY TOTALFEE DESC
    );
    
--Step 12
SELECT GUESTID, 
       TOTALFEE AS TOTALFEE,
       CASE
            WHEN ROWNUM = 1 THEN 'A'
            WHEN ROWNUM = 2 THEN 'B'
            WHEN ROWNUM = 3 THEN 'C'
        END AS RANKLETTER
FROM 
    (
        SELECT guestid, 
               SUM(feecharged) AS TOTALFEE
        FROM Fee
        GROUP BY guestid
        ORDER BY TOTALFEE DESC
    )
WHERE ROWNUM <= 3
ORDER BY TOTALFEE DESC;

--Step 13
SELECT 
    GUEST.FirstName, 
    GUEST.LastName, 
    TOTAL_FEE.TOTALFEE, 
    CASE 
        WHEN TOTAL_FEE.ROWNUM_VAL = 1 THEN 'A'
        WHEN TOTAL_FEE.ROWNUM_VAL = 2 THEN 'B'
        WHEN TOTAL_FEE.ROWNUM_VAL = 3 THEN 'C'
    END AS RANKLETTER
FROM 
    GUEST
INNER JOIN 
    (
        SELECT guestid, TOTALFEE, ROWNUM AS ROWNUM_VAL
        FROM (
            SELECT guestid, SUM(feecharged) AS TOTALFEE
            FROM Fee
            GROUP BY guestid
            ORDER BY TOTALFEE DESC
        )
        WHERE ROWNUM <= 3
    ) TOTAL_FEE ON GUEST.guestid = TOTAL_FEE.guestid
ORDER BY GUEST.LastName;

--Step 14
SELECT 
    GUEST.FirstName, 
    GUEST.LastName, 
    TOTAL_FEE.TOTALFEE, 
    CASE 
        WHEN TOTAL_FEE.ROWNUM_VAL = 1 THEN 'A'
        WHEN TOTAL_FEE.ROWNUM_VAL = 2 THEN 'B'
        WHEN TOTAL_FEE.ROWNUM_VAL = 3 THEN 'C'
    END AS RANKLETTER
FROM 
    GUEST
INNER JOIN 
    (
        SELECT guestid, TOTALFEE, ROWNUM AS ROWNUM_VAL
        FROM (
            SELECT guestid, SUM(feecharged) AS TOTALFEE
            FROM Fee
            WHERE fee.feetypeid IN (
                SELECT FeetypeID
                FROM FEE_TYPE
                WHERE FeeTypeName IN ('Rate', 'SmokeDamage')
            )
            GROUP BY guestid
            ORDER BY TOTALFEE DESC
        )
        WHERE ROWNUM <= 3
    ) TOTAL_FEE ON GUEST.guestid = TOTAL_FEE.guestid
ORDER BY GUEST.LastName;






