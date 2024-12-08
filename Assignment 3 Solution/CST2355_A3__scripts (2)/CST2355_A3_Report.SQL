-- ROLLUP ---------------------------------------------------------------------------------------
SET LINESIZE 1000

SELECT
    DepartmentName                    AS DepartmentName,
    COUNT(DISTINCT PROGRAM.ProgramID) AS ProgramCount
FROM DEPARTMENT
INNER JOIN PROGRAM            ON  DEPARTMENT.DepartmentID = PROGRAM.DepartmentID
GROUP BY ROLLUP(DEPARTMENT.DepartmentName);

SET LINESIZE 80;


-- PIVOT ----------------------------------------------------------------------------------------
SET LINESIZE 1000;
SET PAGESIZE 45;

SELECT * FROM
        (
            SELECT DepartmentName, ProgramName, ProgramID
            FROM DEPARTMENT
            INNER JOIN PROGRAM ON PROGRAM.DepartmentID = DEPARTMENT.DepartmentID
        )
PIVOT
    (
        COUNT(DISTINCT ProgramID)
        FOR DepartmentName
        IN ('Computer Science' AS  "Computer Science",
            'Engineering'      AS  "Engineering",
            'Mathematics'      AS  "Mathematics")
    );


-- UNPIVOT ----------------------------------------------------------------------------------------
SET LINESIZE 1000;
SET PAGESIZE 45;

SELECT DepartmentName, ProgramCount FROM ZZZ_PIVOT
UNPIVOT
    (
        ProgramCount
        FOR DepartmentName
        IN ("Computer Science",
            "Engineering",
            "Mathematics")
    )
WHERE ProgramCount > 0;
