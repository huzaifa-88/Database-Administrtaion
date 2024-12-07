SET LINESIZE 200
COLUMN departmentname FORMAT A20
COLUMN position FORMAT A20
COLUMN skillname FORMAT A20

update ZZZ_DIRECTORY 
SET departmentname = Upper(DepartmentName), position = INITCAP(position), skillname = LOWER(skillname);

SELECT DepartmentName, Position, SkillName
FROM ZZZ_DIRECTORY WHERE ROWNUM <= 30;
