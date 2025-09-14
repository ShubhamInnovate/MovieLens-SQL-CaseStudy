--Basic Queries:-

--Q1. How many movies are there in the dataset?
SELECT COUNT(*) AS Total_movies
FROM P2_Movie;



--Q2. How many total ratings are present?
SELECT COUNT(*) AS Total_Ratings
FROM P2_Rating;



--Q3. How many unique users have rated movies?
SELECT COUNT(DISTINCT User_ID) AS total_users
FROM P2_Rating;



--Q4. Show the first 10 movies.
SELECT TOP 10 *
FROM P2_Movie;



--Q5. What is the overall average rating?
SELECT ROUND(AVG(rating), 2) AS Avg_Rating
FROM P2_Rating;




--Intermediate Questions:-

--Q6. Which 10 movies received the most ratings?
SELECT m.title Movie_Title, COUNT(r.rating) AS Num_ratings
FROM P2_Rating r
JOIN P2_Movie m ON r.movie_Id = m.movie_Id
GROUP BY m.title
ORDER BY num_ratings DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;



--Q7. Which 10 movies have the highest average rating (with at least 1000 ratings)?
SELECT m.title Movie_Title, ROUND(AVG(r.rating), 2) AS Avg_Rating, COUNT(r.rating) AS Rating_Count
FROM P2_Rating r
JOIN P2_Movie m ON r.movie_Id = m.movie_Id
GROUP BY m.title
HAVING COUNT(r.rating) >= 1000
ORDER BY avg_rating DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;



--Q8. How many ratings has each user given?
SELECT User_Id, COUNT(*) AS Total_Ratings
FROM P2_Rating
GROUP BY user_Id
ORDER BY total_ratings DESC;



-- Q9. How many movies exist in each genre?
SELECT Genres, COUNT(*) AS Num_Movies
FROM P2_Movie
GROUP BY genres
ORDER BY num_movies DESC;




--New Q10. Which movies have the longest titles?
SELECT TOP 10 Title, LEN(title) AS title_length
FROM P2_Movie
ORDER BY title_length DESC;




--Advanced Questions:-


-- Q11. Which 10 movies received the highest number of ratings?
SELECT TOP 10 m.title as Movie_Title,m.genres as Genre,
       COUNT(r.rating) AS Total_Ratings
FROM P2_Movie m
JOIN P2_Rating r ON m.movie_Id = r.movie_Id
GROUP BY m.title, m.genres
ORDER BY total_ratings DESC;



--Q12. What is the distribution of ratings (1–5) in terms of both count and percentage of total ratings?
SELECT Rating,
       COUNT(*) AS Count_Ratings,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM P2_Rating), 2) AS Percentage
FROM P2_Rating
GROUP BY rating
ORDER BY rating;



-- Q13. Show all movies that belong to either Comedy or Action genre.
SELECT Title, 'Comedy' AS Genre
FROM P2_Movie
WHERE genres LIKE '%Comedy%'

UNION

SELECT Title, 'Action' AS Genre
FROM P2_Movie
WHERE genres LIKE '%Action%';



--Q14. Which movies are most controversial (highest variance in ratings, min 500 ratings)?
SELECT m.title Movie_Title, VAR(r.rating) AS Rating_variance, COUNT(r.rating) AS Num_Ratings
FROM P2_Rating r
JOIN P2_Movie m ON r.movie_Id = m.movie_Id
GROUP BY m.title
HAVING COUNT(r.rating) >= 500
ORDER BY rating_variance DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


--Q15. How many movies are missing IMDB IDs in Links?
SELECT COUNT(*) AS Missing_IMDB
FROM P2_Link
WHERE IMDB_Id IS NULL;



--Q16. Show movies that are either highly rated (avg ≥ 4.5) or very popular (≥ 5000 ratings) using
-- Highly Rated Movies
SELECT Title, 'High Rating' AS Category
FROM P2_Movie m
JOIN P2_Rating r ON m.movie_Id = r.movie_Id
GROUP BY title
HAVING AVG(r.rating) >= 4.5

UNION

-- Very Popular Movies
SELECT title, 'Popular' AS category
FROM P2_Movie m
JOIN P2_Rating r ON m.movie_Id = r.movie_Id
GROUP BY title
HAVING COUNT(r.rating) >= 5000;




--Q17. Top 5 users who gave the highest average rating (min 20 ratings)
SELECT TOP 5 r.User_Id,
       ROUND(AVG(r.rating),2) AS Avg_Rating,
       COUNT(r.rating) AS Num_Ratings
FROM P2_Rating r
GROUP BY r.user_Id
HAVING COUNT(r.rating) >= 20
ORDER BY avg_rating DESC;



