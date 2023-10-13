 -------------------------------------------------------------------------------
--1

select Writing.title, Genre.name
	from Genre
		inner join Writing on Writing.genreID = Genre.ID

select Writing.title, Genre.name
	from Genre
		left outer join Writing on Writing.genreID = Genre.ID

select Writing.title, Genre.name
	from Genre
		right outer join Writing on Writing.genreID = Genre.ID

select Writing.title, Genre.name
	from Genre
		full outer join Writing on Writing.genreID = Genre.ID

select Writing.title, Genre.name
	from Writing cross join Genre

select Writing.title, Genre.name
	from Writing cross apply Genre

select Writing.title, Writing.year_of_writing
	from Writing inner join Writing t2
		on Writing.year_of_writing < 1900

-------------------------------------------------------------------------------
--2

select *
	from Writing where Writing.authorID = 1
		union 
select *
	from Writing where Writing.genreID = 4

select *
	from Writing where Writing.authorID = 1
		union all
select *
	from Writing where Writing.genreID = 4

select *
	from Writing where Writing.authorID = 4
		except
select *
	from Writing where Writing.genreID = 4

select Employee.first_name, Employee.middle_name, Employee.last_name
	from Employee where Employee.shopsID = 2
		intersect
select Employee.first_name, Employee.middle_name, Employee.last_name
	from Employee where Employee.positionID = 1

-------------------------------------------------------------------------------
--3

select *
	from Employee
	where exists (select * from Position where Employee.positionID = 5)

select *
	from Employee
	where Employee.positionID in (1, 2)

select *
	from Supply
	where Supply.bookID = any (select Supply.bookID from Supply where quantity > 300)

select *
	from Supply
	where Supply.bookID = some (select Supply.bookID from Supply where quantity > 200)

select *
	from Supply
	where Supply.purchase_price between 200 and 400

select *
	from Publishing_House
	where Publishing_House.address like 'г. Москва%'

-------------------------------------------------------------------------------
--4

select Book.writingID, Book.ISBN, Book.year_of_printing, Book.edition, Book.selling_price,
	case Publishing_houseID
	when 5 then 'Издано в городе Санкт-Петербург'
	else 'Издано в городе Москва'
	end as city_of_publication
from Book

select Genre.name,
	case when Writing.title is null then 'Книги такого жанра нет'
	else 'Книга такого жанра есть'
	end as existence
	from Genre
		left join Writing on Writing.genreID = Genre.ID

-------------------------------------------------------------------------------
--5

select 'Средняя цена закупки книг составляет ' + cast (AVG(purchase_price) as char(10))
	from Supply

select 'Средняя цена продажи книг составляет  ' + convert (char(15), AVG(selling_price))
	from Book

select Genre.name,
	isnull(title, 'книги такого жанра нет') as rrr
	from Genre
		left join Writing on Writing.genreID = Genre.ID

select nullif (3000, edition)
	from Book

select coalesce (iif(ID = 7 or ID = 3, 'Книги такого жанра нет', 
	choose(ID, 'Десять негритят', 'Гарри Поттер и философский камень', 'Мастер и Маргарита', 'Как писать книги', 'Ревизор')), 'нет такого жанра') as rrr
	from Genre


-------------------------------------------------------------------------------
--6

select replace(employee_count, 300, 500)
	from Shops

select substring(address, 1, len(address))
	from Shops

select stuff(address, 1, 2, ' ')
	from Shops

select str(avg(cast(ID as float)), 1) as rrr
	from Shops

select unicode(address)
	from Shops

select lower(address)
	from Shops

select upper(address)
	from Shops

-------------------------------------------------------------------------------
--7

select datepart(day, date_of_sale) day_sale, datepart(month, date_of_sale) month_sale, datepart(year, date_of_sale) year_sale
	from Cheque

select dateadd(day, 7, date_of_sale) 
	from Cheque

select datediff(hh, [open], [close])
	from Shops

select getdate()

select SYSDATETIMEOFFSET()

-------------------------------------------------------------------------------
--8

select shopsID, count(ID) as rrr
	from Employee
	group by shopsID 
	having shopsID = 1

select positionID, count(ID)
	from Employee
	group by positionID

select * from Employee