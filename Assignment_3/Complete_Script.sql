-- Step 1:

-- Run CST2355_A3_DB.sql File for DB Creation

ALTER TABLE SECTION
RENAME COLUMN SectionNumber TO SectionNumber_old;
ALTER TABLE SECTION
ADD SectionNumber VARCHAR(10);
UPDATE SECTION
SET SectionNumber = TO_CHAR(SectionNumber_old);
COMMIT;
ALTER TABLE SECTION
DROP COLUMN SectionNumber_old;
DESC SECTION;

-- Step 2:
-- Create the Package Specification
CREATE OR REPLACE PACKAGE SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2);
END SectionMaintenance;
/

-- Create the Package Body
CREATE OR REPLACE PACKAGE BODY SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2) AS
    BEGIN
        NULL;
    END RenumberSectionNumber;
END SectionMaintenance;
/

-- Step 3:
-- Create or Update the Package Specification
CREATE OR REPLACE PACKAGE SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2);
END SectionMaintenance;
/

-- Create or Update the Package Body
CREATE OR REPLACE PACKAGE BODY SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2) IS
        -- Variable declaration
        NewSectionNumber INT; -- Integer variable for new section numbers
        
        -- Cursor declaration
        CURSOR SectionList IS
            SELECT SectionID
            FROM SECTION
            WHERE CourseID = IN_COURSE
            ORDER BY SectionNumber;
    BEGIN
        NULL;
    END RenumberSectionNumber;
END SectionMaintenance;
/

-- Step 4:
CREATE OR REPLACE PACKAGE SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2);
END SectionMaintenance;
/

CREATE OR REPLACE PACKAGE BODY SectionMaintenance AS
    PROCEDURE RenumberSectionNumber(IN_COURSE IN VARCHAR2) IS
        NewSectionNumber INT := 450;

        CURSOR SectionList IS
            SELECT SectionID
            FROM SECTION
            WHERE CourseID = IN_COURSE
            ORDER BY SectionNumber;
    BEGIN
        FOR SectionRecord IN SectionList LOOP
            -- Update the SectionNumber for the current SectionID
            UPDATE SECTION
            SET SectionNumber = NewSectionNumber
            WHERE SectionID = SectionRecord.SectionID;
            NewSectionNumber := NewSectionNumber + 50;
        END LOOP;
    END RenumberSectionNumber;
END SectionMaintenance;
/


-- Step 5:
CREATE OR REPLACE VIEW V_SECTION AS
SELECT *
FROM SECTION;

--Create an INSTEAD OF INSERT Trigger on the View
CREATE OR REPLACE TRIGGER SECTION_INSERT
INSTEAD OF INSERT ON V_SECTION
FOR EACH ROW
BEGIN
    NULL;
END;
/

-- Step 6:
CREATE OR REPLACE VIEW V_SECTION AS
SELECT SectionID, Semester, SectionName, Startdate, Enddate, CourseID, ProfessorID, SectionNumber
FROM SECTION;
CREATE OR REPLACE TRIGGER SECTION_INSERT
INSTEAD OF INSERT ON V_SECTION
FOR EACH ROW
BEGIN
    -- Check if ProfessorID is NOT NULL
    IF :NEW.ProfessorID IS NOT NULL THEN
        -- Insert into SECTION excluding SectionID
        INSERT INTO SECTION (Semester, SectionName, Startdate, Enddate, CourseID, ProfessorID, SectionNumber)
        VALUES (:NEW.Semester, :NEW.SectionName, :NEW.Startdate, :NEW.Enddate, :NEW.CourseID, :NEW.ProfessorID, :NEW.SectionNumber);
    ELSE
        -- Insert into SECTION excluding SectionID and ProfessorID
        INSERT INTO SECTION (Semester, SectionName, Startdate, Enddate, CourseID, SectionNumber)
        VALUES (:NEW.Semester, :NEW.SectionName, :NEW.Startdate, :NEW.enddate, :NEW.CourseID, :NEW.SectionNumber);
    END IF;
END SECTION_INSERT;
/


-- Step 7:
CREATE OR REPLACE VIEW V_SECTION AS
SELECT SectionID, Semester, SectionName, Startdate, Enddate, CourseID, ProfessorID, SectionNumber
FROM SECTION;
CREATE OR REPLACE TRIGGER SECTION_INSERT
INSTEAD OF INSERT ON V_SECTION
FOR EACH ROW
BEGIN
    IF :NEW.ProfessorID IS NOT NULL THEN
        -- Insert into PROFESSOR table for the new ProfessorID
        INSERT INTO PROFESSOR (ProfessorID)
        VALUES (:NEW.ProfessorID);

        -- Insert into SECTION excluding SectionID
        INSERT INTO SECTION (Semester, SectionName, Startdate, Enddate, CourseID, ProfessorID, SectionNumber)
        VALUES (:NEW.Semester, :NEW.SectionName, :NEW.Startdate, :NEW.enddate, :NEW.CourseID, :NEW.ProfessorID, :NEW.SectionNumber);
    ELSE
        -- Insert into SECTION excluding SectionID and ProfessorID
        INSERT INTO SECTION (Semester, SectionName, Startdate, Enddate, CourseID, SectionNumber)
        VALUES (:NEW.Semester, :NEW.SectionName, :NEW.Startdate, :NEW.Enddate, :NEW.CourseID, :NEW.SectionNumber);
    END IF;
END SECTION_INSERT;
/


-- Step 8:
-- CREATE VIEW Statement to include the new columns with INNER JOIN on COURSE, SECTION, and PROFESSOR
CREATE OR REPLACE VIEW StudentManagement AS
    SELECT
        STUDENT.StudentID,
        GRADE.GradeID,
        STUDENT.FirstName AS StudentFirstName,
        STUDENT.LastName AS StudentLastName,
        GRADE.PercentGrade,
        -- New columns to be added:
        SECTION.SectionID,
        SECTION.CourseID,          -- Added from SECTION table
        PROFESSOR.ProfessorID,     -- Added from PROFESSOR table
        SECTION.SectionName,       -- Added from SECTION table
        COURSE.CourseName,         -- Added from COURSE table
        PROFESSOR.FirstName AS ProfessorFirstName,  -- Added from PROFESSOR table
        PROFESSOR.LastName AS ProfessorLastName     -- Added from PROFESSOR table
    FROM STUDENT
    INNER JOIN GRADE ON GRADE.StudentID = STUDENT.StudentID
    -- Adding joins on COURSE, SECTION, and PROFESSOR
    INNER JOIN SECTION ON SECTION.SectionID = GRADE.SectionID  -- Join to get section data (using SectionID from GRADE)
    INNER JOIN COURSE ON COURSE.CourseID = SECTION.CourseID  -- Join to get course data
    INNER JOIN PROFESSOR ON PROFESSOR.ProfessorID = SECTION.ProfessorID;  -- Join to get professor info


-- CREATE TRIGGER Statement for INSTEAD OF UPDATE
CREATE OR REPLACE TRIGGER StudentManagement_UPDATE 
INSTEAD OF UPDATE ON StudentManagement FOR EACH ROW
BEGIN

    -- old non-null value <> new non-null value
    IF :OLD.StudentFirstName <> :NEW.StudentFirstName THEN
        UPDATE STUDENT SET FirstName = :NEW.StudentFirstName
        WHERE StudentID = :OLD.StudentID;
    END IF;

    -- old non-null value <> new non-null value
    IF :OLD.StudentLastName <> :NEW.StudentLastName THEN
        UPDATE STUDENT SET LastName = :NEW.StudentLastName
        WHERE StudentID = :OLD.StudentID;
    END IF;

    -- old non-null value <> new non-null value
    IF :OLD.PercentGrade <> :NEW.PercentGrade THEN
        UPDATE GRADE SET PercentGrade = :NEW.PercentGrade
        WHERE GradeID = :OLD.GradeID;
    END IF;

    -- old null/non-null value <> new null value
    IF :NEW.PercentGrade IS NULL THEN
        UPDATE GRADE SET PercentGrade = NULL
        WHERE GradeID = :OLD.GradeID;
    END IF;

    -- old null value <> new non-null value
    IF :OLD.PercentGrade IS NULL AND :NEW.PercentGrade IS NOT NULL THEN
        UPDATE GRADE SET PercentGrade = :NEW.PercentGrade
        WHERE GradeID = :OLD.GradeID;
    END IF;
END;
/
SET PAGESIZE 30;


-- Step 9:
CREATE OR REPLACE TRIGGER StudentManagement_UPDATE
INSTEAD OF UPDATE ON StudentManagement FOR EACH ROW
BEGIN
    IF :OLD.StudentFirstName <> :NEW.StudentFirstName THEN
        UPDATE STUDENT SET FirstName = :NEW.StudentFirstName
        WHERE StudentID = :OLD.StudentID;
    END IF;
    IF :OLD.StudentLastName <> :NEW.StudentLastName THEN
        UPDATE STUDENT SET LastName = :NEW.StudentLastName
        WHERE StudentID = :OLD.StudentID;
    END IF;
    IF :OLD.PercentGrade <> :NEW.PercentGrade THEN
        UPDATE GRADE SET PercentGrade = :NEW.PercentGrade
        WHERE GradeID = :OLD.GradeID;
    END IF;
    IF :NEW.PercentGrade IS NULL THEN
        UPDATE GRADE SET PercentGrade = NULL
        WHERE GradeID = :OLD.GradeID;
    END IF;
    IF :OLD.PercentGrade IS NULL AND :NEW.PercentGrade IS NOT NULL THEN
        UPDATE GRADE SET PercentGrade = :NEW.PercentGrade
        WHERE GradeID = :OLD.GradeID;
    END IF;
    -- New Condition: If both new ProfessorFirstName and ProfessorLastName are NULL
    IF :NEW.ProfessorFirstName IS NULL AND :NEW.ProfessorLastName IS NULL THEN
        -- Unassociate the professor from the section by setting ProfessorID to NULL
        UPDATE SECTION 
        SET ProfessorID = NULL
        WHERE SectionID = :OLD.SectionID;
    END IF;

END;
/


-- Step 10:
-- Create the function GradeLookup
CREATE OR REPLACE FUNCTION GradeLookup (IN_Percentage IN NUMBER) 
RETURN VARCHAR IS
    NewLetterGrade VARCHAR(3);

BEGIN

    -- Select the LetterGrade from the GRADE_LOOKUP table where IN_Percentage is between MinPercent and MaxPercent
    SELECT LetterGrade
    INTO NewLetterGrade
    FROM GRADE_LOOKUP
    WHERE IN_Percentage BETWEEN MinPercent AND MaxPercent;
    RETURN NewLetterGrade;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Invalid';
    WHEN OTHERS THEN
        RETURN 'Error';
END;
/

-- Step 11:
-- This trigger updates the LetterGrade based on PercentageGrade using the GradeLookup function.
CREATE OR REPLACE TRIGGER GRADE_UPDATE 
BEFORE INSERT OR UPDATE ON GRADE FOR EACH ROW
DECLARE
    varLetterGrade VARCHAR(3);
BEGIN
    -- Use the GradeLookup function to get the letter grade based on PercentageGrade
    varLetterGrade := GradeLookup(:NEW.PercentGrade);

    -- Assign the letter grade to the new row
    :NEW.LetterGrade := varLetterGrade;
END;
/


-- Step 12:
SET LINESIZE 200;
SELECT 
    D.DepartmentName, 
    P.ProgramName, 
    COUNT(DISTINCT PC.CourseID) AS CourseCount
FROM 
    Program P
JOIN 
    Program_Course_INT PC ON P.ProgramID = PC.ProgramID
JOIN 
    Department D ON P.DepartmentID = D.DepartmentID
GROUP BY 
    ROLLUP(D.DepartmentName, P.ProgramName);
SET LINESIZE 80;


-- Step 13:
SET LINESIZE 200;
SELECT 
    D.DepartmentName, 
    P.ProgramName, 
    COUNT(DISTINCT PC.CourseID) AS CourseCount
FROM 
    Program P
JOIN 
    Program_Course_INT PC ON P.ProgramID = PC.ProgramID
JOIN 
    Department D ON P.DepartmentID = D.DepartmentID
GROUP BY 
    CUBE(D.DepartmentName, P.ProgramName);
SET LINESIZE 80;


-- Step 14:
SET LINESIZE 200;
SET PAGESIZE 45;

SELECT * 
FROM (
    SELECT 
        C.CourseName, 
        D.DepartmentName 
    FROM 
        Course C
    INNER JOIN Program_Course_INT PCI ON C.CourseID = PCI.CourseID
    INNER JOIN Program P ON PCI.ProgramID = P.ProgramID
    INNER JOIN Department D ON P.DepartmentID = D.DepartmentID
)
PIVOT (
    COUNT(*)
    FOR DepartmentName IN (
        'Mathematics' AS "Applied Math",
        'Engineering' AS "Electrical Engineering",
        'Business' AS "Finance"
    )
)
ORDER BY CourseName;

-- Step 15:
-- First Create the ZZZ_PIVOT table using the PIVOT query from step 14
CREATE TABLE ZZZ_PIVOT AS 
SELECT * 
FROM (
    SELECT 
        C.CourseName, 
        P.ProgramName, 
        D.DepartmentName 
    FROM 
        Course C
    INNER JOIN Program_Course_INT PCI ON C.CourseID = PCI.CourseID
    INNER JOIN Program P ON PCI.ProgramID = P.ProgramID
    INNER JOIN Department D ON P.DepartmentID = D.DepartmentID
)
PIVOT (
    COUNT(*) -- Counting occurrences for pivot
    FOR DepartmentName IN (
        'Mathematics' AS "Applied Math",
        'Engineering' AS "Electrical Engineering",
        'Business' AS "Finance"
    )
);
-- 2nd Run this script
SELECT 
    Program AS ProgramName,
    CourseName,
    CourseCount
FROM 
    ZZZ_PIVOT
UNPIVOT (
    CourseCount FOR Program IN (
        "Applied Math" AS 'Applied Math',
        "Electrical Engineering" AS 'Electrical Engineering',
        "Finance" AS 'Finance'
    )
)
WHERE CourseCount > 0
ORDER BY ProgramName, CourseName;
















