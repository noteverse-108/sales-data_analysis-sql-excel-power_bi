use sales_retail;
select * from customers_ex2;
select * from products;
select * from sales;
select * from stores;

delete from products
where category like '%/%';
delete from products
where category like '%-%';

CREATE TABLE `products` (
  `ProductKey` int DEFAULT NULL,
  `Product Name` text,
  `Brand` text,
  `Color` text,
  `Unit Cost USD` text,
  `Unit Price USD` text,
  `SubcategoryKey` int DEFAULT NULL,
  `Subcategory` text,
  `CategoryKey` int DEFAULT NULL,
  `Category` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


# determine the age of customer
select *, timestampdiff(year, Birthday_Date_clean,curdate()) as Age from customers_ex2;

#store established old or new
select *,if((timestampdiff(year,Open_Date_Clean,curdate())>12),'Old','New') as Open_day from stores;

# profit per product through sales table
select *,concat('$ ',CAST(`Unit Price USD` AS DECIMAL(10,2)) - CAST(`Unit Cost USD` AS DECIMAL(10,2))) as Profit  from products;

# sales each month and high performing sales
select monthname(Order_date_clean),count(*),round(sum(`Unit Price USD`),2) as sale_month from sales
join products p on sales.ProductKey=p.ProductKey
group by monthname(Order_date_clean)
order by sale_month desc;


# region that had highest sale
select ce.State,sum(quantity*cast(`Unit Price USD` as decimal(10,2))) as region_sales from sales
join customers_ex2 ce on sales.CustomerKey=ce.CustomerKey
join products on products.productkey=sales.ProductKey
group by ce.State
order by region_sales desc;

# identifying top selling product
select p.Category, sum(quantity*cast(`Unit Price USD` as decimal(10,2))) as category_sales from products p
join sales on sales.ProductKey=p.ProductKey
group by Category
order by category_sales desc;


# identfying top selling product in each cateory
select category,p.Subcategory,sum(quantity*cast(`Unit Price USD` as decimal(10,2))) as category_sales from products p
join sales on p.ProductKey=sales.ProductKey
group by category,p.SubCategory
order by category,category_sales desc;

# identified top 10% revenue contributors and bottom 20% 
# underperformers
with revenue_ranked as(
	select p.`Product Name`,
    p.Category,
    s.Country,
    sum(sl.quantity*(`Unit Price USD` )) as total_revenue,
    ntile(10) over (order by sum(sl.quantity*p.`Unit Price USD`) desc) as rev_decile,
    percent_rank() over (order by sum(sl.quantity*`Unit Price USD`)desc) as pct_rank
	from sales sl
    join products p on p.ProductKey=sl.ProductKey
    join stores s on s.storekey=sl.storekey
    group by p.`Product Name`,
    p.Category,
    s.Country
),
classified as(
select *,
	case 
		when rev_decile = 1 then'TOp 10%'
		when pct_rank>=0.80 then 'bottom 20%'
		else ' mid tier'
	end as performer_segment
from revenue_ranked
)
select * from classified
where performer_segment in ('TOp 10%','Bottom 20%')
order by total_revenue desc;
