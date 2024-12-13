-- Insert into GUEST
Insert into GUEST(FirstName, LastName, City) 
Values('Justin', 'Hackman', 'Miami');
Insert into GUEST(FirstName, LastName, City) 
Values('Kristoff', 'Kurn', 'Columbia');
Insert into GUEST(FirstName, LastName, City) 
Values('Billy', 'Elliot', 'Columbia');
Insert into GUEST(FirstName, LastName, City) 
Values('Deena', 'Donor', 'New York');
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