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
			('Булгаков', 'Михаил', 'Афансьевич'),
					('Достоевский', 'Федор', 'Михайлович'),
					('Толстой', 'Лев', 'Николаевич'),
					('Пушкин', 'Александр', 'Сергеевич'),
					('Гоголь', 'Николай', 'Васильевич'),
					('Кинг', 'Стивен', 'Эдвин'),
					('Роулинг', 'Джоан', 'Кэтлин'),
					('Кристи', 'Агата', 'Мэри'),
					('Гейман', 'Нил', 'Ричард'),
					('Дойл', 'Артур', 'Конан');

INSERT INTO [Genre]
	   VALUES
			('детектив'),
					('фантастика'),
					('приключения'),
					('роман'),
					('мемуары'),
					('комедия');

INSERT INTO [Writing]
       VALUES
	        ('Мастер и Маргарита', 1, 4, 1996),
					('Десять негритят', 8, 1, 1939),
					('Как писать книги', 6, 5, 2000),
					('Американские боги', 9, 2, 2001),
					('Бесы', 2, 4, 1872),
					('Ревизор', 5, 6, 1836),
					('Гарри Поттер и философский камень', 7, 2, 1997),
					('Война и мир', 3, 4, 1867),
					('Этюд в багровых тонах', 10, 1, 1887),
					('Евгений Онегин', 4, 4, 1833);

INSERT INTO [Publishing_House]
	   VALUES
			('РОСМЭН', 'г. Москва, ул. Шереметьевская, д. 47'),
					('АСТ', 'Москва, Звездный бульвар, д.21,'),
					('ЭКСМО', ' г. Москва, ул. Зорге, д.1'),
					('АЗБУКА', 'г. Москва, ул. Павловская, д. 7'),
					('АЗБУКА-КЛАССИКА', 'г. Санкт-Петербург, Воскресенская набережная, д. 12');

INSERT INTO [Book]
       VALUES
	        (1, 3, '978-5-04-103659-1', 2019, 5000, 391),
					(2, 3, '978-5-04-091126-4', 2019, 3000, 593),
					(3, 2, '978-5-17-099726-8', 2016, 10000, 593),
					(4, 2, '978-5-17-084620-7', 2014, 3000, 600),
					(5, 5, '978-5-389-01464-0', 2020, 4000, 453),
					(6, 3, '978-5-04-118516-9', 2021, 3000, 466),
					(7, 1, '978-5-353-00308-3', 2000, 30000, 700),
					(8, 4, '978-5-389-14702-7', 2021, 2000, 2000),
					(9, 3, '978-5-04-122108-9', 2021, 5000, 504),
					(10, 3, '978-5-699-92452-3',2019, 3000, 680);

INSERT INTO [Shops]
       VALUES
	       ('г. Москва, ул. Тверская, д. 8', 300, '08:00:00','21:00:00' ),
					('г. Санкт-Петербург, Невский проспект, д. 28', 500, '08:00:00', '21:00:00'),
					('г. Санкт-Петербург, Литейный проспект, д. 57', 505, '08:00:00', '21:00:00');

INSERT INTO [Supply]
       VALUES
			(1, 1, 300, '11.05.2020', 191),
					(2, 2, 200, '12.05.2020', 393),
					(3, 3, 120, '13.05.2020', 393),
					(4, 1, 350, '11.05.2020', 400),
					(5, 2, 220, '12.05.2020', 253),
					(6, 3, 175, '13.05.2020', 266),
					(7, 1, 500, '11.05.2020', 500),
					(8, 2, 70, '12.05.2020', 1800),
					(9, 3, 303, '13.05.2020', 304),
					(10, 1, 245, '11.05.2020', 480);

INSERT INTO [Position]
       VALUES
	        ('Продавец-кассир', 45000, 50000, '07:30:00', '21:30:00'),
					('Продавец-конcультант', 45000, 50000, '07:30:00', '21:30:00'),
					('Продавец-универсал', 50000, 60000, '07:30:00', '21:30:00'),
					('Мерчандайзер', 40000, 45000, '08:00:00', '21:00:00'),
					('Директор магазина', 100000, 150000, '07:00:00', '22:00:00');

INSERT INTO [Employee]
       VALUES
	        ('Громов', 'Григорий', 'Данилович', 1, 1),
					('Алексеев', 'Дмитрий', 'Тимофеевич', 1, 1),
					('Свешников', 'Александр', 'Иванович', 1, 2),
					('Плотников', 'Илья', 'Егорович', 1, 2),
					('Минин', 'Игорь', 'Михайлович', 1, 3),
					('Короткова', 'Василиса', 'Михайловна', 1, 3),
					('Соклова', 'Маргарита', 'Арсеньева', 1, 4),
					('Герасимова', 'Асия', 'Михайловна', 1, 5),
					('Алексеева', 'Екатерина', 'Даниловна', 2, 1),
					('Попова', 'Елизавета', 'Львовна', 2, 1),
					('Блохин', 'Кирилл', 'Захарович', 2, 2),
					('Ковалев', 'Макар', 'Николаевич', 2, 2),
					('Смирнов', 'Даниэль', 'Вачеславович', 2, 3),
					('Абрамов', 'Захар', 'Дмитриевич', 2, 3),
					('Константинов', 'Илья', 'Егорович', 2, 4),
					('Беляева', 'Карина', 'Андреевна', 2, 5),
					('Гришин', 'Егор', 'Владисавович', 3, 1),
					('Антонов', 'Юрин', 'Никитич', 3, 1),
					('Герасимов', 'Петр', 'Алексеевич', 3, 2),
					('Киселев', 'Максим', 'Артемович', 3, 2),
					('Калмыков', 'Дмитрий', 'Михайлович', 3, 3),
					('Горбунова', 'Варвара', 'Максимовна', 3, 3),
					('Богданова', 'Марина', 'Андреевна', 3, 4),
					('Волкова', 'Вероника', 'Ивановна', 3, 5);

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

INSERT INTO [Promotion]
       VALUES
	        ('Снова в школу', '15.08.2020', '15.09.2020', 1, 1, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 1, 2, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 1, 3, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 5, 1, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 5, 2, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 5, 3, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 6, 1, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 6, 2, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 6, 3, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 8, 1, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 8, 2, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 8, 3, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 10, 1, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 10, 2, 15),
					('Снова в школу', '15.08.2020', '15.09.2020', 10, 3, 15);

INSERT INTO[Cheque]
       VALUES
	       ('03.08.2020', '13:45:00', 1, 2, 9, 1420.5),
				   ('19.06.2020', '11:23:00', 1, 4, 3, 1462),
				   ('04.09.2020', '20:50:00', 2, 13, 7, 966.3),
				   ('12.07.2020', '09:13:00', 3, 19, 5, 438.5),
				   ('23.05.2020', '15:34:00', 3, 20, 8, 974.1);

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
(4, 5, 1, 2),
(10, 8, 2, 1),
(NULL, 4, 3, 1),
(NULL, 2, 3, 1),
(NULL, 9, 4, 1),
(9, 6, 5, 1),
(15, 10, 5, 1);

select * from Books_in_Cheque

delete Books_in_Cheque
select * from Books_in_Cheque

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

delete Books_in_Cheque where bookID = 10 or quantity = 2
select * from Books_in_Cheque