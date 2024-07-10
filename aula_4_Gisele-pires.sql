-- Desafio Operadores de Comparação
-- 1. Na tabela employees, retorne apenas funcionarios do departamento 101;
select * from employees
where department_id = '101'


--2. Na tabela employees, retorne os funcionários cujo ultimo nome seja Johnson;
select * from employees
where last_name = 'Johnson'


--3. Na tabela salaries, retorne os registros cujo salario seja maior que 85000;
select * from salaries --limit 1
where amount > 85000
order by amount desc


--4. Na tabela salaries, retorne os registros cujo salário seja menor que 90000;

select * from salaries
where amount < 90000
order by amount desc

--5. Na tabela salaries, retorne os registros cujo salário seja seja maior ou igual a 92000;

select * from salaries
where amount >= 92000
order by amount desc


--6. Na tabela salaries, retorne os registros cujo salário seja seja menor ou igual a 95000;

select * from salaries
where amount <= 95000
order by amount desc , salary_id , employee_id


--7. Na tabela salaries, retorne os registros cujo salário seja diferente de 92000;

select * from salaries
where amount != 92000
order by amount

- outras formas: 
--select * from salaries
--where amount <> 92000
--order by amount

--select * from salaries
--where amount not in ('92000') 92000
--order by amount

/*
Demonstração Operadores Aritmeticos!
Em qualquer tabela, execute as querys de calculo aritmético, conforme exemplo.
*/

-- Soma
select 7 + 5 "Soma";

select 101 + 14 ;

-- Subtrai
select 7 - 5 "Subtrai";

select 10 - 2 ;

-- Multiplica
select  7 * 5 "Multiplica";

select 1256 * 0 ; 

-- Divide
select 7 / 5 "Divide";

select 1248 / 2 ;

-- Modulo
select 7 % 5 as "Obtem o resto da divisão";

select 15 % 5 ; 

select (12 * 6) - (48/5) * (598 * 3) - 10%

-- Desafio Operadores Lógicos
--1. Na tabela employees, retorne os registros cujo genero seja masculino e cuja função seja UX Designer;

select * from employees
where gender = 'Male'
and position = 'UX Designer'

--outra forma:
--select * from employees
--where gender = 'Male'
--and position like 'UX %'

--2. Na tabela employees, retone os registros cujo departamento sejam 104 e 102 e que as pessoas desse departamento estenam nos cargos de Data Analist e Product Analyst;

select * from employees
where department_id = '102'
or department_id = '104'
and position = 'Data Analyst'
or position = 'Product Analyst'

-- outra forma:
--select * from employees
--where (department_id = '102' or department_id = '104')
--and (position = 'Data Analist' or position = 'Product Analyst');

--select * from employees
--where department_id in ('102', '104')
--and position in  ('Data Analyst', 'Product Analyst') ; 


--3. Na tabela employees, retorne os registros cuja data de nascimento seja entre os anos 1985 e 1990.
select * from employees
where extract(year from date_of_birth) between 1985 and 1990; --esse trecho diz para extrair o ano da tabela de nascimento e o between determina o intervalo

--4. Na tabela employees, retorne os registros cujo departamento NÃO seja o 104;

select *
from employees
where department_id not in (104) ;

--ou 
--select * from employees
--where department_id <> 104

--ou 
--select * from employees where department_id != 104 
--order by department_id;

--ou
--select * from employees
--where department_id != '104'


--5. Na tabela employees, retorne os registros cujo endereço de email contenha as letras ar em qualquer posição.

select * from employees
where email like ' %ar% ' ; 

-- Parte improvisada da aula

--Conta quantidade de linhas retornadas em uma query
select count(*) "Total de Funcionarios";
from employees;

select count(*) as afastamentos_por_funcionarios --apelido pode ser feito com as ou com " "
from leaves;

--Aplicando operadores aritméticos em conjunto com função de contagem (count)
select count(*) * 3
from department;

--Usando SUM para obter o somatório de um campo
select sum(amount)
from salaries

select e.employee_id
        concat(first_name, ' ', last_name),
        email,
        gender,
        min(amount)
from employees e 
inner join salaries s on s.employee_id = e.employee_id
group by e.employee.id , e.first_name , e.last_name , email , gender
order by e.employee_id