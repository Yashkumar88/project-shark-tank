select *from project2..Data;

-- total episode--
select max(epno) as epsno from project2..data
--or--
select count(distinct epno) from project2..data;

--pitches--
select count(distinct brand) from project2..Data;

--pitches converted--
select cast(sum(a.converted_not_converted) as float)/cast(count(*)as float)  from(
select amount , case when  amount>0  then 1 else 0 end as  
converted_not_converted from project2..Data)a;

-- total number of males--
select sum(male) as male,EpNo from project2..Data
 group by EpNo
 --0r-
 select sum(male) from project2..Data;

 --total females-
 select sum(female) from project2..Data;

 --gender ratios--
 select sum(female)/sum(male) as gender_ratio from project2..data;
 
 --total invested amount--

 select '$',sum(amount) as total from project2..data;

 --avg equity taken--
 select avg([Equity Taken %])*100  from project2..Data;

 --highest deal taken--
 select max(amount) from project2..data;

 --- case satatement--
  select female,
  case when female>0 then 1
  else 0
  end as female_count from project2..data;

  -- startups having at least women
 select sum(a.female_count) startups having at least women from (
 select female,case when female>0 then 1 else 0 end as female_count from project2..data)a;

 --  having no deals--
 select case when a.female>0 then 1 else 0 end as female_count ,a.*from(
 select *from project2..Data where Deal!='no deal')a;

 --avg team member--
  select avg([Team members]) as [Team members] from project2..data;

  -- amount invested per deal--
  select avg(a.amount) amount_invested_per_data from 
  (select* from project2..Data where deal!='No dealo')a;
 
 --avg age growth--

select [Avg age],count([Avg age]) as cnt from project2..Data group by [Avg age] order by cnt;

--location group of  contestrants--
 select [Location],count([Location]) as cnt from project2..Data group by location order by cnt; 

--sector group of contestants--
select 


