CREATE OR REPLACE TRIGGER GRADE_UPDATE 
BEFORE INSERT OR UPDATE ON GRADE FOR EACH ROW
DECLARE
    varLetterGrade VARCHAR(2);
BEGIN
    IF :NEW.PercentGrade BETWEEN 50 AND 100 THEN
        varLetterGrade := 'P';
    END IF;

    IF :NEW.PercentGrade BETWEEN 0 AND 49.9 THEN
        varLetterGrade := 'F';
    END IF;

    :NEW.LetterGrade := varLetterGrade;
END;