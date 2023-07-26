# 1. Create a list that includes the order ID, order item ID, product name, and sales price for the Nike Official order items in a single view.

select order_id, order_item_id, product_name, sale_price
from order_items oi
join products p
	using(product_id)


# 2. What are the products that are distributed from Los Angeles? Include the product ID and product name in your result.

select product_id, product_name 
from products p
join distribution_centers dc
	on p.distribution_center_id = dc.distribution_center_id
where dc.name= 'Los Angeles CA'


# 3. How many unique order items per status from Nike Official are either returned or canceled?

select count(distinct order_item_id), status
from order_items
join orders 
	using(order_id)
where status in ('Returned','Cancelled')
group by status


# 4. Calculate how many order items of Nike Official are associated with each product. Are there any products that never have been sold yet?

select count(distinct order_item_id) as num_order_items, product_name
from products p
left join order_items oi
	using(product_id)
group by product_name


# 5. Select all the unique product IDs available between the Nike Official order items and the Nike Vintage order items

select product_id
from order_items
union distinct
select product_id
from order_items_vintage


# 6. Create a list of all the Nike Official order items where a discount (retail price - sales price) has been given. Order the table by showing the largest discounts first. Include the order item ID, product name, retail price, sales price, and discount given

select order_item_id, product_name, retail_price, sale_price, retail_price-sale_price as discount
from order_items
join products
	using(product_id)
where retail_price-sale_price > 0
order by discount desc


# 7. Create a summary of how many Nike Official order items have or have no discount applied for each product. Order the result per product name. What products are discounted more than others?

select product_name, 
	case when (retail_price-sale_price) > 0 then 'discount'
	else 'no discount'
	end discount_applied,
  count(order_item_id) as num_order_item
from order_items
join products
	using(product_id)
group by product_name, discount_applied
order by product_name


# 8. Assume that all Nike Official products sold would have been sold at retail value and compare that against the actual sales price.  What is the total revenue that has been missed out on due to the discounts that have been given?

select sum(retail_price - sale_price) as missed_revenue
from order_items
join products
	using(product_id)


# 9. What is the number of order items sold by each business unit (Nike Official and Nike Vintage)?

select count(oi.order_item_id) as Nike_offocial, count(oiv.order_item_id) as Nike_vintage
from order_items oi
full join order_items_vintage oiv
	using(order_item_id)


# or 


select count(oi.order_item_id) as Nike_offocial
from order_items oi
union
select count(oiv.order_item_id) as Nike_vintage
from order_items_vintage oiv


# 10. How many order items are sold with a discount by each business unit (Nike Official and Nike Vintage)? What is the total revenue generated from these items?

select 'Nike Official' as business_unit,
	count(distinct order_item_id) as num_item_official,
  sum(sale_price) revenue_official
from order_items
join products
	using(product_id)
where retail_price - sale_price > 0
union all
select 'Nike Vintage' as business_unit,
	count(distinct order_item_id) as num_item_vintage,
  sum(sale_price) as revenue_vintage
from order_items_vintage


# 11. For order items sold with a discount, what is the average discount given in $ for each product and for each business unit (Nike Official and Nike Vintage)?

select 'Nike Official' as business_unit,
	product_name, avg(retail_price - sale_price) avg_discount
from order_items
join products
	using (product_id)
where retail_price - sale_price > 0
group by product_name

union all

select 'Nike Vintage' as business_unit,
	product_name, avg(retail_price - sale_price) as avg_discount
from order_items_vintage
join products
	using (product_id)
where retail_price - sale_price > 0
group by product_name


# 12. For Nike Vintage, calculate the average profit in $ generated per each of the vintage products.

select product_name, avg(sale_price - cost)
from order_items_vintage
join products
	using(product_id)
group by product_name


# 13. What product name generated the highest cumulative profit in $ for Nike Vintage in the calendar year 2022 (based on the order created date)?

select product_name, 
	sum(sale_price - cost) as profit
from order_items_vintage  
join products
	using(product_id)
where created_at between '2022-01-01' and '2022-12-31'
group by product_name
order by profit desc
limit 1


# 14. How many order items of both business units (Nike Official and Nike Vintage) have been returned or canceled, and what is the total sales price in $ that has been impacted by it?

select 'Nike official' as business_unit,
	count(distinct order_item_id),
  sum(sale_price)
from order_items
join orders
	using(order_id)
where status in ('Returned' , 'Cancelled')
  
 union all
 
 select 'Nike Vintage' as business_unit,
 	count(distinct order_item_id),
  sum(sale_price)
 from order_items_vintage
 join orders
 		using(order_id)
  where status in ('Returned' , 'Cancelled')

	
# 15. If we exclude the discounts that have been given, the expected profit margin for each product is calculated by: (retail price - cost) / retail price. 
Create a column that flags products with a name that includes “Vintage” as products from Nike Vintage and Nike Official otherwise. 
Calculate the expected profit margins for each product name and include the group that splits products between Nike Official and Nike Vintage in the result.

select 'Nike Official' as business_unit,
	product_name,	
  (retail_price - cost) / retail_price as profit_margin
from order_items
join products
	using (product_id)
group by product_name,retail_price,cost
union all
select 'Nike Vintage' as business_unit,
	product_name,
  (retail_price - cost) / retail_price as profit_margin
from order_items_vintage
join products
	using(product_id)
where product_name like '%Vintage%'
group by product_name,retail_price,cost

# or 

SELECT CASE WHEN product_name LIKE '%Vintage%' THEN 'Nike Vintage'
	ELSE 'Nike Official'
       END AS business_unit,
 	product_name,
	(retail_price-cost) / retail_price AS profit_margin
From products


# 16. What is the profit margin for each distribution center? Are there any centers that stand out?

select name, (sum(retail_price) - sum(cost)) /sum(retail_price) as profit_margin
from products
join distribution_centers
	using(distribution_center_id)
group by name


# 17. The real profit margin per order item is calculated by: (sales price - cost) / sales price. By summing up all the order items, we will find the real profit margin generated by the products. 
Calculate the profit margin for the Nike Official products: Nike Pro Tights, Nike Dri-FIT Shorts, and Nike Legend Tee.

select product_name, (sum(sale_price) - sum(cost))/sum(sale_price) as real_profit_margin
from order_items
join products
	using(product_id)
where product_name in ('Nike Pro Tights', 'Nike Dri-FIT Shorts', 'Nike Legend Tee')
group by product_name


# 18. Calculate the real profit margin by product and split the data using the created date before 2021-05-01 and post 2021-05-01 for Nike Official order items.

select product_name, 
	case when created_at < '2021-05-01' then 'pre_may' 
  else 'post_may'
  end as May21_split,
	(sum(sale_price) - sum(cost))/sum(sale_price) as real_profit_margin
from order_items
join products
	using(product_id)
group by product_name, May21_split


# 19. Calculate the profit margin by product for both Nike Official and Nike Vintage products in a single view.

select product_name,
	(sum(sale_price) - sum(cost)) /sum(sale_price) as profit_margin
from order_items
join products
	using(product_id)
group by product_name
union all
select product_name,
	(sum(sale_price) - sum(cost)) /sum(sale_price) as profit_margin
from order_items_vintage
join products
	using(product_id)
group by product_name


# 20. What are the top 10 products by profit margin from Nike Official and Nike Vintage? Include the product name, profit margin, and what business unit (Nike Official or Nike Vintage) sells the product.

with new_table as (select 'Nike Official' as business_unit,
	product_name,
	(sum(sale_price) - sum(cost)) /sum(sale_price) as profit_margin
from order_items
join products
	using(product_id)
group by product_name
union all
select 'Nike Vintage' as business_unit,
	product_name,
	(sum(sale_price) - sum(cost)) /sum(sale_price) as profit_margin
from order_items_vintage
join products
	using(product_id)
group by product_name)
select business_unit, product_name, profit_margin
from new_table
order by profit_margin desc 
limit 10




