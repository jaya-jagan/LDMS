drop table employees;

drop table departments;


create table Departments(department_id    NUMBER(5)  Constraint PK_DEPTID PRIMARY KEY , Department_name Varchar2(50) Not NULL,Location Varchar2(50) NOT NULL);

create table Employees(Employee_Id Number(10) Primary Key,Employee_Name Varchar2(50) NOT NULL,
Job_Title Varchar2(50) NOT NULL,Manager_Id Number(10) ,
Date_Hired Date NOT NULL,Salary Number(10) NOT NULL,
Department_Id Number(5) NOT NULL, Constraint FK_DEPARTMENTID FOREIGN KEY(Department_Id) references departments(department_id)
);
/

