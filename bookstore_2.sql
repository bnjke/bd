  --CREATE

CREATE TABLE [Author] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [first_name] nvarchar(255),
  [middle_name] nvarchar(255),
  [last_name] nvarchar(255)
)
GO

CREATE TABLE [Writing] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [title] nvarchar(255),
  [authorID] int,
  [genreID] int,
  [year_of_writing] int
)
GO

CREATE TABLE [Genre] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [name] nvarchar(255)
)
GO

CREATE TABLE [Book] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [writingID] int,
  [publishing_houseID] int,
  [ISBN] nvarchar(255),
  [year_of_printing] int,
  [edition] int,
  [selling_price] money
)
GO

CREATE TABLE [Publishing_House] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [name] nvarchar(255),
  [address] nvarchar(255)
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

CREATE TABLE [Supply] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [bookID] int,
  [shopsID] int,
  [quantity] int,
  [purchase_date] date,
  [purchase_price] money
)
GO

CREATE TABLE [Employee] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [first_name] nvarchar(255),
  [middle_name] nvarchar(255),
  [last_name] nvarchar(255),
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

CREATE TABLE [Promotion] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [name] nvarchar(255),
  [start] date,
  [finish] date,
  [bookID] int,
  [shopsID] int,
  [discount_percentage] tinyint
)
GO

CREATE TABLE [Cheque] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [date_of_sale] date,
  [time_of_sale] time,
  [shopsID] int,
  [employeeID] int,
  [shopperID] int,
  [purchase_amount] money
)
GO

CREATE TABLE [Books_in_Cheque] (
  [ID] int IDENTITY(1, 1) NOT NULL PRIMARY KEY,
  [promotionID] int,
  [bookID] int,
  [chequeID] int,
  [quantity] int
)
GO


-------------------------------------------------------------------------------
--ALTER

ALTER TABLE [Writing] ADD FOREIGN KEY ([authorID]) REFERENCES [Author] ([ID])
GO

ALTER TABLE [Writing] ADD FOREIGN KEY ([genreID]) REFERENCES [Genre] ([ID])
GO

ALTER TABLE [Book] ADD FOREIGN KEY ([writingID]) REFERENCES [Writing] ([ID])
GO

ALTER TABLE [Book] ADD FOREIGN KEY ([publishing_houseID]) REFERENCES [Publishing_House] ([ID])
GO

ALTER TABLE [Supply] ADD FOREIGN KEY ([bookID]) REFERENCES [Book] ([ID])
GO

ALTER TABLE [Supply] ADD FOREIGN KEY ([shopsID]) REFERENCES [Shops] ([ID])
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([shopsID]) REFERENCES [Shops] ([ID])
GO

ALTER TABLE [Employee] ADD FOREIGN KEY ([positionID]) REFERENCES [Position] ([ID])
GO

ALTER TABLE [Promotion] ADD FOREIGN KEY ([bookID]) REFERENCES [Book] ([ID])
GO

ALTER TABLE [Promotion] ADD FOREIGN KEY ([shopsID]) REFERENCES [Shops] ([ID])
GO

ALTER TABLE [Cheque] ADD FOREIGN KEY ([shopsID]) REFERENCES [Shops] ([ID])
GO

ALTER TABLE [Cheque] ADD FOREIGN KEY ([employeeID]) REFERENCES [Employee] ([ID])
GO

ALTER TABLE [Cheque] ADD FOREIGN KEY ([shopperID]) REFERENCES [Shopper] ([ID])
GO

ALTER TABLE [Books_in_Cheque] ADD FOREIGN KEY ([promotionID]) REFERENCES [Promotion] ([ID])
GO

ALTER TABLE [Books_in_Cheque] ADD FOREIGN KEY ([bookID]) REFERENCES [Book] ([ID])
GO

ALTER TABLE [Books_in_Cheque] ADD FOREIGN KEY ([chequeID]) REFERENCES [Cheque] ([ID])
GO


-------------------------------------------------------------------------------
--INSERT

INSERT INTO [Author]
	   VALUES
			('Нелл', 'Харпер', 'Ли'),
					('Остин', 'Джейн', 'Бронте'),
					('Франк', 'Анна', 'Аннелиз'),
					('Оруэлл', 'Джордж', 'Блэр'),
					('Толкин', 'Джон', 'Руэл'),
					('Скотт', 'Фрэнсис', 'Фицджеральд'),
					('Роулинг', 'Джоан', 'Кэтлин'),
					('Мэй', 'Луиза', 'Олкотт'),
					('Брукс', 'Элвин', 'Уайт'),

INSERT INTO [Genre]
	   VALUES
			('драма'),
					('фантастика'),
					('роман'),
					('повесть');
					('приключения'),
					('мемуары'),
					('комедия');
					('биография');
					('антиутопия');

INSERT INTO [Writing]
       VALUES
	        ('Убить пересмешника', 1, 3, 1962),
					('Гордость и предубеждение', 2, 1, 1813),
					('Дневник Анны Франк', 3, 8, 2000),
					('1984', 4, 9, 2001),
					('Властелин колец', 5, 2, 1872),
					('Великий Гэтсби', 6, 3, 1836),
					('Гарри Поттер и философский камень', 7, 2, 1997),
					('Паутина Шарлотты', 9, 4, 1867),
					('Маленькие женщины', 8, 8, 1887),
					('Хоббит', 5, 2, 1833);

INSERT INTO [Publishing_House]
	   VALUES
			('РОСМЭН', 'г. Москва, ул. Шереметьевская, д. 47'),
					('ЭКСМО', ' г. Москва, ул. Зорге, д.1'),
					('АСТ', 'Москва, Звездный бульвар, д.21,'),
					('АЗБУКА', 'г. Москва, ул. Павловская, д. 7'),
					('АЗБУКА-КЛАССИКА', 'г. Санкт-Петербург, Воскресенская набережная, д. 12');

INSERT INTO [Book]
       VALUES
	        (1, 3, '978-5-17-083520-1', 2019, 5000, 391),
					(2, 1, '978-5-17-057808-5', 2019, 3000, 600),
					(3, 8, '978-5-4467-3088-9', 2016, 10000, 555),
					(4, 9, '978-5-04-116479-9', 2014, 3000, 400),
					(5, 2, '978-5-17-089322-5', 2020, 1500, 700),
					(6, 3, '978-5-04-118516-9', 2021, 3000, 450),
					(7, 2, '978-5-353-00308-3', 2000, 25000, 460),
					(9, 4, '978-5-17-067618-7', 2021, 4000, 600),
					(8, 8, '978-5-04-108626-8', 2021, 3500, 700),
					(5, 2, '978-5-17-106123-4',2019, 2000, 480);

INSERT INTO [Shops]
       VALUES
	       ('г. Самара, ул. 50 лет Победы, д. 29/39', 101, '08:00:00','21:00:00' ),
					('г. Саратов, ул. Рабочая, д. 28', 400, '08:00:00', '21:00:00'),
					('г. Москва, ул. Ленина, д. 21', 235, '08:00:00', '21:00:00');

INSERT INTO [Supply]
       VALUES
			(1, 1, 250, '11.05.2020', 291),
					(2, 2, 190, '12.10.2022', 500),
					(3, 3, 300, '13.10.2022', 455),
					(4, 1, 200, '13.10.2022', 300),
					(5, 2, 110, '13.10.2022', 600),
					(6, 3, 420, '11.10.2022', 350),
					(7, 1, 400, '10.10.2022', 360),
					(8, 2, 589, '11.10.2022', 500),
					(9, 3, 100, '14.10.2022', 500),
					(10, 1, 70, '11.10.2022', 280);

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

INSERT INTO [Promotion]
       VALUES
	        ('Почитай старших', '12.12.2021', '12.01.2022', 1, 1, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 1, 2, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 1, 3, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 6, 1, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 8, 3, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 5, 1, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 5, 2, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 5, 3, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 6, 3, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 6, 2, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 10, 2, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 8, 1, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 8, 2, 15),
					('Почитай старших', '12.12.2021', '12.01.2022', 10, 3, 15);
					('Почитай старших', '12.12.2021', '12.01.2022', 10, 1, 15),

INSERT INTO[Cheque]
       VALUES
	       ('05.07.2022', '14:45:00', 1, 3, 9, 1515.1),
				   ('19.11.2022', '11:18:00', 1, 8, 7, 1234),
				   ('14.05.2022', '10:59:00', 2, 10, 5, 656.2),
				   ('23.08.2022', '19:51:00', 3, 12, 3, 438.3),
				   ('21.11.2022', '15:42:00', 3, 11, 4, 554.2);

INSERT INTO[Books_in_Cheque]
       VALUES
	       (1, 1, 1, 2),
					(4, 5, 1, 2),
					(10, 8, 2, 1),
					(NULL, 4, 3, 1),
					(NULL, 2, 3, 1),
					(NULL, 9, 4, 1),
					(9, 6, 5, 1),
					(15, 10, 5, 1);

select * from Author
select * from Genre
select * from Writing
select * from Publishing_House
select * from Book
select * from Shops
select * from Supply
select * from Position
select * from Employee
select * from Shopper
select * from Promotion
select * from Cheque
select * from Books_in_Cheque


-------------------------------------------------------------------------------
--DELETE and DELETE WHERE

delete Books_in_Cheque

INSERT INTO[Books_in_Cheque]
VALUES
(1, 1, 1, 2),
(NULL, 2, 1, 2),
(10, 3, 2, 1),
(8, 4, 3, 1),
(NULL, 5, 3, 2),
(3, 2, 4, 1),
(9, 6, 5, 3),
(NULL, 10, 1, 2);

select * from Books_in_Cheque

delete Books_in_Cheque
select * from Books_in_Cheque

INSERT INTO[Books_in_Cheque]
VALUES
(1, 1, 1, 2),
(NULL, 2, 1, 2),
(10, 3, 2, 1),
(8, 4, 3, 1),
(NULL, 5, 3, 2),
(3, 2, 4, 1),
(9, 6, 5, 3),
(NULL, 10, 1, 2);

delete Books_in_Cheque where bookID = 3 or quantity = 2
select * from Books_in_Cheque
