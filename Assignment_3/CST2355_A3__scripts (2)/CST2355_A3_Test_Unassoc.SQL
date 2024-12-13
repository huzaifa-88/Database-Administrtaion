SET TERMOUT OFF

SET LINESIZE 200
SET PAGESIZE 60

UPDATE SECTION SET ProfessorID = 1 WHERE SectionName LIKE '%CST1000%';

SET TERMOUT ON
SELECT SectionID, SectionName, ProfessorID FROM SECTION WHERE SectionName LIKE '%CST1000%' AND ROWNUM <= 5;

SET TERMOUT OFF
UPDATE StudentManagement SET ProfessorFirstName = NULL,
                             ProfessorLastName  = NULL,
                             SectionID          = NULL,
                             ProfessorID        = NULL
WHERE SectionID IN (1, 3, 5);

SET TERMOUT ON
SELECT SectionID, SectionName, ProfessorID FROM SECTION WHERE SectionName LIKE '%CST1000%' AND ROWNUM <= 5;

SET LINESIZE 80