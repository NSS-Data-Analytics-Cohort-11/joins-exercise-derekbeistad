SELECT *
FROM specs;

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT specs.film_title,
	specs.release_year,
	revenue.worldwide_gross
FROM revenue
INNER JOIN specs
ON revenue.movie_id = specs.movie_id
ORDER BY revenue.worldwide_gross
LIMIT 1;
-- 		A. "Semi-Tough"	1977	37187139

-- 2. What year has the highest average imdb rating?
SELECT specs.release_year,
	AVG(rating.imdb_rating) AS avg_rating
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
GROUP BY specs.release_year
ORDER BY avg_rating DESC;
-- 		A. 1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT specs.film_title,
	rating.imdb_rating,
	revenue.worldwide_gross,
	specs.mpaa_rating,
	distributors.company_name
FROM specs
INNER JOIN rating
ON specs.movie_id = rating.movie_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
INNER JOIN distributors
ON specs.domestic_distributor_id = distributors.distributor_id
WHERE specs.mpaa_rating ILIKE 'G'
ORDER BY revenue.worldwide_gross DESC;
-- 		A. Toy Story 4, Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT distributors.company_name,
	COUNT(specs.film_title) AS num_movies
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY distributors.company_name;

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT distributors.company_name,
	AVG(revenue.film_budget) AS avg_budget
FROM distributors
INNER JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
GROUP BY distributors.company_name
ORDER BY avg_budget DESC
LIMIT 5;


