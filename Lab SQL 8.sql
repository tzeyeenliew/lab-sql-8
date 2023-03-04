USE sakila;

###Instructions
### 1.Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT title, length, DENSE_RANK() OVER (ORDER BY length desc) AS "rank"
FROM film
WHERE length > 0;

### 2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
### In your output, only select the columns title, length, rating and rank.

SELECT title, `length`, rating, RANK() OVER (ORDER BY length DESC) AS "rank"
FROM film
WHERE`length` IS NOT NULL;

SELECT title, length, rating, 
       RANK() OVER(PARTITION BY rating ORDER BY length DESC) AS rank_num 
FROM film 
WHERE length IS NOT NULL
ORDER BY rating, rank_num;


### 3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

SELECT B.name, COUNT(A.film_id) AS totalfilms
FROM category AS B
INNER JOIN film_category AS A
ON B.category_id = A.category_id
GROUP BY B.name

ORDER BY COUNT(A.film_id) DESC;




### 4.Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.


SELECT A.actor_id, A.first_name, A.last_name, COUNT(FA.film_id) AS most_appeared_actor
FROM actor AS A JOIN film_actor AS FA ON A.actor_id = FA.actor_id
GROUP BY A.actor_id, A.first_name, A.last_name
ORDER BY most_appeared_actor DESC
LIMIT 1;



### 5.Which is the most active customer (the customer that has rented the most number of films)? 

SELECT C.customer_id, C.first_name, C.last_name, COUNT(R.rental_id) AS most_active_customer
FROM customer AS C JOIN rental AS R ON C.customer_id = R.customer_id
GROUP BY C.customer_id, C.first_name, C.last_name
ORDER BY most_active_customer DESC
LIMIT 1;
### Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
### Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).


###This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

### Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.
