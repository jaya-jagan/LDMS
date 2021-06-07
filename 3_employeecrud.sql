CREATE OR REPLACE package EmployeeCRUD is
Procedure InsertEmployee(p_empdata  employees%rowtype);
procedure UpdateEmployeeSal(p_empid employees.employee_id%type,p_salincr char,p_percentage number default 10);
procedure TransferEmployee(p_empid employees.employee_id%type,p_deptid employees.department_id%type);
Function  GetEmployeeSal(p_empid employees.employee_id%type) return employees.salary%type;
procedure RepDeptEmployee(p_deptid employees.department_id%TYPE,p_reccnt number );
procedure RepDeptSal(p_deptid employees.department_id%TYPE);
end EmployeeCRUD;
/


CREATE OR REPLACE package body EmployeeCRUD is
   v_code NUMBER;
   v_errm VARCHAR2(100);
   
-- Procedure to insert employee into employees table. When assigning values for data_hired use dd-mon-rrrr format. Other format use to_date function.  
Procedure InsertEmployee(p_empdata  Employees%rowtype)is

begin
           insert into Employees values p_empdata;
           dbms_output.put_line(sql%rowcount || ' record inserted');
           commit;
        exception
            when others then
             v_code := SQLCODE;  
             v_errm := SUBSTR(SQLERRM, 1 , 100);
             DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ':');
             DBMS_OUTPUT.PUT_LINE(v_errm);
end InsertEmployee;

--Procedure to update salary of the given employee id . Salary would be increased or decreased based on input 'Increment' or 'Decrement'.

procedure UpdateEmployeeSal(p_empid employees.employee_id%type,p_salincr char,p_percentage number default 10) is
begin
    if upper(p_salincr) = 'I' then
        update employees set salary = salary +(salary * (p_percentage/100))
        where employee_id =p_empid;
         dbms_output.put_line ('Salary incremented '|| p_empid);
        
    elsif upper(p_salincr) = 'D' then 
        update employees set salary = salary - (salary * (p_percentage/100))
        where employee_id =p_empid;
         dbms_output.put_line ('Salary Decremented '|| p_empid);
    else
        dbms_output.put_line ('Increment value not given');
    end if;
commit;
exception
  When Others then
             v_code := SQLCODE;
             v_errm := SUBSTR(SQLERRM, 1 , 64);
             DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);

end UpdateEmployeeSal;

-- procedure to transfer employee to another department based on the input given that is employeeid and deptid to be transferred.

procedure TransferEmployee(p_empid employees.employee_id%type,p_deptid employees.department_id%type) is
  
begin 
    update employees set department_id = p_deptid
    where employee_id = p_empid;
     dbms_output.put_line ('Department updated'|| sql%rowcount);
    commit;
    
    EXCEPTION
        When Others then
             v_code := SQLCODE;
             v_errm := SUBSTR(SQLERRM, 1 , 64);
             DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);

end TransferEmployee;


--- Function to get salary for the given employeeid.
Function  GetEmployeeSal(p_empid employees.employee_id%type) return employees.salary%type is
    v_sal employees.salary%type;
begin
    select Salary
    into v_sal
    from employees
    where employee_id = p_empid;
    
    return v_sal;
end GetEmployeeSal;

-- Procedure to print header for the report
procedure printheader(p_deptid number) is
begin
         dbms_output.Put_line('Employees working in the Department: ' ||p_deptid);
         dbms_output.Put_line('------------------------------------------');
         dbms_output.Put_line( Rpad('Name of the Employee', 30));
         dbms_output.Put_line('------------------------------------------------------------------------------');
end printheader;

--Procedure to print footer for the report

procedure printfooter(p_noofemployee number,p_pagenum number) is
begin
        dbms_output.Put_line('');
        dbms_output.Put_line('The number of employees '
                         || p_noofemployee||'                            '|| LPAD('Page No: ' || p_pagenum,10)); 
        /*dbms_output.Put_line(LPAD('Page No: '
                         || p_pagenum,10)); */
        dbms_output.Put_line(''); 
         dbms_output.Put_line(''); 
          dbms_output.Put_line(''); 
end printfooter;

-- Procedure to print employee names for the given department id.

procedure RepDeptEmployee(p_deptid employees.department_id%TYPE,p_reccnt number) is
v_empname       employees.employee_name%type;
v_noofemployee  number;
v_totalrec      number;  -- total number of records
v_pagerec       number :=0;  -- Number of records per page
v_pagenum       number :=0;  -- Page number for the report
    cursor c_emp(p_deptid employees.department_id%TYPE,p_skiprec number,p_reccnt number) is
    select employee_name
    from   employees
    where  department_id = p_deptid
    order by employee_id
    offset p_skiprec rows fetch next p_reccnt row only;
begin
        --Get total number of rows from employees table
        select count(1)
        into  v_totalrec
        from   employees
        where  department_id = p_deptid;
     
     while (v_pagerec <= v_totalrec) 
      loop
                
        printheader(p_deptid);

        For e in c_emp(p_deptid,v_pagerec,p_reccnt)
        loop
               
          dbms_output.Put_line(rpad(e.employee_name, 30));
            v_noofemployee := c_emp%rowcount;
         
        end loop;
        v_pagenum := v_pagenum+1;
        
        printfooter(v_noofemployee,v_pagenum);
        v_pagerec := v_pagerec + p_reccnt;
     end loop;
  
  EXCEPTION
        When Others then 
             v_code := SQLCODE;
             v_errm := SUBSTR(SQLERRM, 1 , 64);
             DBMS_OUTPUT.PUT_LINE('Error code ' || v_code || ': ' || v_errm);
end RepDeptEmployee;

procedure RepDeptSal(p_deptid employees.department_id%TYPE) is
v_sum number;
cursor c_emp(p_deptid employees.department_id%TYPE) is
    select Salary
    from   employees
    where  department_id = p_deptid;
begin
        Select sum(salary) 
        into   v_sum
        from employees e
        where e.department_id = p_deptid
        group by department_id;
         
         dbms_output.Put_line( Rpad('Employee Salary', 30));
         dbms_output.Put_line('------------------------------------------------------------------------------');
          For e in c_emp(p_deptid)
          loop
               
          dbms_output.Put_line(rpad(e.salary, 30));
            
         
          end loop; 
 
         dbms_output.Put_line( Rpad('Total Salary', 30));
         dbms_output.Put_line('------------------------------------------------------------------------------');
         dbms_output.Put_line(rpad(v_sum, 30));
         dbms_output.Put_line('-----------Rnd of report------------------------------------------------------');

end RepDeptSal;

end EmployeeCRUD;
/
