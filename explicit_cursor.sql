set serveroutput on
declare
  cursor empcur is
    select employee_id, trunc(months_between(sysdate,hire_date) / 12) exp
    from employees;
  v_increment number(2);
begin
    for emprec in empcur
    loop
        -- find out increment based on experience (exp)
        v_increment :=  case
           when emprec.exp > 10 then 20
           when emprec.exp > 5  then 15
           else 10
        end;

        update employees set salary = salary + (salary * v_increment / 100)
        where employee_id = emprec.employee_id;


        dbms_output.put_line(emprec.employee_id || ' salary was incremented by ' || v_increment || '%');

   end loop;
end;

