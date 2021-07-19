select * from jobs
select * from titleauthor
select * from authors
select * from publishers
select * from employee
select * from titles
select * from sales
select * from stores
select * from discounts





--1) Display the titles of books whose price is above average. Also show the average price of the displayed book.
declare @avg_price_title float
set @avg_price_title=(select avg(price)from titles)select t.title as Title, t.price as Pricefrom titles twhere t.price >@avg_price_title	union allselect 'Average' title, (select avg(price)as 'Average Price' from titles where price >@avg_price_title)--2) Display the average price of books priced above the average price of all books.select avg(price)as 'Average Price' from titles where price >@avg_price_title--3) Display book "types" of which at least one price of the books that comprise them is greater than the average price of all titles.declare @03avg_price_title float
set @03avg_price_title=(select avg(price)from titles)select distinct type as 'Types' from titles where price > @03avg_price_title--4) Display book "types" of which at least one price of the books of which they are composed is higher than the average price of the
--) books, and whose title begins with the letter "o".select distinct type as 'Types' from titles where price > @03avg_price_title and title like 'o%'--5) Display the titles of all books which has never been sold. Use the EXISTS clause)select title from titles t1where exists(select *from titles t2  where t2.title_id=t1.title_idand advance is null)--6) Which publishers have at least one published book that has received an advance payment over $ 10,000?select distinct pub_name from publishers p join titles t on p.pub_id=t.pub_idwhere t.advance >10000	--7) Display the books sold and their quantity for each city in the state of California and Washington. Use a subquery.						select t.title_id, t.title, st.city, st.state, sa.qty 	from titles t join sales sa on t.title_id=sa.title_id					join stores st on sa.stor_id=st.stor_id					where st.state='WA' or  st.state='CA'--8) Display the quantity of books sold in each city in the state of Washington.	select st.city, st.state, sum(sa.qty) as 'Quantity'	from titles t join sales sa on t.title_id=sa.title_id					join stores st on sa.stor_id=st.stor_id					where st.state='WA'					group by st.city, st.state--9) For each employee with a job_lvl > 200, display the publisher they work for, their name, and their job_lvl. select p.pub_name as Publishers, CONCAT(e.fname,' ' ,e.lname) as 'Employee Name ', e.job_lvl as 'Job Level'from publishers p join employee e on p.pub_id=e.pub_idwhere e.job_lvl >200--10) Find the most expensive book(s).select title, price as Price from titleswhere price =(select max(price) from titles)--11) Find the book(s) with the highest advance payment.select title, advance as Advance from titleswhere advance =(select max(advance) from titles)--12) Which class (job_id) of employee has the greatest number of employees with that id? Display the job_id and the number of employees with that idselect job_id, count(*) as 'Number of Employees'from employeegroup by job_idhaving count(*)=(select max(jobcount) from (select count(job_id) as jobcount from employeegroup by job_id) as t1 )--13) For each year, display the year and the amount of employees that were hired that year. select Years=DATEPART(YEAR,hire_date), count(*) as 'Number of employees' from employee group by DATEPART(YEAR,hire_date)--14) Display the year and number of employees hired of the year where the most employees were hired. select Years=DATEPART(YEAR,hire_date), count(*) as 'Number of employees' from employee group by DATEPART(YEAR,hire_date)having count(hire_date)=(select max(numberofemp) from 						(select count(*) as numberofemp from employee group by   DATEPART(YEAR,hire_date))as w)	--15) Display the last name, first name, and date hired of the most recently hired employee.	select fname, lname , CONVERT(varchar(50), hire_date,107) as 'Employment Date' from employee	where hire_date=(select max(hire_date)from employee)	--16)  Display the book id and titles of books not sold between the dates 1/1/93 and 31/12/93. Use the following two methods :
--) with the n operator with EXISTSselect  t.title_id as 'Book id ', t.title as 'Book Name'--concat((DATEPART(YEAR,sa.ord_date)),' /' ,(DATEPART(MONTH,sa.ord_date)), ' /', (DATEPART(DAY,sa.ord_date)) ) as 'Order date'from titles t-- join sales sa on t.title_id=sa.title_id--where t.title_id in(select t.title_id from titles t join sales sa on t.title_id=sa.title_idwhere  not EXISTS (select* from sales s where t.title_id=s.title_id and  ord_date  between '1993-01-01' and '1993-12-31')select t.title_id , title from titles t
where not exists (select * from sales s
                  where s.title_id = t.title_id
				  and ord_date between '1993-1-1' and '1993-12-31') 


--17) We want to know the income generated by each author. For each author, display the last name concatenated with the first name,
--and the income that author generated.

select concat(a.au_lname,' ',a.au_fname) as 'Author Name', concat(sum(t.price* sa.qty),' ','$') as 'Advance '
from authors a join titleauthor ta on a.au_id=ta.au_id
				join titles t on t.title_id=ta.title_id
				join sales sa on sa.title_id =t.title_id

				group by a.au_fname, a.au_lname

				order by sum(t.price* sa.qty) desc

		
--18) Display the full name(s) of the author(s) who wrote the most books. Do not use the COMPUTE clause

select concat(a.au_lname,' ',a.au_fname) as 'Author Name',count(t.title_id)as 'Number of Books'
from authors a join titleauthor ta on a.au_id=ta.au_id
			join titles t on ta.title_id = t.title_id
			group by a.au_lname, a.au_fname

			having count(t.title_id)=(select max(numberofbook) from 
			(select count(t.title_id) as numberofbook from titles t join titleauthor ta on t.title_id=ta.title_id
															join authors a on ta.au_id=a.au_id
			     group by a.au_fname,a.au_lname)as w)

			



		