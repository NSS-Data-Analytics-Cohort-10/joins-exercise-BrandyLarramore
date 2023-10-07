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

SELECT d.company_name, COUNT()
FROM distributors AS d
INNER JOIN specs AS s
ON (s.domestic_distributor_id = d.distributor_id)
GROUP BY d.company_name, s.film_title

-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT d.company_name name, r.film_budget
FROM distributors AS d
INNER JOIN specs AS s
ON (s.domestic_distributor_id = d.distributor_id)
INNER JOIN revenue AS r
USING (movie_id)
GROUP BY d.company_name, r.film_budget

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

SELECT
FROM



For 7, the questions reads "-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?"
You will separate them as over 2 (121 mins and above.) hours, and 2 hours and under (120 and below).
