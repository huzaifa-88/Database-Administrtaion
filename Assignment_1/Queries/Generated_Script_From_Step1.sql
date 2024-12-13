DROP TABLE FEE CASCADE CONSTRAINTS;
DROP TABLE GUEST CASCADE CONSTRAINTS;
DROP TABLE FEE_TYPE CASCADE CONSTRAINTS;

CREATE TABLE guest (
    guestid   NUMBER GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1 CACHE 20) NOT NULL,
    firstname VARCHAR2(30) NOT NULL,
    lastname  VARCHAR2(30),
    city      VARCHAR2(40),
    province  CHAR(2)
);

ALTER TABLE guest ADD CONSTRAINT guestpk PRIMARY KEY ( guestid );

CREATE TABLE fee_type (
    feetypeid     NUMBER(10) GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1 CACHE 20) NOT NULL,
    feetypename   VARCHAR2(30),
    defaultamount NUMBER(6, 2)
);

ALTER TABLE fee_type ADD CONSTRAINT feetypepk PRIMARY KEY ( feetypeid );

CREATE TABLE fee (
    feeid               NUMBER(10) GENERATED AS IDENTITY (START WITH 1 INCREMENT BY 1 CACHE 20)
        CONSTRAINT nnc_fee_feeid NOT NULL,
    feename             VARCHAR2(30)
        CONSTRAINT nnc_fee_feename NOT NULL,
    feedescription      VARCHAR2(300),
    datecharged         DATE
        CONSTRAINT nnc_fee_datecharged NOT NULL,
    feecharged          NUMBER(10)
        CONSTRAINT nnc_fee_feecharged NOT NULL,
    guestid       NUMBER,
    feetypeid  NUMBER(10)
);

ALTER TABLE fee ADD CONSTRAINT feepk PRIMARY KEY ( feeid );

ALTER TABLE fee
    ADD CONSTRAINT fee_feetypefk FOREIGN KEY ( feetypeid )
        REFERENCES fee_type ( feetypeid );

ALTER TABLE fee
    ADD CONSTRAINT feeguesttfk FOREIGN KEY ( guestid )
        REFERENCES guest ( guestid );