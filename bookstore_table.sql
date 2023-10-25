CREATE TABLE [Author] (
  [ID] int PRIMARY KEY,
  [first_name] nvarchar(255),
  [middle_name] nvarchar(255),
  [last_name] nvarchar(255)
)
GO

CREATE TABLE [Writing] (
  [ID] int PRIMARY KEY,
  [title] nvarchar(255),
  [authorID] int,
  [genreID] int,
  [year_of_writing] date
)
GO

CREATE TABLE [Genre] (
  [ID] int PRIMARY KEY,
  [name] nvarchar(255)
)
GO

CREATE TABLE [Book] (
  [ID] int PRIMARY KEY,
  [writingID] int,
  [publishing_houseID] int,
  [ISBN] nvarchar(255),
  [year_of_printing] date,
  [edition] int,
  [selling_price] money
)
GO

CREATE TABLE [Publishing_House] (
  [ID] int PRIMARY KEY,
  [name] nvarchar(255),
  [address] nvarchar(255)
)
GO

CREATE TABLE [Shops] (
  [ID] int PRIMARY KEY,
  [address] nvarchar(255),
  [employee_count] int,
  [open] time,
  [close] time
)
GO

CREATE TABLE [Supply] (
  [ID] int PRIMARY KEY,
  [bookID] int,
  [shopsID] int,
  [quantity] int,
  [purchase_date] date,
  [purchase_price] money
)
GO

CREATE TABLE [Employee] (
  [ID] int PRIMARY KEY,
  [first_name] nvarchar(255),
  [middle_name] nvarchar(255),
  [last_name] nvarchar(255),
  [shopsID] int,
  [positionID] int
)
GO

CREATE TABLE [Position] (
  [ID] int PRIMARY KEY,
  [name] nvarchar(255),
  [salary] money,
  [cash_bonus] money,
  [start_time] time,
  [finish_time] time
)
GO

CREATE TABLE [Shopper] (
  [ID] int PRIMARY KEY,
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
  [ID] int PRIMARY KEY,
  [name] nvarchar(255),
  [start] date,
  [finish] date,
  [bookID] int,
  [shopsID] int,
  [discount_percentage] tinyint
)
GO

CREATE TABLE [Cheque] (
  [ID] int PRIMARY KEY,
  [date_of_sale] date,
  [time_of_sale] time,
  [shopsID] int,
  [employeeID] int,
  [shopperID] int,
  [purchase_amount] money
)
GO

CREATE TABLE [Books_in_Cheque] (
  [ID] int PRIMARY KEY,
  [promotionID] int,
  [bookID] int,
  [chequeID] int,
  [quantity] int
)
GO

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
