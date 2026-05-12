/*Identify "High-Value Stores.":Create a query that first calculates the total revenue for every store in a CTE. Then, in your main query, 
join this CTE with the store table to return the StoreKey, Country, and Total Revenue, but only for stores that have 
generated more than $1,000,000 in total sales.*/
with total_revenue_store as (
	select sales.StoreKey,sum(quantity*cast(`Unit Price USD` as decimal(10,2))) as sales_store from sales
	join products on sales.ProductKey=products.ProductKey
	group by StoreKey
)
select stores.StoreKey, stores.Country, sales_store from total_revenue_store
join stores on stores.StoreKey=total_revenue_store.StoreKey
where sales_store > 1000000
order by sales_store desc ;
/*Analyze Product Performance within Categories: Statement: For every product sold, display the Product Name, Category, and Unit Price. 
Use a window function to rank products by their Unit Price within each Category (highest price gets rank 1).
Bonus: Add a column showing the running total of Quantity sold for each product, ordered by Order_Date_Clean.*/
select `Product Name`,
Category,
`Unit Price USD`,
s.Quantity,
rank() over(
	partition by category 
	order by cast(`Unit Price USD` as decimal(10,2)) desc
) as price_rank,
sum(s.Quantity) over(
	partition by  p.ProductKey
    order by order_date_clean
     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) as running_quantiy_total
from products p
join sales s on s.ProductKey =p.ProductKey
order by p.Category,price_rank;

/*Calculate Moving Averages.:For a specific store (e.g., StoreKey = 10), list all unique Order_Date_Clean values and the total quantity 
sold on that day. 
Add a column that calculates a 7-day moving average of the quantity sold to smooth out daily fluctuations.*/
with daily_sales as (
select Order_Date_Clean,
sum(quantity) as total_qty
from sales
where StoreKey=10
group by Order_Date_Clean
)

select
Order_Date_Clean,
total_qty,
avg(total_qty) over(
	order by order_date_clean
	rows between 6 preceding and current row
) as avg_week
from daily_sales
order by Order_Date_Clean;

/*Find Customers with Above-Average Purchases.:Write a query to find all customers (Return Name and CustomerKey) who have placed at 
least one order where the Quantity was greater than the average quantity of all items ever sold in that customer's specific Country.*/

select ce.name, 
ce.CustomerKey, country,quantity
from customers_ex2 ce
join sales sl on sl.CustomerKey=ce.customerkey
where Quantity>
(select avg(Quantity) as avg_qty from sales 
join customers_ex2 ce on ce.customerkey=sales.customerkey
)
order by ce.country, quantity;
# another way 
with country_qty as(
	select 
    country,
    avg(quantity) as avg_qty
    from sales sl
    join customers_ex2 ce on ce.CustomerKey=sl.customerkey
    group by country
) 
select ce.name,
ce.customerkey,
ce.country,
sl.quantity,
ca.avg_qty
from customers_ex2 ce
join sales sl on sl.customerkey=ce.CustomerKey
join country_qty ca on ca.Country=ce.country
where ca.avg_qty<sl.quantity
order by country;

/*Identify Underperforming Categories.:Write a query to find Categories that have never been sold in stores located in 'Italy'. You should use a subquery or an 
EXCEPT/NOT IN clause to filter out categories that appear in sales records linked to Italian stores.*/
select  distinct category
from products
where category not in(
select distinct pd.category
from sales sl
join stores ss on ss.StoreKey=sl.StoreKey
join products pd on pd.ProductKey=sl.ProductKey
where Country='Netherlands'
);
SELECT COUNT(DISTINCT pd.Category)
FROM sales sl
JOIN stores ss ON ss.StoreKey = sl.StoreKey
JOIN products pd ON pd.ProductKey = sl.ProductKey
WHERE ss.Country = 'United Kingdom';
select distinct country from stores;


/*Month-over-Month Growth.:Statement: 1. Use a CTE to aggregate total revenue by month and year using Order_Date_Clean.
2. In the main query, use the LAG() window function to pull the previous month's revenue onto the current row.
3. Calculate the percentage growth month-over-month.
4. Finally, wrap this in another layer to only show months where the growth was higher than 10%.*/

with agg_tot_mon as (
	select 
    date_format(order_date_clean,'%Y-%m') as yearmonth,
	sum(quantity*cast(`Unit Price USD` as decimal(10,2))) as tot_rev_per_mon
    from products pd
    join sales sl on sl.productkey=pd.productkey
    group by yearmonth
),
growth_calc as(
	select yearmonth,
	tot_rev_per_mon,
    lag(tot_rev_per_mon) over (order by yearmonth) as prev_rev,
    -- Calculate raw percentage first for easier filtering
    ((tot_rev_per_mon - lag(tot_rev_per_mon) over (order by yearmonth)) * 100.0) / 
    (lag(tot_rev_per_mon) over (order by yearmonth)) as growth_pct
    from agg_tot_mon
)
select yearmonth,
tot_rev_per_mon,
lag(tot_rev_per_mon) over (order by yearmonth) as prev_rev,
concat(round(growth_pct,2),'%') as precent_inc
from growth_calc
where growth_pct > 10;



