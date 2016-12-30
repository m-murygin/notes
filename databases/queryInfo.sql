-- Stored Procedure to get query info

DELIMITER //
CREATE PROCEDURE GetQueryInfo(IN queryId INT) BEGIN
SELECT STATE,
       SUM(DURATION) AS Total_R,
       ROUND(100 * SUM(DURATION) /
               (SELECT SUM(DURATION)
                FROM INFORMATION_SCHEMA.PROFILING
                WHERE QUERY_ID = queryId), 2) AS Pct_R,
       COUNT(*) AS Calls,
       SUM(DURATION) / COUNT(*) AS 'R/Call'
FROM INFORMATION_SCHEMA.PROFILING
WHERE QUERY_ID = queryId
GROUP BY STATE
ORDER BY Total_R DESC; END // DELIMITER ;