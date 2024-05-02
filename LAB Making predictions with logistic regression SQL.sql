-- Lab | Making predictions with logistic regression
-- 1. Create a query or queries to extract the information you think may be relevant for building the prediction model. 
-- It should include some film features and some rental features.
USE sakila;
SELECT COUNT(i.film_id), f.rating, f.rental_rate, f.release_year, c.name 
FROM rental r 
INNER JOIN inventory i 
ON r.inventory_id=i.inventory_id
JOIN film f 
ON f.film_id=i.film_id
JOIN film_category fc
ON fc.film_id=f.film_id
JOIN category c 
ON c.category_id=fc.category_id
GROUP BY i.film_id, f.rating, f.rental_rate, f.release_year, c.name;

select * from rental;

-- Check si la pelicula se alquilo el mes pasado
SELECT i.film_id, r.rental_date 
FROM inventory i
LEFT JOIN rental r
ON i.inventory_id=r.inventory_id
;

SELECT 
    f.film_id, f.title,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM rental r
            JOIN inventory i ON r.inventory_id = i.inventory_id
            WHERE i.film_id = f.film_id
            AND YEAR(r.rental_date) = 2006
            AND MONTH(r.rental_date) = 2
        ) THEN TRUE
        ELSE FALSE
    END AS rented_in_feb_2006
FROM film f;
