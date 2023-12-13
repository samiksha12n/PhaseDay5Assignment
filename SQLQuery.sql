create database Day5AssignmentDb
use Day5AssignmentDb

create schema bank
create table bank.Customer
(CId nvarchar(50) primary key,
CName nvarchar(50) not null,
CEmail nvarchar(50) unique not null,
Contact nvarchar(50) unique not null,
CPwd as (right (CName,2))+CId+( left(Contact,2)) persisted)

create table bank.MailInfo
(CId nvarchar(50) primary key,
CName nvarchar(50) not null,
CEmail nvarchar(50) unique not null,
Contact nvarchar(50) unique not null,
CPwd as (right (CName,2))+CId+( left(Contact,2)) persisted,
MailTo as CEmail persisted,
MailDate date,
MaiMessage nvarchar(100))


create trigger afterInsTrg
on bank.Customer
after insert 
as
declare @id nvarchar(50)
declare @name nvarchar(50)
declare @mail nvarchar(50)
declare @contact nvarchar(50)
declare @pwd  nvarchar(50)
declare @mailto nvarchar(50)
declare @maildate date
declare @message nvarchar(100)
select @id=CId from inserted
select @name=CName from inserted
select @mail=CEmail from inserted
select @contact=Contact from inserted
insert into bank.MailInfo(CId,CName,CEmail,Contact,MailDate,MaiMessage)
values(@id,@name,@mail,@contact,GETDATE(),'Your net banking password is CPwd is valid up to 2 days only update it')
print 'Record inserted & values captured'

select * from bank.Customer
select * from bank.MailInfo

insert into bank.Customer(CId,CName,CEmail,Contact) values ('1','Sam','sam@yahoo.com','987654321')
insert into bank.Customer(CId,CName,CEmail,Contact) values ('2','Arsh','arsh@yahoo.com','89674312')
insert into bank.Customer(CId,CName,CEmail,Contact) values ('5','Deep','deep@yahoo.com','97458231')
