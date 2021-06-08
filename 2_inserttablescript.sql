begin
insert into Departments values(1,'Management','London');
insert into Departments values(2,'Engineering','Cardiff');
insert into Departments values(3 ,'Research' || ' & ' ||'Development', 'Edinburgh');
insert into Departments values(4 ,'Sales', 'Belfast');

insert into Employees values(90001,'John Smith','CEO',null,to_date('01/01/95','dd/mm/yy'),100000,1);
insert into Employees values(90002,'Jimmy Willis','Manager',90001,to_date('23/09/03','dd/mm/yy'),52500,4);
insert into Employees values(90003,'Roxy Jones','Salesperson',null,to_date('11/02/17','dd/mm/yy'),35000,4);
insert into Employees values(90004,'Selwyn Field','Salesperson',null,to_date('20/05/15','dd/mm/yy'),32000,4);
insert into Employees values(90005,'David Hallett','Engineer',90006,to_date('17/04/18','dd/mm/yy'),40000,2);
insert into Employees values(90006,'Sarah Phelps','Manager',90001,to_date('21/03/15','dd/mm/yy'),45000,2);
insert into Employees values(90007,'Louise Harper','Engineer',90006,to_date('01/01/13','dd/mm/yy'),47000,2);
insert into Employees values(90008,'Tina Hart','Engineer',90009,to_date('28/07/14','dd/mm/yy'),45000,3);
insert into Employees values(90009,'Gus Jones','Manager',90001,to_date('15/05/18','dd/mm/yy'),50000,3);
insert into Employees values(90010,'Mildred Hall','Secretary',90001,to_date('12/10/96','dd/mm/yy'),35000,1);
commit;
end;
/
