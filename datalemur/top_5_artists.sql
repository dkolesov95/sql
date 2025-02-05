-- https://datalemur.com/questions/top-fans-rank

-- Assume there are three Spotify tables: artists, songs, and global_song_rank, which contain information about the artists, songs, and music charts, respectively.

-- Write a query to find the top 5 artists whose songs appear most frequently in the Top 10 of the global_song_rank table. Display the top 5 artist names in ascending order, along with their song appearance ranking.


-- artists Table:

-- artist_id	integer
-- artist_name	varchar
-- label_owner	varchar


-- songs Table:

-- song_id	    integer
-- artist_id	integer
-- name	    varchar


-- global_song_rank Table:

-- day	        integer
-- song_id	    integer
-- rank	    integer


WITH top10 AS (
  SELECT 
    song_id
    , count(*) top10_count
  FROM global_song_rank 
  WHERE rank <= 10
  GROUP BY song_id
), top10_join AS (
  SELECT 
    artist_id
    , SUM(top10_count) sum_top10
  FROM songs s
    JOIN top10 t
    ON s.song_id = t.song_id
  GROUP BY artist_id
)

SELECT 
    artist_name
    , artist_rank
FROM (
  SELECT *
    , DENSE_RANK() OVER(ORDER BY sum_top10 DESC) artist_rank
  FROM artists a
    JOIN top10_join j
    ON a.artist_id = j.artist_id
) t
WHERE artist_rank <= 5
ORDER BY 
    artist_rank
    , artist_name ASC;
