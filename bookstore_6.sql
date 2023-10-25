---1---

---Люди, работающие в 1-ом магазине---
create view Employees_of_the_1st_store
as select first_name, middle_name, last_name
		from Employee
		where shopsID = 1

select * from Employees_of_the_1st_store

drop view Employees_of_the_1st_store

---Название романов---
create view Title_genre
as select Writing.title, Genre.name
	from Genre
		inner join Writing on Writing.genreID = Genre.ID
		where name = 'роман'

select * from Title_genre

drop view Title_genre

---Книги с поставкой больше 200 штук---
create view Supply_view
as select Author.first_name, Author.middle_name, Author.last_name, Writing.title,Supply.quantity, Supply.shopsID
from Author
inner join Writing on Author.ID = Writing.authorID
inner join Book on Writing.ID = Book.writingID
inner join Supply on Book.ID = Supply.bookID
where Supply.quantity > 200

select * from Supply_view

drop view Supply_view


---2---

---проверка 3-й книги в поставках---
create view Supply_book_namber3
as select * from Supply
where Supply.bookID = 3
with check option;

select * from Supply_book_namber3

INSERT INTO Supply_book_namber3
       VALUES
			(3, 2, 320, '12.05.2020', 400);

INSERT INTO Supply_book_namber3
       VALUES
			(5, 1, 500, '13.05.2020', 200);

drop view Supply_book_namber3


---3---

---названия произведений, жанр и где они изданы---

set numeric_roundabort off;
set ansi_padding, ansi_warnings, concat_null_yields_null, arithabort, quoted_identifier, ansi_nulls on;
GO

create view Book_release
with schemabinding
as select Author.first_name, Author.middle_name, Author.last_name, Writing.title, Publishing_House.name
from dbo.Author
inner join dbo.Writing on Author.ID = Writing.authorID
inner join dbo.Book on Writing.ID = Book.writingID
inner join dbo.Publishing_House on Book.publishing_houseID = Publishing_House.ID

create unique clustered index Book_release_index on Book_release (first_name)

select * from Book_release
where  first_name = 'Кинг'

drop index Book_release_index on Book_release

select Author.first_name, Author.middle_name, Author.last_name, Writing.title, Publishing_House.name
from dbo.Author
inner join dbo.Writing on Author.ID = Writing.authorID
inner join dbo.Book on Writing.ID = Book.writingID
inner join dbo.Publishing_House on Book.publishing_houseID = Publishing_House.ID

select * from Book_release

drop view Book_release

