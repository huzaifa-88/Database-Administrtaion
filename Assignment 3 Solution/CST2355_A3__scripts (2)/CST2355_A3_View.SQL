CREATE OR REPLACE VIEW StudentManagement AS
    SELECT
        STUDENT.StudentID,
        GradeID,
        FirstName AS StudentFirstName,
        LastName AS StudentLastName,
        PercentGrade
    FROM STUDENT
    INNER JOIN GRADE ON GRADE.StudentID = STUDENT.StudentID;


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