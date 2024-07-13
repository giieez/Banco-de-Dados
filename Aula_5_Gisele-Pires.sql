-- Usar a base curso
use curso;
go

-- Apresentação das tabelas de uma banco de dados basico para demonstração
select * from dbo.regiao;
select * from dbo.uf;
select * from dbo.senso;


--<<<<< UNION >>>>>--

/*

<<< Sintaxe Union >>>

select * from dbo.uf
union
select * from dbo.senso

*/

-- Desafio Union
--1. Usando a base curso, aplique o union para concatenar em uma coluna os dados a seguir:
--tabelas: dbo.senso e dbo.região
--colunas: nome_mun e cod_uf

select nome_mun from dbo.senso union select cod_uf from dbo.regiao;
select nome_mun from dbo.senso union all select cod_uf from dbo.regiao;


--2. Ainda na base curso, aplique o union para concatenar em uma coluna os dados a seguir:
--tabelas: dbo.uf e dbo.região
--colunas: area_km2 e estado - atanção aos data types diferentes para os campos pedidos ;) 

select area_km2 from dbo.uf union select estado from dbo.regiao; --sem converter 
select cast (area_km2 as nvarchar(50)) from dbo.uf union select estado from dbo.regiao; --convertendo
select cast (area_km2 as nvarchar(50)), estado from dbo.uf union select regiao, cod_uf from dbo.regiao;
select cast (area_km2 as nvarchar(50)), estado from dbo.uf union all select regiao, cod_uf from dbo.regiao;

--<<<<< SUBQUERYS >>>>>--

/* Demonstração de subquerys (subconsultas)
Uma subquery (ou subconsulta) é uma consulta SQL aninhada dentro de outra consulta, como em 
uma cláusula SELECT, INSERT, UPDATE, ou DELETE. Ela é usada para retornar dados que serão 
utilizados pela consulta externa. */

-- Select
select * from dbo.regiao r
where r.cod_uf in (select cod_uf from dbo.uf where area_km2 > 50000);

-- Insert 
-- query pra verificar existencia de um nome (select * from dbo.senso where nome_mun like '%sapo%' order by cod_mun desc;)
insert into dbo.senso (uf , cod_uf , cod_mun , nome_mun , populacao)
values
('MG' , (select cod_uf from dbo.uf where estado = 'Minas Gerais') , '99000' , 'Sapo Roncador' , '15000');

-- Incluindo propositalmente um municipio com nome duplicado, porém com o código do municipio diferente
insert into dbo.senso (uf , cod_uf , cod_mun , nome_mun , populacao)
values
('MG' , (select cod_uf from dbo.uf where estado = 'Minas Gerais') , '99001' , 'Sapo Roncador' , '30000');

-- Update
-- Atualizando o campo cod_uf com base em uma subconsulta
-- Atenção nesse exemplo ao cuidado de mudar o campo uf pois o input foi manual
update dbo.senso
set uf = 'RO' , cod_uf = (select cod_uf from dbo.uf where estado = 'Roraima') 
where nome_mun = 'Sapo Roncador'
and cod_mun = '99000';

-- Delete
-- Exclui o registro da tabela
delete from dbo.senso
where nome_mun = 'Sapo Roncador'
and cod_uf = (select cod_uf from dbo.uf where estado = 'Roraima');


--<<<<< JOINS >>>>>--

/*Um join em SQL é uma operação que combina linhas de duas ou mais tabelas com base em uma 
condição relacionada, permitindo consultas que integrem dados de tabelas diferentes. Teoria dos conjuntos*/


/*

<<< Sintaxe Inner Join >>>

select * from dbo.uf u inner join dbo.senso s on u.cod_uf = s.cod_uf

*/

-- <<<<< DESAFIO INNER JOIN >>>>> ---
--Usaremos a base curso para as atividades do desafio.

--1. Listar Nomes dos Estados e Regiões
--Objetivo: Obter os nomes dos estados e suas respectivas regiões.

select r.estado, r.regiao from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf inner join dbo.regiao r on u.cod_uf = r.cod_uf;
select distinct (r.estado), r.regiao from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf inner join dbo.regiao r on u.cod_uf = r.cod_uf;
select r.regiao, u.estado from dbo.regiao r inner join dbo.uf u on r.cod_uf = u.cod_uf;


--2. Listar Municípios e Estados Correspondentes
--Objetivo: Obter os nomes dos municípios e os estados aos quais pertencem.

select s.nome_mun, u.estado from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf;


--3. Listar Municípios, Estados e Regiões
--Objetivo: Obter uma lista de municípios, seus estados e as regiões correspondentes.

select s.nome_mun, u.estado, r.regiao from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf inner join dbo.regiao r on u.cod_uf = r.cod_uf;

--4. Listar População dos Municípios por Estado
--Objetivo: Obter a população total dos municípios por estado.

select u.estado, sum (s.populacao) "total populacao" from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf group by u.estado;


--5. Municípios de uma Região Específica
--Objetivo: Obter uma lista de municípios pertencentes a uma região específica.

select s.nome_mun as "Município", r.estado as "Estado" from dbo.senso s inner join dbo.regiao r on s.cod_uf = r.cod_uf where r.regiao = 'Centro-Oeste';


--6. Comparar População de Municípios de Dois Estados;
--Objetivo: Comparar a população de municípios entre dois estados específicos.

select s.nome_mun, u.estado, s.populacao from dbo.senso s inner join dbo.uf_u on s.cod_uf = u.cod_uf where u.estado in ('São Paulo', 'Bahia') order by u.estado, s.populacao desc; 
select u.estado as "Estado", sum(s.populacao) as "População Total" from dbo.senso s inner join dbo.uf u on s.cod_uf = u.cod_uf where (u.estado = 'Bahia') or (u.estado = 'Acre') group by u.estado;
