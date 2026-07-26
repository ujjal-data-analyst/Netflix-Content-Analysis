SELECT * FROM netflix;

-- Q1. WHAT IS THE DISTRIBUTION OF MOVIES AND TV SHOWS ON NETFLIX?

SELECT type, COUNT(*) AS total_content
FROM netflix
GROUP BY type;


-- Q2. WHICH COUNTRIES CONTRIBUTE THE MOST CONTENT TO NETFLIX?

SELECT country, COUNT(*) AS total_content
FROM netflix
GROUP BY country
ORDER BY total_content DESC
LIMIT 10;


-- Q3. WHAT ARE THE MOST COMMON CONTENT RATINGS ON NETFLIX?

SELECT rating, COUNT(*) AS total_content
FROM netflix
GROUP BY rating
ORDER BY total_content DESC;


-- Q4. HOW MANY TITLES WERE ADDED TO NETFLIX EACH YEAR?

SELECT 
	added_year,
	COUNT(*) AS total_titles
FROM netflix
GROUP BY added_year
ORDER BY added_year;

-- Q5. WHICH 10 DIRECTORS HAVE DIRECTED THE MOST NETFLIX TITLES?

SELECT 
	director,
	COUNT(*) AS total_titles
FROM netflix
WHERE director <> 'Unknown'
GROUP BY director
ORDER BY total_titles DESC LIMIT 10;


--Q6. WHICH COUNTRIES PRODUCE THE MOST MOVIES?

SELECT
	country,
	COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
GROUP BY country
ORDER BY total_movies DESC LIMIT 10;


-- Q7. WHICH COUNTRIES PRODUCE THE MOST TV SHOWS?

SELECT 
	country,
	COUNT(*) AS total_tv_shows
FROM netflix
WHERE type = 'TV Show'
GROUP BY country
ORDER BY total_tv_shows DESC LIMIT 10;


-- Q8. IN WHICH YEAR WAS THE HIGHTEST NUMBER OF TITILES ADDED?

SELECT 
	added_year,
	COUNT(*) AS total_titles
FROM netflix
GROUP BY added_year
ORDER BY total_titles DESC LIMIT 1;


-- Q9. WHAT PERCENTAGE OF NETFLIX CONTENT IS MOVIES VS TV SHOWS?

SELECT
	type,
	ROUND(
		COUNT(*) * 100.0/
		SUM(COUNT(*)) OVER (),
		2
	) AS percentage
FROM netflix
GROUP BY type;


-- Q10. WHAT ARE THE TOP 10 MOST RECENT RELEASE YEARS BY CONTENT VOLUME?

SELECT release_year,
		COUNT(*) AS total_titles
FROM netflix
GROUP BY release_year
ORDER BY total_titles DESC LIMIT 10;


-- Q11. HOW HAS NETFLIX CONTENT GROWN YEAR-OVER-YEAR?

SELECT 
	added_year,
	COUNT(*) AS total_titles,
	COUNT(*) -
	LAG(COUNT(*))
	OVER (ORDER BY added_year) AS growth
FROM netflix
GROUP BY added_year
ORDER BY added_year;


-- Q12. WHICH RATINGS CATEGORY DOMINATES MOVIES?

SELECT 
	rating,
	COUNT(*) AS total_movies
FROM netflix
WHERE type = 'Movie'
GROUP BY rating
ORDER BY total_movies DESC;


-- Q13. WHICH RATINGS CATEGORY DOMINATES TV SHOWS?

SELECT
	rating,
	COUNT(*) AS total_tv_shows
FROM netflix
WHERE type = 'TV Show'
GROUP BY rating
ORDER BY total_tv_shows DESC;


-- Q14. WHICH COUNTRIES HAVE BOTH STROMG MOVIES AND TV SHOW PRODUCTION?

ALTER TABLE netflix
RENAME COLUMN type TO content_type;

SELECT
    country,
    SUM(CASE WHEN content_type = 'Movie' THEN 1 ELSE 0 END) AS movies,
    SUM(CASE WHEN content_type = 'TV Show' THEN 1 ELSE 0 END) AS tvshows
FROM netflix
GROUP BY country
ORDER BY movies DESC;


-- Q15. WHAT IS THE AVERAGE RELEASE YEAR OF NETFLIX CONTENT?

SELECT 
	ROUND(AVG(release_year), 0)
	AS average_release_year
FROM netflix;


-- Q16. WHICH MONTH SEES THE HIGHEST NUMBER OF CONTENT ADDITION?

SELECT 
	added_month,
	COUNT(*) AS total_titles
FROM netflix
GROUP BY added_month
ORDER BY total_titles DESC;


--Q17. WHICH DAY OF THE WEEK HAS THE HIGHTEST CONTENT ADDITION?

SELECT
	added_day,
	COUNT(*) AS total_titles
FROM netflix
GROUP BY added_day
ORDER BY total_titles DESC;


--  Q18. WHICH COUNTRIES CONTRIBUTES MORE THAN 100 TITLES?

SELECT 
	country,
	COUNT(*)AS total_titles
FROM netflix
GROUP BY country
HAVING COUNT (*)>100
ORDER BY total_titles DESC;


-- Q19. RANK COUNTRIES BY TOTAL CONTENT PRODUCTION.

SELECT
	country,
	COUNT(*) AS total_titles,
	DENSE_RANK() OVER(
		ORDER BY COUNT(*) DESC
	) AS country_rank
FROM netflix
GROUP BY country;


-- Q20.WHICH DIRECTORS COSISTENTLY APPEAR IN THE TOP 10?

SELECT 
	director,
	COUNT(*) AS total_titles,
	DENSE_RANK() OVER(
		ORDER BY COUNT(*) DESC
	) AS director_rank
FROM netflix
WHERE director <> 'Unknown'
GROUP BY director
ORDER BY total_titles DESC LIMIT 10;
















