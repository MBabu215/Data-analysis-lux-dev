select * from dataanalytics.international_debt
select count(*) from dataanalytics.international_debt

--- What is the total amount of debt owed by all countries in the dataset?
select sum (debt) as total_debt
from dataanalytics.international_debt;

--- How many distinct countries are recorded in the dataset?
select count (distinct country_name) as country_name 
from dataanalytics.international_debt;

---What are the distinct types of debt indicators, and what do they represent?
select distinct (indicator_name) as distinct_debt_indicator
from dataanalytics.international_debt;

---Which country has the highest total debt, and how much does it owe?
select country_name, debt from dataanalytics.international_debt
order by debt desc
limit 1;

--- What is the average debt across different debt indicators?
select avg (debt) as debt_indicators
from dataanalytics.international_debt
group by indicator_name;


