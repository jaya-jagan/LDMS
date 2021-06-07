spool ..\EmployeeReport.txt
set echo off
set feedback off
SET TERMOUT OFF
SET Verify off
define deptid
set pagesize 50
set newpage 0
set linesize 61
TTITLE CENTER 'Summary Report for' -
> 'the Month of May'
TTITLE CENTER 'Report 0f Employees working' SKIP 1 -
 CENTER 'in the Department' SKIP 2
BTITLE CENTER 'END of Report' SKIP 2 -
RIGHT 'PAGE:' FORMAT 999 SQL.PNO 

column employee_name heading "Employee Name" FORMAT A20 WORD_WRAPPED 
select Employee_name from employees 
where department_id = '&deptid';
spool off;