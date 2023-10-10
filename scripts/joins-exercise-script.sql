-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT s.film_title, s.release_year, r.worldwide_gross
FROM specs AS s
INNER JOIN revenue AS r
USING (movie_id)
ORDER BY r.worldwide_gross

-- 1A. Semi-Tough, 1977, 37,187,139



-- 2. What year has the highest average imdb rating?

SELECT s.film_title, s.release_year, r.imdb_rating
FROM specs AS s
LEFT JOIN rating AS r
USING (movie_id)
ORDER BY imdb_rating DESC

-- 2A. 2008


-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT s.film_title, s.mpaa_rating, r.worldwide_gross
FROM specs AS s
INNER JOIN revenue as r
USING (movie_id)
WHERE s.mpaa_rating = 'G'
ORDER BY r.worldwide_gross DESC

-- 3A1. Toy Story 4

SELECT s.film_title, d.company_name
FROM specs AS s
INNER JOIN distributors AS d
ON (s.domestic_distributor_id = d.distributor_id)
WHERE s.film_title = 'Toy Story 4'

-- 3A2. Walt Disney


-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT d.company_name, COUNT(distributor_id) AS movies_count
FROM distributors AS d
LEFT JOIN specs AS s
ON (s.domestic_distributor_id = d.distributor_id)
GROUP BY d.company_name
ORDER BY movies_count DESC;

-- Double checking I have all distributors (23)
SELECT DISTINCT company_name
FROM distributors


-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT d.company_name AS name, AVG(r.film_budget) AS avg_budget
FROM distributors AS d
INNER JOIN specs AS s
ON (s.domestic_distributor_id = d.distributor_id)
INNER JOIN revenue AS r
USING (movie_id)
GROUP BY d.company_name
ORDER BY avg_budget DESC
LIMIT 5;



-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT d.headquarters, s.film_title, MAX(r.imdb_rating) AS highest_imdb_rating
FROM distributors AS d
JOIN specs AS s
ON (s.domestic_distributor_id = d.distributor_id)
INNER JOIN rating AS r
USING (movie_id)
WHERE d.headquarters NOT LIKE '%CA%'
GROUP BY d.headquarters, s.film_title
ORDER BY highest_imdb_rating DESC
LIMIT 1;

-- 6A. 2, Dirty Dancing

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT AVG(imdb_rating) AS avg_rating, length_in_min
FROM specs AS s
FULL JOIN rating as r
USING (movie_id)
WHERE length_in_min > 120
GROUP BY length_in_min


(SELECT AVG(imdb_rating) AS avg_rating, length_in_min
FROM specs AS s
FULL JOIN rating as r
USING (movie_id)
WHERE length_in_min <= 120
GROUP BY length_in_min)


SELECT
  CASE
    WHEN length_in_min > 120 THEN 'Greater than 120 minutes'
    WHEN length_in_min <= 120 THEN '120 minutes or less'
  END AS length_category,
  AVG(imdb_rating) AS avg_rating
FROM specs AS s
LEFT JOIN rating AS r USING (movie_id)
GROUP BY length_category
ORDER BY length_category;

--Greater than 120 minutes