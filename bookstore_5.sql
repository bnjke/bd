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
	       ('7MqVeD', 'FpTOBA', 'Олег', '08.03.1999', 10000, 11, 1000),
				   ('rkEmXt', 'yzT7hL2', 'Илья', '20.01.1993', 12000, 2, 2000),
				   ('8SmYTL', 'G8m9aj', 'Арсений', '08.10.1981', 15900, 3, 300),
				   ('8ka70t', 'AwByJyh', 'Ульяна', '12.04.1971', 23000, 40, 200),
				   ('LzdZyO', 'BAoFCX', 'Лариса', '26.03.1990', 14560, 23, 500),
				   ('eOwpkk', 'bmbY7Y', 'Георгий', '06.01.1978', 12980, 0, 230),
				   ('R2OXcr', 'J4s0rA', 'Валерий', '12.02.1992', 13210, 5, 580),
				   ('5JSMMO', 'zEMXGx', 'Максим', '14.08.1968', 5050, 0, 120),
				   ('h0dtZ3', 'r4V1zI', 'Максим', '12.02.1992', 560, 7, 90),
				   ('EuACgi', 'rkEmXt', 'Антон', '17.04.1972', 16390, 21, 10);

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
where Shopper.first_name = 'Валерий'

select * from System_data

drop trigger System_data_shoppers_delete


create trigger System_data_shoppers_update
on Shopper
after update
as
insert into System_data (shopper, information, registration)
select ID, 'Пользователь с логином ' + login + ' сменил имя на ' + first_name, getdate()
from inserted

update Shopper set first_name = 'Ирина'
where first_name = 'Ульяна'

select * from System_data

drop trigger System_data_shoppers_update


---2---

INSERT INTO [Shops]
       VALUES
	       ('г. Самара, ул. 50 лет Победы, д. 29/39', 101, '08:00:00','21:00:00' ),
					('г. Саратов, ул. Рабочая, д. 28', 400, '08:00:00', '21:00:00'),
					('г. Москва, ул. Ленина, д. 21', 235, '08:00:00', '21:00:00');
INSERT INTO [Position]
       VALUES
	        ('Продавец-кассир', 45000, 50000, '07:30:00', '21:00:00'),
					('Продавец-конcультант', 45000, 50000, '07:30:00', '21:00:00'),
					('Мерчандайзер', 40000, 45000, '08:00:00', '21:00:00'),
					('Директор магазина', 100000, 150000, '07:00:00', '22:00:00');
					('Менеджер', 50000, 75000, '07:00:00', '22:00:00');

INSERT INTO [Employee]
       VALUES
	        ('Пищиков', 'Павел', 'Григорьевич', 1, 1),
					('Косарёв', 'Валерий', 'Романович', 1, 1),
					('Летавина', 'Елизавета', 'Феоктистовна', 1, 2),
					('Ясеневский', 'Герасим', 'Степанович', 2, 1),
					('Загряжский', 'Аркадий', 'Федорович', 1, 1),
					('Куксюк', 'Константин', 'Германович', 1, 2),
					('Майсак', 'Нонна', 'Феодосьевна', 1, 3),
					('Аверина', 'Светлана', 'Трофимовна', 1, 2),
					('Агеев', 'Ефим', 'Трофимович', 2, 5),
					('Сухов', 'Илья', 'Герасимович', 2, 1),
					('Рыбаков', 'Дмитрий', 'Дмитрий', 2, 3),
					('Манякина', 'Катерина', 'Наумовна', 2, 1),
					('Воликов', 'Роман', 'Семенович', 2, 2),
					('Яковкин', 'Валерий', 'Прокопьевич', 2, 1),
					('Бабанина', 'Ольга', 'Леонтьевна', 2, 1),
					('Чадова', 'Елена', 'Юрьевна', 2, 4),
					('Щербатых', 'Ева', 'Ефремовна', 3, 5),
					('Занин', 'Леонид', 'Давидович', 3, 1),
					('Рутберг', 'Степан', 'Игнатьевич', 3, 4),
					('Яровая', 'Ася', 'Никифоровна', 3, 1),
					('Фарест', 'Клавдия', 'Федоровна', 3, 5),
					('Кинжаев', 'Яков', 'Савванович', 3, 5),

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
values (17, 'Илья', 'Прошкин', 'Андреевич','2012-11-11', 'Продавец-кассир', 10000, 10000)

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
