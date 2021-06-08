Notes:

File order execution as follows
1.createtablescript        creates department and employees tables
2.insertablescript         inserts data into department and employees table.
3.employeecrud             package for transaction and report generation.
4.testprocedurescripts     Contains script for testing i used, it can be used if needed for testing.
5.employeereport           Alternate: Report generation using SQLplus commands.Please Enter Department Value in SQL prompt.

One of the tasks given 
7. Write a report to show all Employees for a Department 
8. Write a report to show the total of Employee Salary for a Department 

We can generate this different methods based on design requirement in PLSQL or we can use Report Tools.
 1. using utl_file
 2. SQLPlus report commands
 3. DBMS_OUTPUT.

I have done in method 2 & 3.

I have uploaded as sql file. It should be run in @[FULLPATH]/Filename.sql in SQLPLUS command prompt or in SQL Developer Tool.
In Windows, connect to SQLPLUS prompt '<Loaction of Sqlplus.exe>\sqlplus.exe' <Username/Password@OrcaleInstancename>  @<File Location>\<FileName>.sql
In Linux, Connect SQLPLUS (sqlplus / as sysdba ) and run  @<File Location>\<FileName>.sql

In mac OS, I have not worked,but i learnt from Google, if ORACLE is installed in mac OS, we can connect to SQLPLUS as below 

     SQLPlus

       $ sqlplus username/password@database

         and run the sql file.
