--1--

--- Доход продавца-консультанта ---

create procedure Employee_income @id int, @income money output
as
begin
	declare @salary money = (select salary from Position where ID = @id);
	declare @cash_bonus money = (select cash_bonus from Position where ID = @id);
	select @income = @salary + @cash_bonus from Position where ID = @id
end

declare @q money
exec Employee_income 2, @q output
print @q

select * from Position

drop procedure Employee_income

---2---

--- Продажа книг в магазине ---

create procedure Sales_book @shop int
as
begin
	declare @title char(100) 
	declare rrr cursor for
		select title from Writing 
					  inner join Book on Writing.ID = Book.writingID
					  inner join Supply on Book.ID = Supply.bookID
					  inner join Shops on Supply.shopsID = Shops.ID
					  inner join Cheque on Shops.ID = Cheque.shopsID
		where Cheque.shopsID = @shop
		open rrr
		fetch next from rrr into @title
		while(@@FETCH_STATUS = 0)
		begin
			print(@title)
			fetch next from rrr into @title
		end
		close rrr
end

exec Sales_book 2

drop procedure Sales_book
deallocate rrr

---3---

--- Результат поставки книг ---

create procedure Result_supply @bookID int, @shopID int
as
if not exists (select * from Supply where bookID = @bookID)
	return 1
else if not exists (select * from Supply where shopsID = @shopID)
	return 2
else if not exists (select * from Supply where bookID = @bookID and shopsID = @shopID)
	return 3
else return 4

declare @q int
exec @q = Result_supply 4, 2
if (@q = 1)
	print N'Книга отсутсвует в поставке для магазинов'
else if (@q = 2)
	print N'Магазин отсутвует в книжной сети'
else if (@q = 3)
	print N'Книга из поставки для другого магазина'
else if (@q = 4)
	print N'Книга прибыла в магазин'

select * from Supply

drop procedure Result_supply

---4---

--- Книги, с поставкой более 200 штук ---

create procedure Supply_book @shop int
as
begin
	declare @1 varchar(255), @2 varchar(255), @3 varchar(255), @4 varchar(255), @5 varchar (255)  
	declare qwerty cursor for
		select Author.first_name, Author.middle_name, Author.last_name, Writing.title,Supply.quantity
			from Author
			inner join Writing on Author.ID = Writing.authorID
			inner join Book on Writing.ID = Book.writingID
			inner join Supply on Book.ID = Supply.bookID
			where Supply.quantity > 200 and Supply.shopsID = @shop
		open qwerty
		fetch next from qwerty into @1, @2, @3, @4, @5
		while(@@FETCH_STATUS = 0)
		begin
			print('Автор: ' + @1 + ' ' + @2 + ' ' + @3 + '. Название произведения: ' + @4 + '. Количество: ' + @5)
			fetch next from qwerty into @1, @2, @3, @4, @5
		end
		close qwerty
end

exec Supply_book 2

drop procedure Supply_book
deallocate qwerty


---5---

--- Выплата зарплаты для работников магазина за месяц ---

create procedure Payout @shop int, @payout money output
as
begin
	declare @salary money = (select sum (salary) from Position 
										   inner join Employee on Position.ID = Employee.positionID 
										   where shopsID = @shop);
	declare @cash_bonus money = (select sum (cash_bonus) from Position 
										   inner join Employee on Position.ID = Employee.positionID 
										   where shopsID = @shop);
	select @payout = @salary + @cash_bonus from Position 
										   inner join Employee on Position.ID = Employee.positionID 
										   where shopsID = @shop
end

declare @rrr money
exec Payout 3, @rrr output
print @rrr

drop procedure Payout


