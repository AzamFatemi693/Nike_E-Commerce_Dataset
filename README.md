
# Nike_E-Commerce_Dataset

The Nike E-Commerce Dataset provides valuable insights into Nike's e-commerce operations. It contains comprehensive information about orders, order items, products, and distribution centers involved in the company's online business. This repository serves as a centralized location for all the code and related materials pertaining to the Nike E-Commerce Dataset.

## Database Overview
The dataset is organized into several tables with relevant information. Here is an overview of the tables and their columns:

**Table: orders**  
order_id (text) (primary key): Unique identifier of the order. 
user_id (text): Unique identifier of the customer placing the order.
status (text): Current status of the order. 
gender (text): Gender of the customer placing the order. 
created_at (date): Date when the order was created. 
returned_at (date): Date when the order was returned (if applicable). 
shipped_at (date): Date when the order was shipped. 
delivered_at (date): Date when the order was delivered. 
num_of_item (integer): Number of products in the order.

**Table: order_items**  
order_item_id (text) (primary key): Unique identifier of the order item.
 order_id (text): Unique identifier of the order to which the item belongs. 
 user_id (text): Unique identifier of the customer who purchased the item. 
 product_id (text): Unique identifier of the product in the order item. 
 status (text): Current status of the order item.
 created_at (date): Date when the order item was created. 
 shipped_at (date): Date when the order item was shipped (if applicable). 
 delivered_at (date): Date when the order item was delivered. 
 returned_at (date): Date when the order item was returned (if applicable). 
 sale_price (float): The sales price of the product in the order item.

**Table: products**  
product_id (text) (primary key): Unique identifier of the product. 
cost (float): The cost price of the product. 
category (text): The category to which the product belongs. 
product_name (text): Name of the product. 
retail_price (text): Retail price of the product without any discount. 
sku (text): Stock keeping unit code for inventory management. 
distribution_center_id (text): Unique identifier of the distribution center associated with the product.

**Table: distribution_centers**  
distribution_center_id (text) (primary key): Unique identifier of the distribution 
center. name (text): Name of the distribution center.
latitude (float): Latitude of the distribution center's location. 
longitude (float): Longitude of the distribution center's location.

**Table: order_items_vintage**  
(Note: Records in this table are associated with a separate Nike business unit)

order_item_id (text) (primary key): Unique identifier of the order item.
order_id (text): Unique identifier of the order to which the item belongs. 
user_id (text): Unique identifier of the customer who purchased the item. 
product_id (text): Unique identifier of the product in the order item.
status (text): Current status of the order item. 
created_at (date): Date when the order item was created. 
shipped_at (date): Date when the order item was shipped (if applicable). 
delivered_at (date): Date when the order item was delivered. 
returned_at (date): Date when the order item was returned (if applicable). 
sale_price (float): The sales price of the product in the order item.

Please note that the dataset contains sensitive information and is intended for analytical purposes only.

Happy exploring! 🏃‍♂️🔍
