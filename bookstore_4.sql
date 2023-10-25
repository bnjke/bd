CREATE TABLE [Book] (
  [ID] int NOT NULL,
  [writingID] int NOT NULL,
  [publishing_houseID] int NOT NULL,
  [ISBN] nvarchar(20) NOT NULL,
  [year_of_printing] int NOT NULL,
  [edition] int NOT NULL,
  [selling_price] money NOT NULL
)
GO

declare @n int = 0;
declare @myIdent uniqueidentifier;
declare @ID nvarchar(13);
declare @writingID int = 11111;
declare @publishing_houseID int = 111;
declare @ISBN nvarchar(20);
declare @year_of_printing int = 2000;
declare @edition int = 10;
declare @selling_price money;

while (@n<100000)
begin
	SET @myIdent = NEWID();
	SET @ID = left(replace(@myIdent,'-',''),13);
	SET @writingID = RAND()*(99999 - 11111) + 11111;
	SET @publishing_houseID = RAND()*(999 - 111) + 111;
	SET @ISBN = CONCAT ('978', '-', '5','-', FLOOR(RAND()*(99 - 10) + 10), '-', FLOOR(RAND()*(999999 - 100000)- 100000), '-', FLOOR(RAND() * (9 - 0)+ 0));
	SET @year_of_printing = RAND()*(2021-2000)+2000;
	SET @edition = RAND()*(5000-1000)+1000;
	SET @selling_price = FLOOR(RAND()*(2000-300)+300);

	insert into Book(ID, [writingID], [publishing_houseID], [ISBN], [year_of_printing], [edition], [selling_price])
	values (@n, @writingID, @publishing_houseID, @ISBN, @year_of_printing, @edition, @selling_price)
	SET @n=@n+1
end

select * 
	from Book
	where ID >= 133

---кластерный индекс---
create clustered index ix_ID on book (ID)

select *
from Book
where ID = 333

drop index ix_ID on book


---некластерный составной индекс---
create index ix_book_name_surname on Book (year_of_printing, edition)

select year_of_printing, edition
from Book
where year_of_printing = 2005 and edition > 3000

drop index ix_book_name_surname on Book 

---некластерный покрывающий индекс---
create index ix_book_ID_all on Book (publishing_houseID)
include(ID, ISBN, year_of_printing, selling_price)

select ID, publishing_houseID, ISBN, year_of_printing, selling_price
from Book 
where publishing_houseID = 331;

drop index ix_book_ID_all on Book 

---некластерный уникальный индекс--- 
create unique index ux_book_ID on Book (ID)

select *
from Book
where ID = 13

drop index ux_book_ID on Book

--- некластерный индeкс с включеными столбцами---

create index ix_book_ISBN on Book (ISBN)
include(ID, writingID, publishing_houseID, year_of_printing)

select ID, writingID, publishing_houseID, year_of_printing, ISBN
from Book
where ISBN = '978-5-51-503315-6'

drop index ix_book_ISBN on Book

---некластерный отфильтрованный индекс---

create index ix_book_year_of_printing on Book (year_of_printing)
where year_of_printing > 2019;

select Book.year_of_printing
from Book
where year_of_printing > 2019

drop index ix_book_year_of_printing on Book