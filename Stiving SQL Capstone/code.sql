
1. How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?

SELECT COUNT(DISTINCT(utm_campaign))
FROM page_visits;

SELECT COUNT(DISTINCT(utm_source))
FROM page_visits;

SELECT COUNT(*), utm_source, utm_campaign
FROM page_visits
GROUP BY 2,3
ORDER BY 1 DESC;

2. What pages are on the CoolTShirts website?

SELECT DISTINCT(page_name)
FROM page_visits;

3.How many first touches is each campaign responsible for?

WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT COUNT(ft.first_touch_at) AS count,
    		pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC;

4.How many last touches is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT COUNT(lt.last_touch_at) AS count,
    		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY 2
ORDER BY 1 DESC;

5.How many visitors make a purchase?
SELECT COUNT(DISTINCT(user_id))as 'Users Making Purchase'
FROM page_visits
WHERE page_name = '4 - purchase';


6.How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT COUNT(lt.last_touch_at) AS count,
    		pv.utm_campaign
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name = '4 - purchase'
GROUP BY 2
ORDER BY 1 DESC;



