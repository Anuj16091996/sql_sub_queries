select * from jobs
select * from employee
select * from titleauthor
select * from authors
select * from publishers
select * from titles
select * from stores
select * from sales
select * from discounts



--1) Select the authors who have not had any books published  by "Algodata Infosystems". In addition to the full name of 
--the author, get the amount of each advance and the  advance's corresponding book number and publisher.

select concat(a.au_fname, ' ',a.au_lname) as Authors, t.advance as Advance, t.title_id as 'Book Number'
,p.pub_name as Publishers
from authors a join titleauthor ta on a.au_id=ta.au_id
				join titles t on ta.title_id=t.title_id
				join publishers p on t.pub_id=p.pub_id

	where p.pub_name!='Algodata Infosystems'

--2) Select the authors who have had all their books published  by "Algodata Infosystems". In addition to the full name of 
-- the author, get the amount of each advance and their  corresponding book number.

				select concat(a.au_fname, ' ',a.au_lname) as Authors, t.advance as Advance, t.title_id as 'Book Number'
,p.pub_name as Publishers
from authors a join titleauthor ta on a.au_id=ta.au_id
				join titles t on ta.title_id=t.title_id
				join publishers p on t.pub_id=p.pub_id

				where p.pub_name='Algodata Infosystems'

--3) Select the names of authors who received an advance  greater than all advances paid by the publisher "Algodata 
--) Infosystems". In addition to the full name of the author, get  the amount of each advance, the corresponding book  number, and publisher

				select concat(a.au_fname, ' ',a.au_lname) as Authors, max(t.advance) as Advance, t.title_id as 'Book Number'
,p.pub_name as Publishers
from authors a join titleauthor ta on a.au_id=ta.au_id
				join titles t on ta.title_id=t.title_id
				join publishers p on t.pub_id=p.pub_id

					
				where p.pub_name='Algodata Infosystems' and t.advance >=(select avg(advance) from titles)

				group by a.au_fname,a.au_lname,t.title_id,p.pub_name

		

