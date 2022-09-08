select *from project1.dbo.Data1;
select *from project1.dbo.Data2;


--- number of rows into the dataset
select count(*) from project1..Data1;
SELECT COUNT(*) from project1..Data2;


-- dataset from jharkhand and bihar
select* from project1..Data1 where state in ('jharkhand','bihar');

-- total population of india
select sum(population)as india_population from project1..Data2;

-- avg growth
select state ,(avg(growth)*100) from project1..Data1 group by state;

-- avg sex ratio
select state,round(avg(Sex_Ratio),0)as sex from project1..Data1 group by state
order by sex desc;
-- avg literacy rate--

select state, avg(literacy) as literacy from project1..Data1 group by State 
having round(avg(literacy),0)>90 order by state ;

-- top 3 states showing highest growth ration--

select top 3 state,max(Growth)as growth from project1..Data1 group by state order by state;

--BOTTOM 3 state we want lowest growth--
select top 3 state, min(growth) as growth from project1..Data1 group by state order by state desc;

-- show both top 3 and lower 3 table in one table literacy rate--
create table #topstate(
state nvarchar(255),
topstate float
)
insert into #topstate
select top 3 state, max(literacy) as literacy from project1..Data1 
group by state order by literacy desc;
 select* from #topstate;


 create table #bottom
( state nvarchar(255),
 bottom float
 )
 insert into #bottom
 select top 3 state,min(literacy) as literarcy from project1..Data1
 group by state order by literarcy asc;
select*from #bottom;

-- make into one columns--
select top 3*from #topstate  
union 

select top 3* from #bottom 


-- remove tempory tables #topstate and #bottom;
 drop table #topstate;
 drop table #bottom;
 
--statename starting with letter -
select distinct state from project1..Data1 where state like 'a%' or state like 'b%';

-- joinig both the table'--
select a.District, a.state,a.sex_ratio,b.population from project1..Data1 as a 
inner join project1..Data2 as b on a.district=b.District;

--total literacy rate--
select a.District, a.state,a.Literacy,a.sex_ratio,b.population from project1..Data1 as a 
inner join project1..Data2 as b on a.district=b.District;

-- made a male and female column -- by simple algebra

select district,state,population/(sex_ratio+1)AS males,(population*sex_ratio+1) as female from
(select a.District,a.State,a.Sex_Ratio/1000 sex_ratio,b.population from project1..Data1 as a 
inner join project1..Data2 as b on a.District=b.District) c

-- total sum of males and females
select d.state,sum(d.male) as total_males,sum(d.female) as total_females from
(select c.district,c.state,c.Population/(c.sex_ratio) as male,(c.Population*c.sex_ratio+1) as female from
(select a.District,a.State,a.Sex_Ratio/1000 sex_ratio,b.Population from project1..Data1 as a
inner join project1..Data2 as b on a.District=b.District) c)d 
group by d.state

--total literacy rate
select c.state,sum(c.literacy_pepole) as literacy_pepole,sum( c.illitrate_people) 
as illitrate_people from
(select d.District,d.State,d.literacy_ratio*d.Population as literacy_pepole,
(1-literacy_ratio)*population illitrate_people from
(select a.District,a.State,a.Literacy literacy_ratio,b.Population from project1..Data1 as a
inner join project1..Data2 as b on a.District=b.District) d ) c
group by c.State

-- window function--
select District, state,Literacy,rank() over(partition by state order by literacy desc) 
from project1..Data1

-- rank() function with top 3 column

select TOP 3 state,District,Literacy,rank() over(partition by state order by literacy desc) 
from project1..Data1
