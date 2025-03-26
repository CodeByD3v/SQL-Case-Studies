# Swiggy-Case-Study
Platinum Customer Restaurant & Loyalty Analysis (SQL Query) 🚀
Overview
This SQL query analyzes Platinum customers' ordering behavior, identifying:
✅ The most preferred restaurants among high-value customers.
✅ The most popular cuisine types based on order frequency.
✅ The most loyal customers who repeatedly order from the same restaurants.

Breakdown of the Query
1️⃣ PLATINUM_CUSTOMERS CTE

Filters customers with a Platinum membership.

Counts how many times each Platinum customer ordered from different restaurants.

2️⃣ TOP_RESTAURANTS CTE

Aggregates total orders per restaurant from Platinum customers.

Selects Top 5 restaurants with the highest number of orders.

3️⃣ LOYAL_CUSTOMERS CTE

Identifies repeat customers who ordered from the same restaurant multiple times.

Counts how many times each customer ordered from a given restaurant.

4️⃣ Final Query

Joins Top Restaurants with Loyal Customers on restaurant_id.

Displays:

Most ordered restaurants

Their cuisine type & location

Total orders from Platinum customers

Loyal customers & their repeated orders

Use Case & Insights
📌 Helps food delivery platforms like Swiggy or Zomato identify top-performing restaurants.
📌 Assists in creating targeted promotions & loyalty programs for repeat customers.
📌 Supports restaurant partnerships & location-based strategies for better customer engagement.
