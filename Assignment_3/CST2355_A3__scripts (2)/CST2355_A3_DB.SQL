SET TERMOUT ON

-- Drop tables ---------------------------------------------------------------

DROP TABLE ADDRESS CASCADE CONSTRAINTS;
DROP TABLE COURSE CASCADE CONSTRAINTS;
DROP TABLE DEPARTMENT CASCADE CONSTRAINTS;
DROP TABLE GRADE CASCADE CONSTRAINTS;
DROP TABLE GRADE_LOOKUP CASCADE CONSTRAINTS;
DROP TABLE PROFESSOR CASCADE CONSTRAINTS;
DROP TABLE PROGRAM CASCADE CONSTRAINTS;
DROP TABLE PROGRAM_COURSE_INT CASCADE CONSTRAINTS;
DROP TABLE SECTION CASCADE CONSTRAINTS;
DROP TABLE SEMESTER CASCADE CONSTRAINTS;
DROP TABLE STUDENT CASCADE CONSTRAINTS;

-- Create tables -------------------------------------------------------------

CREATE TABLE ADDRESS (
    AddressID    NUMBER(10) NOT NULL,
    SuiteNumber  VARCHAR2(10),
    Street       VARCHAR2(100),
    City         VARCHAR2(50),
    Province     CHAR(2),
    PostalCode   CHAR(7),
    StudentID    NUMBER(10) NOT NULL
);

CREATE TABLE COURSE (
    CourseID     NUMBER(10) NOT NULL,
    CourseName   VARCHAR2(30),
    Description  VARCHAR2(100)
);

CREATE TABLE DEPARTMENT (
    DepartmentID    NUMBER(10) NOT NULL,
    DepartmentName  VARCHAR2(30),
    Description     VARCHAR2(100)
);

CREATE TABLE GRADE (
    GradeID       NUMBER(10) NOT NULL,
    PercentGrade  NUMBER(4, 1),
    LetterGrade   CHAR(2),
    SectionID     NUMBER(10) NOT NULL,
    StudentID     NUMBER(10) NOT NULL,
    Professorid   NUMBER(10)
);

CREATE TABLE GRADE_LOOKUP (
    LetterGrade  CHAR(2 BYTE) NOT NULL, 
    MinPercent   NUMBER(4,1) NOT NULL, 
    MaxPercent   NUMBER(4,1) NOT NULL
);

CREATE TABLE PROFESSOR (
    ProfessorID  NUMBER(10) NOT NULL,
    FirstName    VARCHAR2(30),
    LastName     VARCHAR2(30),
    Email        VARCHAR2(255)
);

CREATE TABLE PROGRAM (
    ProgramID     NUMBER(10) GENERATED AS IDENTITY NOT NULL,
    ProgramName   VARCHAR2(30),
    Description   VARCHAR2(100),
    DepartmentID  NUMBER(10) NOT NULL
);

CREATE TABLE PROGRAM_COURSE_INT (
    ProgramCourseID  NUMBER(10) GENERATED AS IDENTITY NOT NULL,
    ProgramID        NUMBER(10) NOT NULL,
    CourseID         NUMBER(10) NOT NULL
);

CREATE TABLE SECTION (
    SectionID      NUMBER(10) GENERATED AS IDENTITY NOT NULL,
    Semester       CHAR(3) NOT NULL,
    SectionNumber  NUMBER(5),
    SectionName    VARCHAR2(30),
    StartDate      DATE,
    EndDate        DATE,
    CourseID       NUMBER(10) NOT NULL,
    ProfessorID    NUMBER(10)
);

CREATE TABLE SEMESTER (
    Semester     CHAR(3) NOT NULL,
    Description  VARCHAR2(100)
);

CREATE TABLE STUDENT (
    StudentID      NUMBER(10) NOT NULL,
    StudentNumber  NUMBER(9),
    FirstName      VARCHAR2(30),
    LastName       VARCHAR2(30)
);


-- Add INSERT / UPDATE behaviour ---------------------------------------------

CREATE OR REPLACE TRIGGER SECTION_UPDATE 
BEFORE INSERT OR UPDATE ON SECTION FOR EACH ROW
DECLARE
    varCourseName VARCHAR(30);
BEGIN
    SELECT CourseName INTO varCourseName FROM COURSE WHERE COURSE.CourseID = :NEW.CourseID;
    
    :NEW.SectionName := :NEW.Semester || '_' || varCourseName || '_' || :NEW.SectionNumber;
END;
/

-- Insert Data ----------------------------------------------------------

INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (1,null,'4470 Derry Rd','Malton','ON','L4T 1A8',1);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (2,null,'3262 Parkdale Ave','Cornwall','ON','K6H 6Y4',1);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (3,'201','4731 Tycos Dr','Toronto','ON','M5T 1T4',1);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (4,null,'455 Port Washington Road','Enchant','AB','T0K 0V0',2);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (5,null,'1250 Wallbridge Loyalist Rd','Belleville','ON','K8N 1L9',2);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (6,null,'2546 chemin Georges','Chertsey','QC','J0K 3K0',2);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (7,'77','1521 Boulevard Laflèche','St Georges','QC','G5Y 1X7',3);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (8,null,'2184 Carter Crescent','North River','NS','B2N 5B5',3);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (9,null,'4235 St Marys Rd','Winnipeg','MB','R3C 0C4',4);
INSERT INTO ADDRESS (AddressID,SuiteNumber,Street,City,Province,PostalCode,StudentID) VALUES (10,'11','3453 Brand Road','Saskatoon','SK','S7K 1W8',5);

INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (1,'CST1000','Basic Programming');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (2,'CST2000','Machine Learning Algorithms');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (3,'CST3000','Applied AI for Business');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (4,'ENG1000','Applied Calculus');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (5,'ENG2000','Software and Hardware Design');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (6,'ENG3000','Automation and Robotics');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (7,'MAT1000','Calculus');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (8,'MAT2000','Applied Statistics');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (9,'MAT3000','Theoretical Physics');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (10,'HUM1000','Modern and Classical Philosophies');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (11,'HUM2000','Ethics and Critical Thinking');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (12,'HUM3000','Ethics in Social Media');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (13,'BUS1000','Introduction to Business');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (14,'BUS2000','Business Administration');
INSERT INTO COURSE (CourseID,CourseName,Description) VALUES (15,'BUS3000','Brick-to-Click Transformations and Transitions');

INSERT INTO DEPARTMENT (DepartmentID,DepartmentName,Description) VALUES (1,'Computer Science',null);
INSERT INTO DEPARTMENT (DepartmentID,DepartmentName,Description) VALUES (2,'Engineering',null);
INSERT INTO DEPARTMENT (DepartmentID,DepartmentName,Description) VALUES (3,'Mathematics',null);
INSERT INTO DEPARTMENT (DepartmentID,DepartmentName,Description) VALUES (4,'Humanities',null);
INSERT INTO DEPARTMENT (DepartmentID,DepartmentName,Description) VALUES (5,'Business',null);

INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (1,100,null,1,1,1);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (2,100,null,2,2,1);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (3,90,null,3,3,1);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (4,90,null,4,4,1);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (5,80,null,5,5,1);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (6,75,null,6,1,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (7,70,null,7,2,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (8,70,null,8,3,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (9,60,null,9,4,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (10,60,null,10,5,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (11,50,null,11,1,2);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (12,45,null,12,2,3);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (13,40,null,13,3,3);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (14,30,null,14,4,3);
INSERT INTO GRADE (GradeID,PercentGrade,LetterGrade,SectionID,StudentID,ProfessorID) VALUES (15,25,null,15,5,3);

INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('A+',90,100);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('A ',85,89.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('A-',80,84.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('B+',77,79.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('B ',73,76.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('B-',70,72.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('C+',67,69.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('C ',63,66.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('C-',60,62.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('D+',57,59.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('D ',53,56.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('D-',50,52.9);
INSERT INTO GRADE_LOOKUP (LetterGrade,MinPercent,MaxPercent) VALUES ('F ',0,49.9);

INSERT INTO PROFESSOR (ProfessorID,FirstName,LastName,Email) VALUES (1,'Arthur','Pendragon','apendragon@camelot.org');
INSERT INTO PROFESSOR (ProfessorID,FirstName,LastName,Email) VALUES (2,'Galahad','Lancelot','galahad@thegrail.com');
INSERT INTO PROFESSOR (ProfessorID,FirstName,LastName,Email) VALUES (3,'Ambrosius','Aurelianus','aurel@britanniae.gov');
INSERT INTO PROFESSOR (ProfessorID,FirstName,LastName,Email) VALUES (4,'Balan','Savage','balan.savage@postvulgatecycle.com');
INSERT INTO PROFESSOR (ProfessorID,FirstName,LastName,Email) VALUES (5,'Bruin','Black','black@roundtable32.com');

INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Computer Programming',null,1);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Artificial Intelligence',null,1);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Business Intelligence',null,1);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Civil Engineering',null,2);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Electrical Engineering',null,2);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Computer Engineering',null,2);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Statistics',null,3);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Applied Math',null,3);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Philosophy',null,4);
INSERT INTO PROGRAM (ProgramName,Description,DepartmentID) VALUES ('Finance',null,5);

INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (1,1);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (2,1);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (3,1);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (4,5);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (5,5);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (6,5);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (7,8);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (8,8);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (9,8);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (10,9);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (11,9);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (12,9);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (13,10);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (14,10);
INSERT INTO PROGRAM_COURSE_INT (CourseID,ProgramID) VALUES (15,10);

INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','452',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','453',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','454',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','455',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),1,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),2,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),2,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),3,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),3,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22W','450',null,to_date('22-01-01','RR-MM-DD'),to_date('22-04-30','RR-MM-DD'),3,1);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),4,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),5,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),5,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),6,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),6,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22W','450',null,to_date('22-01-01','RR-MM-DD'),to_date('22-04-30','RR-MM-DD'),6,2);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),7,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),8,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),8,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),9,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),9,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22W','450',null,to_date('22-01-01','RR-MM-DD'),to_date('22-04-30','RR-MM-DD'),9,3);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),10,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),11,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),11,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),12,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),12,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22W','450',null,to_date('22-01-01','RR-MM-DD'),to_date('22-04-30','RR-MM-DD'),12,4);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),13,null);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),14,null);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),14,null);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','450',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),15,null);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22F','451',null,to_date('22-09-01','RR-MM-DD'),to_date('22-12-31','RR-MM-DD'),15,null);
INSERT INTO SECTION (Semester,SectionNumber,SectionName,StartDate,EndDate,CourseID,ProfessorID) VALUES ('22W','450',null,to_date('22-01-01','RR-MM-DD'),to_date('22-04-30','RR-MM-DD'),15,null);

INSERT INTO SEMESTER (Semester,Description) VALUES ('20W',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('20S',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('20F',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('21W',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('21S',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('21F',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('22W',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('22S',null);
INSERT INTO SEMESTER (Semester,Description) VALUES ('22F',null);

INSERT INTO STUDENT (StudentID,StudentNumber,FirstName,LastName) VALUES (1,111111111,'Robin','Hood');
INSERT INTO STUDENT (StudentID,StudentNumber,FirstName,LastName) VALUES (2,333333333,'Guy','Gisbourne');
INSERT INTO STUDENT (StudentID,StudentNumber,FirstName,LastName) VALUES (3,555555555,'Will','Scarlet');
INSERT INTO STUDENT (StudentID,StudentNumber,FirstName,LastName) VALUES (4,777777777,'John','Little');
INSERT INTO STUDENT (StudentID,StudentNumber,FirstName,LastName) VALUES (5,999999999,'Gilbert','Whitehand');


-- Add primary key constraints ----------------------------------------------------------

ALTER TABLE ADDRESS ADD CONSTRAINT AddressPK PRIMARY KEY (AddressID);
ALTER TABLE COURSE ADD CONSTRAINT CoursePK PRIMARY KEY (CourseID);
ALTER TABLE DEPARTMENT ADD CONSTRAINT DepartmentPK PRIMARY KEY (DepartmentID);
ALTER TABLE GRADE ADD CONSTRAINT GradePK PRIMARY KEY (GradeID);
ALTER TABLE PROFESSOR ADD CONSTRAINT ProfessorPK PRIMARY KEY (ProfessorID);
ALTER TABLE PROGRAM ADD CONSTRAINT ProgramPK PRIMARY KEY (ProgramID);
ALTER TABLE PROGRAM_COURSE_INT ADD CONSTRAINT ProgramCoursePK PRIMARY KEY (ProgramCourseID);
ALTER TABLE SECTION ADD CONSTRAINT SectionPK PRIMARY KEY (SectionID);
ALTER TABLE SEMESTER ADD CONSTRAINT SemesterPK PRIMARY KEY (Semester);
ALTER TABLE STUDENT ADD CONSTRAINT StudentPK PRIMARY KEY (StudentID);


-- Add foreign key constraints ------------------------------------------

ALTER TABLE ADDRESS ADD CONSTRAINT AddressStudentFK FOREIGN KEY (StudentID) REFERENCES STUDENT (StudentID);
ALTER TABLE GRADE ADD CONSTRAINT GradeProfessorFK FOREIGN KEY (ProfessorID) REFERENCES PROFESSOR (ProfessorID);
ALTER TABLE GRADE ADD CONSTRAINT GradeSectionFK FOREIGN KEY (SectionID) REFERENCES SECTION (SectionID);
ALTER TABLE GRADE ADD CONSTRAINT GradeStudentFK FOREIGN KEY (StudentID) REFERENCES STUDENT (StudentID);
ALTER TABLE PROGRAM ADD CONSTRAINT ProgramDepartmentFK FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT (DepartmentID);
ALTER TABLE SECTION ADD CONSTRAINT SectionCourseFK FOREIGN KEY (CourseID) REFERENCES COURSE (CourseID);
ALTER TABLE SECTION ADD CONSTRAINT SectionProfessorFK FOREIGN KEY (ProfessorID) REFERENCES PROFESSOR (ProfessorID);
ALTER TABLE SECTION ADD CONSTRAINT SectionSemesterFK FOREIGN KEY (Semester) REFERENCES SEMESTER (Semester);

ALTER TABLE PROGRAM_COURSE_INT ADD CONSTRAINT CourseFK FOREIGN KEY (CourseID) REFERENCES COURSE (CourseID);
ALTER TABLE PROGRAM_COURSE_INT ADD CONSTRAINT ProgramFK FOREIGN KEY (ProgramID) REFERENCES PROGRAM (ProgramID);

UPDATE GRADE
SET LetterGrade = 'P' WHERE PercentGrade BETWEEN 50 AND 100;

UPDATE GRADE
SET LetterGrade = 'F' WHERE PercentGrade BETWEEN 0 AND 49.9;

COMMIT;

