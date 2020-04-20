create database IB170030
use IB170030

create table Otkupljivaci(
OtkupljivacID int constraint PK_Otkupljivac primary key,
Ime nvarchar(50) not null,
Prezime nvarchar(50) not null,
DatumRodjenja date not null default getdate(),
JMBG nvarchar(13) not null,
Spol nvarchar(1) not null,
Grad nvarchar(50) not null,
Adresa nvarchar(100) not null,
Email nvarchar(100) not null constraint UQ_Mail unique,
Aktivan bit not null default 1
)
create table Proizvodi(
ProizvodID int constraint PK_Proizvod primary key,
Naziv nvarchar(50) not null,
Sorta nvarchar(50) not null,
OtkupnaCijena decimal not null,
Opis text
)

create table OtkupProizvoda(
OtkupljivacID int constraint FK_Otkupljivac foreign key(OtkupljivacID) references Otkupljivaci(OtkupljivacID),
ProizvodID int constraint FK_Proizvod foreign key (ProizvodID) references Proizvodi(ProizvodID),
constraint PK_Otkup primary key(OtkupljivacID,ProizvodID),
Datum date not null default getdate(),
Kolicina decimal not null,
BrojGajbica int not null
)

insert into Otkupljivaci
select  E.EmployeeID,E.FirstName,E.LastName,E.BirthDate, reverse(replace(convert(nvarchar,E.BirthDate,101),'/',''))+right(E.HomePhone,4) as 'jmbg',
replace(replace(replace(REPLACE(replace(E.TitleOfCourtesy,'Mrs','F'),'Ms','F'),'Mr','M'),'Dr','M'),'.','') as 'Spol',
E.City,REPLACE(E.Address,' ','_') as 'Adresa',E.FirstName+'_'+E.LastName+'@edu.fit.ba' as 'Email',1
from NORTHWND.dbo.Employees as E



use NORTHWND
select *
from Employees