-- Generated by Oracle SQL Developer Data Modeler 24.3.0.240.1210
--   at:        2024-11-26 09:09:52 PKT
--   site:      Oracle Database 21c
--   type:      Oracle Database 21c



DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE customer CASCADE CONSTRAINTS;

DROP TABLE department CASCADE CONSTRAINTS;

DROP TABLE employee CASCADE CONSTRAINTS;

DROP TABLE product CASCADE CONSTRAINTS;

DROP TABLE purchase CASCADE CONSTRAINTS;

DROP TABLE skill CASCADE CONSTRAINTS;

DROP TABLE skill_type CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    addressid  NUMBER(15) NOT NULL,
    street     VARCHAR2(50) NOT NULL,
    city       VARCHAR2(50) NOT NULL,
    province   CHAR(2) NOT NULL,
    postalcode CHAR(6) NOT NULL,
    employeeid NUMBER(15),
    customerid NUMBER(15)
);

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( addressid );

CREATE TABLE customer (
    customerid NUMBER(15) NOT NULL,
    firstname  VARCHAR2(50) NOT NULL,
    lastname   VARCHAR2(50) NOT NULL,
    company    VARCHAR2(50)
);

ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customerid );

CREATE TABLE department (
    departmentid   NUMBER(15) NOT NULL,
    departmentname VARCHAR2(50) NOT NULL
);

ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( departmentid );

CREATE TABLE employee (
    employeeid   NUMBER(15) NOT NULL,
    firstname    VARCHAR2(50) NOT NULL,
    lastname     VARCHAR2(50) NOT NULL,
    position     VARCHAR2(50) NOT NULL,
    salary       NUMBER(12, 2) NOT NULL,
    departmentid NUMBER(15) NOT NULL
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employeeid );

CREATE TABLE product (
    productid   NUMBER(15) NOT NULL,
    productname VARCHAR2(50) NOT NULL,
    listedprice NUMBER(12, 2) NOT NULL
);

ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( productid );

CREATE TABLE purchase (
    purchaseid    NUMBER(15) NOT NULL,
    purchasedate  DATE NOT NULL,
    purchaseprice NUMBER(12, 2) NOT NULL,
    deliverydate  DATE NOT NULL,
    customerid    NUMBER(15) NOT NULL,
    productid     NUMBER(15) NOT NULL
);

ALTER TABLE purchase ADD CONSTRAINT purchase_pk PRIMARY KEY ( purchaseid );

CREATE TABLE skill (
    skillid     NUMBER(15) NOT NULL,
    skilllevel  VARCHAR2(50) NOT NULL,
    employeeid  NUMBER(15) NOT NULL,
    skilltypeid NUMBER(15) NOT NULL
);

ALTER TABLE skill ADD CONSTRAINT skill_pk PRIMARY KEY ( skillid,
                                                        employeeid );

CREATE TABLE skill_type (
    skilltypeid   NUMBER(15) NOT NULL,
    skilltypename VARCHAR2(50)
);

ALTER TABLE skill_type ADD CONSTRAINT skill_type_pk PRIMARY KEY ( skilltypeid );

ALTER TABLE address
    ADD CONSTRAINT address_customer_fk FOREIGN KEY ( customerid )
        REFERENCES customer ( customerid );

ALTER TABLE address
    ADD CONSTRAINT address_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE employee
    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( departmentid )
        REFERENCES department ( departmentid );

ALTER TABLE purchase
    ADD CONSTRAINT purchase_customer_fk FOREIGN KEY ( customerid )
        REFERENCES customer ( customerid );

ALTER TABLE purchase
    ADD CONSTRAINT purchase_product_fk FOREIGN KEY ( productid )
        REFERENCES product ( productid );

ALTER TABLE skill
    ADD CONSTRAINT skill_employee_fk FOREIGN KEY ( employeeid )
        REFERENCES employee ( employeeid );

ALTER TABLE skill
    ADD CONSTRAINT skill_skilltype_fk FOREIGN KEY ( skilltypeid )
        REFERENCES skill_type ( skilltypeid );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                             0
-- ALTER TABLE                             15
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0



---- Generated by Oracle SQL Developer Data Modeler 24.3.0.240.1210
----   at:        2024-11-25 20:24:54 PKT
----   site:      Oracle Database 21c
----   type:      Oracle Database 21c
--
--
--
--DROP TABLE ADDRESS CASCADE CONSTRAINTS;
--
--DROP TABLE customer CASCADE CONSTRAINTS;
--
--DROP TABLE department CASCADE CONSTRAINTS;
--
--DROP TABLE employee CASCADE CONSTRAINTS;
--
--DROP TABLE product CASCADE CONSTRAINTS;
--
--DROP TABLE purchase CASCADE CONSTRAINTS;
--
--DROP TABLE skill CASCADE CONSTRAINTS;
--
--DROP TABLE skill_type CASCADE CONSTRAINTS;
--
---- predefined type, no DDL - MDSYS.SDO_GEOMETRY
--
---- predefined type, no DDL - XMLTYPE
--
--CREATE TABLE ADDRESS (
--    addressid  NUMBER(15) NOT NULL,
--    street     VARCHAR2(50) NOT NULL,
--    city       VARCHAR2(50) NOT NULL,
--    province   CHAR(2) NOT NULL,
--    postalcode CHAR(6) NOT NULL,
--    employeeid NUMBER(15),
--    customerid NUMBER(15)
--);
--
--ALTER TABLE ADDRESS ADD CONSTRAINT address_pk PRIMARY KEY ( addressid );
--
--CREATE TABLE customer (
--    customerid NUMBER(15) NOT NULL,
--    firstname  VARCHAR2(50) NOT NULL,
--    lastname   VARCHAR2(50) NOT NULL,
--    company    VARCHAR2(50)
--);
--
--ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY ( customerid );
--
--CREATE TABLE department (
--    departmentid   NUMBER(15) NOT NULL,
--    departmentname VARCHAR2(50) NOT NULL
--);
--
--ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY ( departmentid );
--
--CREATE TABLE employee (
--    employeeid   NUMBER(15) NOT NULL,
--    firstname    VARCHAR2(50) NOT NULL,
--    lastname     VARCHAR2(50) NOT NULL,
--    position     VARCHAR2(50) NOT NULL,
--    salary       NUMBER(12, 2) NOT NULL,
--    departmentid NUMBER(15) NOT NULL
--);
--
--ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employeeid );
--
--CREATE TABLE product (
--    productid   NUMBER(15) NOT NULL,
--    productname VARCHAR2(50) NOT NULL,
--    listedprice NUMBER(12, 2) NOT NULL
--);
--
--ALTER TABLE product ADD CONSTRAINT product_pk PRIMARY KEY ( productid );
--
--CREATE TABLE purchase (
--    purchaseid    NUMBER(15) NOT NULL,
--    purchasedate  DATE NOT NULL,
--    purchaseprice NUMBER(12, 2) NOT NULL,
--    deliverydate  DATE NOT NULL,
--    customerid    NUMBER(15) NOT NULL,
--    productid     NUMBER(15) NOT NULL
--);
--
--ALTER TABLE purchase ADD CONSTRAINT purchase_pk PRIMARY KEY ( purchaseid );
--
--CREATE TABLE skill (
--    skillid     NUMBER(15) NOT NULL,
--    skilllevel  VARCHAR2(50) NOT NULL,
--    employeeid  NUMBER(15) NOT NULL,
--    skilltypeid NUMBER(15) NOT NULL
--);
--
--ALTER TABLE skill ADD CONSTRAINT skill_pk PRIMARY KEY ( skillid,
--                                                        employeeid );
--
--CREATE TABLE skill_type (
--    skilltypeid   NUMBER(15) NOT NULL,
--    skilltypename VARCHAR2(50)
--);
--
--ALTER TABLE skill_type ADD CONSTRAINT skill_type_pk PRIMARY KEY ( skilltypeid );
--
--ALTER TABLE ADDRESS
--    ADD CONSTRAINT ADDRESS_CUSTOMER_FK FOREIGN KEY ( customerid )
--        REFERENCES customer ( customerid );
--
--ALTER TABLE ADDRESS
--    ADD CONSTRAINT ADDRESS_EMPLOYEE_FK FOREIGN KEY ( employeeid )
--        REFERENCES employee ( employeeid );
--
--ALTER TABLE employee
--    ADD CONSTRAINT employee_department_fk FOREIGN KEY ( departmentid )
--        REFERENCES department ( departmentid );
--
--ALTER TABLE purchase
--    ADD CONSTRAINT purchase_customer_fk FOREIGN KEY ( customerid )
--        REFERENCES customer ( customerid );
--
--ALTER TABLE purchase
--    ADD CONSTRAINT purchase_product_fk FOREIGN KEY ( productid )
--        REFERENCES product ( productid );
--
--ALTER TABLE skill
--    ADD CONSTRAINT skill_employee_fk FOREIGN KEY ( employeeid )
--        REFERENCES employee ( employeeid );
--
--ALTER TABLE skill
--    ADD CONSTRAINT skill_skilltype_fk FOREIGN KEY ( skilltypeid )
--        REFERENCES skill_type ( skilltypeid );
--
--
--
---- Oracle SQL Developer Data Modeler Summary Report: 
---- 
---- CREATE TABLE                             8
---- CREATE INDEX                             0
---- ALTER TABLE                             15
---- CREATE VIEW                              0
---- ALTER VIEW                               0
---- CREATE PACKAGE                           0
---- CREATE PACKAGE BODY                      0
---- CREATE PROCEDURE                         0
---- CREATE FUNCTION                          0
---- CREATE TRIGGER                           0
---- ALTER TRIGGER                            0
---- CREATE COLLECTION TYPE                   0
---- CREATE STRUCTURED TYPE                   0
---- CREATE STRUCTURED TYPE BODY              0
---- CREATE CLUSTER                           0
---- CREATE CONTEXT                           0
---- CREATE DATABASE                          0
---- CREATE DIMENSION                         0
---- CREATE DIRECTORY                         0
---- CREATE DISK GROUP                        0
---- CREATE ROLE                              0
---- CREATE ROLLBACK SEGMENT                  0
---- CREATE SEQUENCE                          0
---- CREATE MATERIALIZED VIEW                 0
---- CREATE MATERIALIZED VIEW LOG             0
---- CREATE SYNONYM                           0
---- CREATE TABLESPACE                        0
---- CREATE USER                              0
---- 
---- DROP TABLESPACE                          0
---- DROP DATABASE                            0
---- 
---- REDACTION POLICY                         0
---- 
---- ORDS DROP SCHEMA                         0
---- ORDS ENABLE SCHEMA                       0
---- ORDS ENABLE OBJECT                       0
---- 
---- ERRORS                                   0
---- WARNINGS                                 0
