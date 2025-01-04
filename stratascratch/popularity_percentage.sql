-- https://platform.stratascratch.com/coding/10284-popularity-percentage?code_type=1

-- Find the popularity percentage for each user on Meta/Facebook. The dataset contains two columns, user1 and user2, which represent pairs of friends. Each row indicates a mutual friendship between user1 and user2, meaning both users are friends with each other. A user's popularity percentage is calculated as the total number of friends they have (counting connections from both user1 and user2 columns) divided by the total number of unique users on the platform. Multiply this value by 100 to express it as a percentage.

-- Output each user along with their calculated popularity percentage. The results should be ordered by user ID in ascending order.

-- Table: facebook_friends

-- user1:  bigint
-- user2:  bigint

WITH users AS (
    SELECT user1
    FROM facebook_friends
    
    UNION ALL
    
    SELECT user2
    FROM facebook_friends
), count_friends AS (
    SELECT COUNT(*) count_fr
    FROM facebook_friends
)

SELECT user1, qty_friends * 1.0 / (SELECT count_fr FROM count_friends) * 100 popularity_percent
FROM (SELECT user1, COUNT(user1) qty_friends FROM users GROUP BY user1 ORDER BY user1) usrs;