# Netflix Data Analysis Project

![Netflix Logo](logo.png)

This project analyzes a Netflix dataset using SQL queries to answer various business-related questions and gain insights into the content available on Netflix. The dataset includes information about movies and TV shows, such as their genres, directors, release dates, and more.

## Dataset

The dataset used in this project can be downloaded from [Netflix Dataset Link](#https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download) (replace `#` with the link to your dataset). It includes various attributes about Netflix's content, such as `title`, `director`, `country`, `rating`, `duration`, and more.

## Project Overview

The project aims to answer 30 different business questions about Netflix content through SQL queries. These queries cover various aspects, including:

- **Content type distribution**: Understanding the balance of Movies vs. TV Shows
- **Director and actor analysis**: Finding the most frequent collaborators
- **Genre and rating insights**: Analyzing popular genres and ratings
- **Time-based analysis**: Content added over time and seasonal trends

Each query provides insights that are crucial for business intelligence and content strategy on streaming platforms like Netflix.

## Database Structure

The Netflix dataset is stored in a SQL table with the following schema:

| Column        | Data Type  | Description                                             |
|---------------|------------|---------------------------------------------------------|
| show_id       | VARCHAR(6) | Unique identifier for each show                          |
| type          | VARCHAR(10)| Type of the content (Movie or TV Show)                   |
| title         | VARCHAR(150)| Title of the show                                      |
| director      | VARCHAR(210)| Name of the director                                   |
| casts         | VARCHAR(1000)| Main actors in the content                           |
| country       | VARCHAR(150)| Country of origin                                      |
| date_added    | VARCHAR(50)| Date the show was added on Netflix                     |
| release_year  | INT        | Release year of the content                             |
| rating        | VARCHAR(10)| Audience rating (e.g., PG-13, TV-MA)                    |
| duration      | VARCHAR(15)| Duration for movies, seasons for TV shows               |
| listed_in     | VARCHAR(100)| Genres/categories                                      |
| description   | VARCHAR(250)| Brief description of the content                      |

## SQL Queries and Solutions

Below is a list of 30 business problems addressed through SQL queries:

1. **Count the number of Movies vs. TV Shows**  
2. **Find the most common rating for Movies and TV Shows**  
3. **List all Movies released in a specific year**  
4. **Find the top 5 countries with the most content on Netflix**  
5. **Identify the longest movie**  
6. **Find the content added in the last 5 years**  
7. **List all Movies/TV Shows by a specific director**  
8. **List all TV Shows with more than 5 Seasons**  
9. **Count the number of content items in each genre**  
10. **Find the top 5 years with the highest average content release from India**  
11. **List all movies that are documentaries**  
12. **Find all content without a director**  
13. **Find how many Movies an actor has appeared in the last 10 years**  
14. **Find the top 10 actors with the highest number of appearances in movies from India**  
15. **Categorize content based on keywords in the description**  
16. **Find the average release year for Movies and TV Shows**  
17. **Identify the top 5 directors with the most content**  
18. **List the top 3 countries with the highest number of TV Shows**  
19. **Find the number of content items added each year**  
20. **Calculate the percentage of content for each rating category**  
21. **List all unique genres available on Netflix**  
22. **Identify the longest movie by duration**  
23. **Find all content items released before the year 2000**  
24. **Count the number of TV Shows with more than 2 seasons**  
25. **Determine the most recent content added from each country**  
26. **Find the most frequent actor appearing in content**  
27. **List the 5 most popular genres among Movies**  
28. **Identify the TV Show with the highest average IMDb rating**  
29. **List all shows added in the last 6 months**  
30. **Find the average duration of Movies based on rating**

## Installation

1. **Set up a database**: Use PostgreSQL or another SQL database.
2. **Import the dataset**: Load the Netflix dataset into a table named `netflix`.
3. **Run the queries**: Execute the SQL queries to obtain insights.

## Sample Query

Here’s an example of a query that counts the number of Movies and TV Shows on Netflix:

```sql
SELECT 
    type,
    COUNT(*) AS total_content
FROM netflix
GROUP BY type;
```

This query groups content by type and counts the total items for each type.
