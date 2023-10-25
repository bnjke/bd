CREATE TABLE [Shopper] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [login] nvarchar(255),
  [password] nvarchar(255),
  [first_name] nvarchar(255),
  [date_of_birth] date,
  [amount_of_purchases] money,
  [discount_percentage] tinyint,
  [amount_until_next_discount] money
)
GO

CREATE TABLE [System_data] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [shopper] int,
  [information] nvarchar(255),
  [registration] date
)
GO

CREATE TABLE [Shops] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [address] nvarchar(255),
  [employee_count] int,
  [open] time,
  [close] time
)
GO

CREATE TABLE [Employee] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [first_name] nvarchar(255),
  [middle_name] nvarchar(255),
  [last_name] nvarchar(255),
  [date_of_birth] date,
  [shopsID] int,
  [positionID] int
)
GO

CREATE TABLE [Position] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [name] nvarchar(255),
  [salary] money,
  [cash_bonus] money,
  [start_time] time,
  [finish_time] time
)
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([shopsID]) REFERENCES [Shops] ([ID])
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([positionID]) REFERENCES [Position] ([ID])
GO

---1---
create trigger System_data_shoppers_insert
on Shopper
after insert
as
insert into System_data (shopper, information, registration)
select ID, 'Зарегестрирован пользователь ' + first_name + '. Логин пользователя: ' + login, getdate()
from inserted

INSERT INTO [Shopper]
       VALUES
	       ('Ocup', 'Yrizy738Sef', 'Василиса', '08.03.1999', 10000, 10, 1000),
				   ('Ocup', 'Aniku79^Uvudy2', 'Милана', '11.09.1984', 13000, 13, 1000),
				   ('Rokice', 'Rukib382Qygur', 'Вероника', '29.07.1991', 14500, 14, 500),
				   ('Boxiv', 'Axara83{Py', 'Ярослава', '31.03.1980', 25050, 25, 950),
				   ('Mipup', 'Nupig222', 'Полина', '08.01.1994', 13770, 13, 230),
				   ('Red', 'Nykab573Ef', 'Федор', '02.07.1983', 17800, 17, 200),
				   ('Kit', 'Kuduq89{Uziq', 'Александр', '03.10.1985', 19300, 19, 700),
				   ('Lelydy', 'Pygik23_Igaku76', 'Егор', '24.04.1987', 400, 0, 600),
				   ('Ikita', 'Enuny539Regy', 'Алексей', '20.10.1988', 1300, 1, 700),
				   ('Emogi', 'Wiret93_N', 'Даниил', '19.06.1998', 16390, 16, 610);

select * from System_data

drop trigger System_data_shoppers_insert


create trigger System_data_shoppers_delete
on Shopper
after delete
as
insert into System_data (shopper, information, registration)
select ID, 'Пользователь ' + first_name + ', логин: ' + login + ' удалил свою учётную запись', getdate()
from deleted

delete from Shopper
where Shopper.first_name = 'Василиса'

select * from System_data

drop trigger System_data_shoppers_delete


create trigger System_data_shoppers_update
on Shopper
after update
as
insert into System_data (shopper, information, registration)
select ID, 'Пользователь с логином ' + login + ' сменил имя на ' + first_name, getdate()
from inserted

update Shopper set first_name = 'Елена'
where first_name = 'Милана'

select * from System_data

drop trigger System_data_shoppers_update


---2---

INSERT INTO [Shops]
       VALUES
	       ('г. Москва, ул. Тверская, д. 8', 300, '08:00:00','21:00:00' ),
					('г. Санкт-Петербург, Невский проспект, д. 28', 500, '08:00:00', '21:00:00'),
					('г. Санкт-Петербург, Литейный проспект, д. 57', 505, '08:00:00', '21:00:00');

INSERT INTO [Position]
       VALUES
	        ('Продавец-кассир', 45000, 50000, '07:30:00', '21:30:00'),
					('Продавец-конcультант', 45000, 50000, '07:30:00', '21:30:00'),
					('Продавец-универсал', 50000, 60000, '07:30:00', '21:30:00'),
					('Мерчандайзер', 40000, 45000, '08:00:00', '21:00:00'),
					('Директор магазина', 100000, 150000, '07:00:00', '22:00:00'),
					('Уволенный сотрудник', 0, 0, '00:00:00', '00:00:00');

INSERT INTO [Employee]
       VALUES
	        ('Громов', 'Григорий', 'Данилович', '31.03.1992', 1, 1),
					('Алексеев', 'Дмитрий', 'Тимофеевич', '01.05.1996', 1, 1),
					('Свешников', 'Александр', 'Иванович', '30.11.1990', 1, 2),
					('Плотников', 'Илья', 'Егорович', '08.02.1994', 1, 2),
					('Минин', 'Игорь', 'Михайлович', '14.03.1980', 1, 3),
					('Короткова', 'Василиса', 'Михайловна', '18.10.1999', 1, 3),
					('Соклова', 'Маргарита', 'Арсеньева', '23.02.1984', 1, 4),
					('Герасимова', 'Асия', 'Михайловна', '11.06.1989', 1, 5),
					('Алексеева', 'Екатерина', 'Даниловна', '28.12.1994', 2, 1),
					('Попова', 'Елизавета', 'Львовна', '17.10.2000', 2, 1),
					('Блохин', 'Кирилл', 'Захарович', '20.01.2001', 2, 2),
					('Ковалев', 'Макар', 'Николаевич', '05.08.1999', 2, 2),
					('Смирнов', 'Даниэль', 'Вачеславович', '29.05.1997', 2, 3),
					('Абрамов', 'Захар', 'Дмитриевич', '14.09.1991', 2, 3),
					('Константинов', 'Илья', 'Егорович', '21.07.1989', 2, 4),
					('Беляева', 'Карина', 'Андреевна', '19.11.1981', 2, 5),
					('Гришин', 'Егор', 'Владисавович', '08.04.1992', 3, 1),
					('Антонов', 'Юрин', 'Никитич', '15.09.1997', 3, 1),
					('Герасимов', 'Петр', 'Алексеевич', '22.06.1998', 3, 2),
					('Киселев', 'Максим', 'Артемович', '20.10.2001', 3, 2),
					('Калмыков', 'Дмитрий', 'Михайлович', '19.12.2002', 3, 3),
					('Горбунова', 'Варвара', 'Максимовна', '17.01.1995', 3, 3),
					('Богданова', 'Марина', 'Андреевна', '11.03.1988', 3, 4),
					('Волкова', 'Вероника', 'Ивановна', '31.08.1985', 3, 5);

--- триггер для увольнения сотрудников 1-го магазина, кого уволили стоит 6 ---

---Люди, работающие в 1-ом магазине---
create view Employees_of_the_1st_store
as select Employee.ID, Employee.first_name, Employee.middle_name, Employee.last_name, Position.name, Position.salary, Position.cash_bonus
from Employee
inner join Position on Employee.positionID = Position.ID
where Employee.shopsID = 1

select * from Employees_of_the_1st_store

drop view Employees_of_the_1st_store


create trigger Dismissal
on Employees_of_the_1st_store
instead of delete
as
begin
		declare @q int = (select ID from deleted);
		update Employee set positionID = 6 where ID = @q;
		update Shops set employee_count = employee_count - 1 where Shops.ID = 1;
end

delete from Employees_of_the_1st_store where ID = 3

select * from Employees_of_the_1st_store
select * from Shops

drop trigger Dismissal

---триггер запрещающий прием на работу людей младше 18 лет---

---Работники для 2-го магазина---
create view Employees_of_the_2st_store
as select Employee.ID, Employee.first_name, Employee.middle_name, Employee.last_name, Employee.date_of_birth, Position.name, Position.salary, Position.cash_bonus
from Employee
inner join Position on Employee.positionID = Position.ID
where Employee.shopsID = 2

select * from Employees_of_the_2st_store

drop view Employees_of_the_2st_store

create trigger Recruitment
on Employees_of_the_2st_store
instead of insert
as
begin
		declare @Employee_date_of_birth date = (select date_of_birth from inserted);
		declare @Employee_age int = datediff(year, @Employee_date_of_birth, getdate())

		if @Employee_age < 18 rollback transaction
end

select datediff(year, '2010-10-15', getdate())

insert into Employees_of_the_2st_store 
values (17, 'Егор', 'Егоров', 'Егорович','2010-10-15', 'Продавец-кассир', 10000, 10000)

drop trigger Recruitment


---Работники 2 и 3 магазина---
create view Employees_of_the_2st_and_3st_store
as select Employee.ID, Employee.first_name, Employee.middle_name, Employee.last_name, Employee.date_of_birth, Position.name, Position.salary, Position.cash_bonus, Employee.shopsID
from Employee
inner join Position on Employee.positionID = Position.ID
where Employee.shopsID = 2 or Employee.shopsID = 3

select * from Employees_of_the_2st_and_3st_store
select * from Shops

drop view Employees_of_the_2st_and_3st_store


create trigger Translation
on Employees_of_the_2st_and_3st_store
instead of update
as
begin 
		declare @q int = (select ID from deleted);
		declare @q1 int = (select ID from inserted);
		update Employee set shopsID = 3 where @q1 = ID;
		update Shops set employee_count = employee_count - 1 where Shops.ID = 2;
		update Shops set employee_count = employee_count + 1 where Shops.ID = 3;
end

update Employees_of_the_2st_and_3st_store set shopsID = 3 where ID = 14

select * from Employees_of_the_2st_and_3st_store
select * from Shops

drop trigger Translation