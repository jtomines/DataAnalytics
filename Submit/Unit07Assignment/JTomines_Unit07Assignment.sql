/*  Unit 07 Assignment:  Sakila
	Author:   Jose Tomines
    Date:     2018-12-12
    Comment:  The following are the queries for the homework assignment
*/

-- 1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name
  FROM sakila.actor;
  

-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT CONCAT(first_name, ' ', last_name)
    AS 'Actor Name'
  FROM sakila.actor;


-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id,
       first_name,
       last_name
  FROM sakila.actor
 WHERE first_name = 'Joe';


-- 2b. Find all actors whose last name contain the letters `GEN`:
SELECT *
  FROM sakila.actor
 WHERE last_name
  LIKE '%GEN%';

-- 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:
  SELECT *
    FROM sakila.actor
   WHERE last_name
    LIKE '%LI%'
ORDER BY last_name,
		 first_name;


-- 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,
       country
  FROM sakila.country
 WHERE country
    IN ('Afghanistan',
       'Bangladesh',
       'China');
      

/* 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description,
   so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`,
   as the difference between it and `VARCHAR` are significant). */
ALTER TABLE sakila.actor
  ADD description BLOB;


-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE sakila.actor
DROP COLUMN description;
  
  
-- 4a. List the last names of actors, as well as how many actors have that last name.
  SELECT last_name,
         COUNT(*) AS 'num'
    FROM sakila.actor
GROUP BY last_name;


-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
  SELECT DISTINCT last_name,
         COUNT(*) AS 'num'
    FROM sakila.actor
GROUP BY last_name
  HAVING COUNT(*) > 1;


-- 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE sakila.actor
   SET first_name = 'HARPO'
 WHERE (first_name, last_name) = ('GROUCHO', 'WILLIAMS');


-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query,
-- if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE sakila.actor
   SET first_name = 'GROUCHO'
 WHERE first_name = 'HARPO';


-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
-- * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)
SHOW CREATE TABLE sakila.address;


-- 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
   SELECT staff.first_name,
		  staff.last_name,
          address.address
     FROM sakila.staff
LEFT JOIN sakila.address
       ON staff.address_id = address.address_id;


-- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
   SELECT staff.staff_id,
		  staff.first_name,
          staff.last_name,
          SUM(payment.amount) AS "Total Amount Rung Up"
     FROM sakila.staff
LEFT JOIN sakila.payment
       ON staff.staff_id = payment.staff_id
    WHERE payment.payment_date >= '2005-08-01' AND
          payment.payment_date < '2005-09-01'
 GROUP BY staff.staff_id
 ORDER BY staff.staff_id;
  

-- 6c. List each film and the number of actors who are listed for that film.
-- Use tables `film_actor` and `film`. Use inner join.
    SELECT film.film_id,
           film.title,
  		   COUNT(film_actor.actor_id) AS "Number of Actors"
      FROM sakila.film
INNER JOIN sakila.film_actor
        ON film.film_id = film_actor.film_id
  GROUP BY film.film_id
  ORDER BY film.title;


-- 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
    SELECT film.film_id,
           film.title,
  		   COUNT(inventory.inventory_id) AS "Number of Copies"
      FROM sakila.film
INNER JOIN sakila.inventory
        ON film.film_id = inventory.film_id
	 WHERE film.title = 'Hunchback Impossible'
  GROUP BY film.film_id;


/* 6e. Using the tables `payment` and `customer` and the `JOIN` command,
   list the total paid by each customer. List the customers alphabetically by last name
   ![Total amount paid](Images/total_payment.png) */
   SELECT customer.first_name,
          customer.last_name,
		  SUM(payment.amount) AS "Total Amount Paid"
     FROM sakila.customer
LEFT JOIN sakila.payment
       ON customer.customer_id = payment.customer_id
 GROUP BY customer.first_name,
          customer.last_name
 ORDER BY customer.last_name,
          customer.first_name;   


/* 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
   As an unintended consequence, films starting with the letters `K` and `Q` have also soared
   in popularity. Use subqueries to display the titles of movies starting with the
   letters `K` and `Q` whose language is English. */
SELECT film.title
  FROM sakila.film
 WHERE (film.title LIKE "K%"
    OR film.title LIKE "Q%")
   AND film.language_id IN (
	   SELECT language.language_id
         FROM sakila.language
		WHERE language.name = 'English');
             
             
-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
  SELECT actor.first_name,
         actor.last_name
    FROM sakila.actor
   WHERE actor.actor_id IN (
		 SELECT film_actor.actor_id
           FROM sakila.film_actor
		  WHERE film_actor.film_id IN (
				SELECT film.film_id
                  FROM sakila.film
			     WHERE film.title = 'Alone Trip'))
ORDER BY actor.last_name,
         actor.first_name;


-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
    SELECT customer.first_name,
           customer.last_name,
           customer.email
      FROM sakila.customer
INNER JOIN sakila.address
        ON customer.address_id = address.address_id
	       INNER JOIN sakila.city
                   ON address.city_id = city.city_id
                      INNER JOIN sakila.country
							  ON city.country_id = country.country_id
						   WHERE country.country = 'Canada'
  ORDER BY customer.last_name,
           customer.first_name;


-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films
    SELECT film.title
      FROM sakila.film
INNER JOIN sakila.film_category
        ON film.film_id = film_category.film_id
           INNER JOIN sakila.category
                   ON film_category.category_id = category.category_id
				WHERE category.name = 'Family';
      

-- 7e. Display the most frequently rented movies in descending order.
    SELECT film.title,
           COUNT(rental.rental_id) AS 'Total Rental'
      FROM sakila.film
INNER JOIN sakila.inventory
		ON film.film_id = inventory.film_id
		   INNER JOIN sakila.rental
                   ON inventory.inventory_id = rental.inventory_id
  GROUP BY film.title
  ORDER BY COUNT(rental.rental_id) DESC,
           film.title;
                

-- 7f. Write a query to display how much business, in dollars, each store brought in.
    SELECT store.store_id,
		   SUM(payment.amount) AS 'Gross Revenue'
      FROM sakila.store
INNER JOIN sakila.inventory
        ON store.store_id = inventory.store_id
		   INNER JOIN sakila.rental
                   ON inventory.inventory_id = rental.inventory_id
                      INNER JOIN sakila.payment
					          ON rental.rental_id = payment.rental_id
  GROUP BY store.store_id
  ORDER BY store.store_id;

                              
-- 7g. Write a query to display for each store its store ID, city, and country.
    SELECT store.store_id,
		   city.city,
           country.country
      FROM sakila.store
INNER JOIN sakila.address
        ON store.address_id = address.address_id
		   INNER JOIN sakila.city
                   ON address.city_id = city.city_id
                      INNER JOIN sakila.country
					          ON city.country_id = country.country_id
  ORDER BY store.store_id;



-- 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
    SELECT category.name,
           SUM(payment.amount) AS 'Gross Revenue'
	  FROM sakila.category
INNER JOIN sakila.film_category
        ON category.category_id = film_category.category_id
           INNER JOIN sakila.inventory
			       ON film_category.film_id = inventory.film_id
                      INNER JOIN sakila.rental
                              ON inventory.inventory_id = rental.inventory_id
                                 INNER JOIN sakila.payment
                                         ON rental.rental_id = payment.rental_id
  GROUP BY category.name
  ORDER BY SUM(payment.amount) DESC,
		   category.name
     LIMIT 5;
           
    

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view.
--  If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW sakila.top_5_revenue_vw AS
     SELECT category.name,
            SUM(payment.amount) AS 'Gross Revenue'
	   FROM sakila.category
 INNER JOIN sakila.film_category
         ON category.category_id = film_category.category_id
            INNER JOIN sakila.inventory
			        ON film_category.film_id = inventory.film_id
                       INNER JOIN sakila.rental
                               ON inventory.inventory_id = rental.inventory_id
                                  INNER JOIN sakila.payment
                                          ON rental.rental_id = payment.rental_id
   GROUP BY category.name
   ORDER BY SUM(payment.amount) DESC,
		    category.name
      LIMIT 5;


-- 8b. How would you display the view that you created in 8a?
SELECT *
  FROM sakila.top_5_revenue_vw;


-- 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW sakila.top_5_revenue_vw;

