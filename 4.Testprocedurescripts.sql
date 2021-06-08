SET SERVEROUTPUT ON
declare
v_empdata employees%rowtype;
begin
v_empdata.employee_id := 90012;
v_empdata.employee_name := 'Sai Durga';
v_empdata.job_title := 'SalesPerson';
v_empdata.manager_id := 90004;
v_empdata.date_hired := '24-Jul-2003';--to_date('12/07/09','dd/mm/yyyy');
v_empdata.salary := 10000;
v_empdata.department_id := 4;

employeecrud.insertemployee(v_empdata);
end;
/


select employeecrud.getemployeesal(90004) from dual;
/

begin
employeecrud.UpdateEmployeeSal(90004,'D');
end;
/

begin
employeecrud.repdeptemployee(4,3);
end;
/

begin
employeecrud.RepDeptSal(4);
end;
/

begin
employeecrud.transferemployee(90012,2);
end;
/
