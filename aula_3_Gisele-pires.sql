- Cria a base
create database teste
go

-- Usar a base teste
use teste;
go

-- Criar base teste1
create database teste1
go

-- Mudar para a base teste1
use teste1;
go

-- Criar a tabela_1 na base teste1
create table tabela_1 (
id INT PRIMARY KEY,
nome varchar(50)
);

--Testes de alterações nas estruturas das tabelas
alter table tabela_1
alter column id uniqueidentifier;

alter table tabela_1
alter column nome char(50);

--Select basico para testar
select * from dbo.tabela_1


-- Excluir objetos da tabela
drop table tabela_1


--Lembrar de mudar para a base master antes de usar o drop database
use master;
go

-- Deletar banco de de dados
drop database teste1

-- Mudar para a base teste1
use teste1;
go

-- Inserir dados na tabela
insert into tabela_1 ( id , nome)
values ('1', 'Thayse'),
('2', 'João'),
('3', 'Jessica'),
('4', 'Maria'),
('5', 'caio'),

-- Exemplo de select tudo
-- Like + %algumacoisa% trás dado específico
select * from tabela_1 t
where t.nome = 'Thayse'


select nome "Meu Nome"
from tabela_1
where nome = 'Thayse'

-- Atualizar
update tabela_1
set nome = 'João'
where ind = '1'

-- Atualizar
update tabela_1
set nome = 'SQL dotNet''
where id = '5'

-- Deletar
delete from tabela_1
where id = '5'

delete from tabela_1
where nome like