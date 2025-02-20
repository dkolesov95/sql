-- https://datalemur.com/questions/total-utilization-time


-- Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage.

-- Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.


-- server_utilization Table

-- server_id	    integer
-- status_time	    timestamp
-- session_status	string


SELECT ROUND(SUM(total_time) / (60*60*24)) total_uptime_days
FROM (SELECT * 
        , EXTRACT(EPOCH FROM (status_time - LAG(status_time) 
                    OVER(PARTITION BY server_id ORDER BY status_time))) total_time
      FROM server_utilization) t
WHERE session_status = 'stop';