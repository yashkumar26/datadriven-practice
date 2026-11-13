/*with cte1 as (select endpoint,count(*) as total_calls,sum(case when status >=400 and status<600 then 1 else 0 end) as error_calls from api_calls group by endpoint having count(*)>=20)
select endpoint,total_calls,error_calls,round((error_calls*100.0/total_calls),2) as error_rate from cte1 order by error_rate desc;
*/
SELECT
    endpoint,
    COUNT(*) AS total_calls,
    SUM(
        CASE
            WHEN status >= 400 AND status < 600 THEN 1
            ELSE 0
        END
    ) AS error_calls,
    ROUND(
        SUM(CASE WHEN status >= 400 AND status < 600 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS error_rate
FROM api_calls
GROUP BY endpoint
HAVING COUNT(*) >= 20
ORDER BY error_rate DESC;
