-- Netflix Project !

CREATE TABLE netflix
(
    show_id VARCHAR(6),
    type VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(210),
    casts VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(15),
    listed_in VARCHAR(100),
    description VARCHAR(250)
);

SELECT * FROM NETFLIX;


SELECT 
    COUNT(*) AS total_content
FROM netflix;


SELECT 
     DISTINCT type
FROM netflix;


-- 15 Business Problems!

1. Count the number of Movies vs TV Shows

SELECT 
     type,
	 COUNT(*) AS total_content
FROM netflix
GROUP BY type;


2. Find the most common rating for Movies and TV Shows.

SELECT
     type,
	 rating
FROM
(
SELECT 
     type,
     rating,
	 COUNT(*),
	 RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
FROM netflix
GROUP BY 1,2
) AS t1

WHERE ranking=1;


3. List all the Movies released in a specific year (eg. 2020)

SELECT 
     type,
	 title,
	 release_year
FROM netflix
WHERE type = 'Movie' AND release_year = '2020';


4. Find the Top 5 Countries with the most content on Netflix

SELECT
     UNNEST(STRING_TO_ARRAY(country, ',')) AS top_country,
	 COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


5. Identify the Longest Movie!

SELECT
     *
FROM netflix
WHERE type = 'Movie' AND duration = (SELECT MAX(duration) FROM netflix);


6. Find the content added in the last 5 years

SELECT * FROM netflix
WHERE
   TO_DATE(date_added, 'Month DD, YYYY') >=  CURRENT_DATE - INTERVAL '5 YEARS';


7. Find all the Movies/TV Shows by director 'Rajiv Chilaka' !

SELECT 
    * 
FROM netflix 
WHERE 
    director ILIKE '%rajiv Chilaka%';


8. List all the TV Shows with more than 5 Seasons!

SELECT 
    *
FROM netflix
WHERE 
    type = 'TV Show' 
	AND
    SPLIT_PART(duration, ' ', 1)::numeric > 5;


9. Count the number of content items in each genre!

SELECT
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
	COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1;


10. Find each year and the average numbers of content release by India on Netflix.
return top 5 year with highest avg content release !

SELECT
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD YYYY')) AS year,
	COUNT(*) AS yearly_content,
	COUNT(*)::NUMERIC/(SELECT COUNT(*) FROM netflix WHERE country = 'India') * 100 AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;


11. List all movies that are documentaries.

SELECT
    *
FROM netflix
WHERE 
    type = 'Movie'
	AND
	listed_in ILIKE '%documentaries%';


12. Find all content without director!

SELECT
    *
FROM netflix
WHERE 
    director IS NULL;


13. Find how many Movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE
   type = 'Movie'
   AND
   casts ILIKE '%salman khan%'
   AND
   release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
	UNNEST(STRING_TO_ARRAY(casts, ',')) AS actors,
	COUNT(*) AS total_content
FROM netflix
WHERE
    type = 'Movie'
	AND
	country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;


15. Categorize the content based on the presence of the keywords 'kill' and 'violence' 
in the description field. Label content containing these keywords as 'Bad' and all other
content as 'Good'. Count how many items fall into each category.

WITH new_table
AS
(
SELECT
    *,
	CASE
	WHEN
	   description ILIKE '%kill%'
	   OR
	   description ILIKE '%violence%' THEN 'Bad_Content'
	ELSE
	   'Good_Content'
	END category
FROM netflix
)
SELECT
    category,
	COUNT(*)
FROM new_table
GROUP BY 1;


16. Find the average release year for Movies and TV Shows!

SELECT type, AVG(release_year) AS avg_release_year
FROM netflix
GROUP BY type;


17. Identify the top 5 directors with the most content.

SELECT director, COUNT(*) AS total_content
FROM netflix
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_content DESC
LIMIT 5;


18. List the top 3 countries with the highest number of TV Shows

SELECT country, COUNT(*) AS total_tv_shows
FROM netflix
WHERE type = 'TV Show' AND country IS NOT NULL
GROUP BY country
ORDER BY total_tv_shows DESC
LIMIT 3;


19. Find the number of content items added each year.

SELECT YEAR(date_added) AS year, COUNT(*) AS total_content_added
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY year
ORDER BY year;


20. Calculate the percentage of content for each rating category.

SELECT
       rating, 
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix) AS percentage
FROM netflix
GROUP BY rating;


21. List all unique genres available on Netflix

SELECT
      DISTINCT TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre
FROM netflix;


22. Identify the longest movie by duration.

SELECT
     title,
	 duration
FROM netflix
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING(duration FROM '[0-9]+') AS INTEGER) DESC
LIMIT 1;


23. Find all content items released before the year 2000.

SELECT
     title,
	 release_year
FROM netflix
WHERE release_year < 2000;


24. Count the number of TV Shows with more than 2 seasons.

SELECT
     COUNT(*) AS total_tv_shows
FROM netflix
WHERE type = 'TV Show' AND CAST(SUBSTRING(duration FROM '[0-9]+') AS INTEGER) > 2;


25. Determine the most recent content added from each country.

SELECT 
     country,
	 MAX(date_added) AS latest_date
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY latest_date DESC;


26. Find the most frequent actor appearing in content.

SELECT 
     actor, 
	 COUNT(*) AS appearances
FROM (SELECT UNNEST(string_to_array(cast, ',')) AS actor FROM netflix) AS actor_list
GROUP BY actor
ORDER BY appearances DESC
LIMIT 1;


27. List the 5 most popular genres among Movies.

SELECT 
     genre,
	 COUNT(*) AS count
FROM (SELECT UNNEST(string_to_array(listed_in, ',')) AS genre FROM netflix WHERE type = 'Movie') AS genres
GROUP BY genre
ORDER BY count DESC
LIMIT 5;


28. Identify the TV Show with the highest average IMDb rating (requires IMDb rating)!

SELECT title, AVG(imdb_rating) AS avg_rating
FROM netflix
WHERE type = 'TV Show'
GROUP BY title
ORDER BY avg_rating DESC
LIMIT 1;


29. List all shows added in the last 6 months.

SELECT title, date_added
FROM netflix
WHERE date_added::DATE > (CURRENT_DATE - INTERVAL '6 MONTH');


30. Find the average duration of Movies based on rating.

SELECT rating, AVG(CAST(SUBSTRING(duration FROM '[0-9]+') AS INTEGER)) AS avg_duration
FROM netflix
WHERE type = 'Movie'
GROUP BY rating;
