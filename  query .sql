-- 1. Дослідження вкладених і повторюваних полів для одного користувача

SELECT
  user_pseudo_id,
  TIMESTAMP_MICROS(event_timestamp) AS event_datetime,
  event_name,
  event_params,
  user_properties,
  items
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
WHERE user_pseudo_id = '1044444.3778737727'
  AND EXISTS (
    SELECT 1
    FROM UNNEST(items) AS i
    WHERE i.item_name IS NOT NULL
      AND i.item_name != '(not set)'
  )
LIMIT 1;


-- 2. Перевірка розміру масивів у події

SELECT
  user_pseudo_id,
  TIMESTAMP_MICROS(event_timestamp) AS event_datetime,
  event_name,
  ARRAY_LENGTH(event_params) AS event_params_size,
  ARRAY_LENGTH(user_properties) AS user_properties_size,
  ARRAY_LENGTH(items) AS items_size
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
WHERE user_pseudo_id = '1044444.3778737727'
LIMIT 1;


-- 3. Розгортання event_params (key-value структура)

SELECT
  user_pseudo_id,
  event_name,
  ep.key,
  ep.value.string_value,
  ep.value.int_value,
  ep.value.double_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(event_params) AS ep
WHERE user_pseudo_id = '1044444.3778737727'
ORDER BY ep.key;


-- 4. Частота параметрів подій за 2021 рік

SELECT 
  ep.key,
  COUNT(*) AS frequency
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_2021*`,
UNNEST(event_params) AS ep
GROUP BY ep.key
ORDER BY frequency DESC;


-- 5. Розгортання масиву items (товари в подіях)

SELECT 
  user_pseudo_id,
  TIMESTAMP_MICROS(event_timestamp) AS event_datetime,
  i.item_id,
  i.item_name,
  i.item_category,
  i.price,
  i.quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(items) AS i;


-- 6. Агрегація по товарах (показники продажів)

SELECT
  i.item_name,
  COUNT(*) AS item_occurrences,
  SUM(i.quantity) AS total_quantity,
  SUM(i.price * i.quantity) AS total_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
UNNEST(items) AS i
GROUP BY i.item_name
ORDER BY total_revenue DESC;


-- 7. Фільтрація подій за категорією товару (Apparel)

SELECT 
  b.user_pseudo_id,
  i.item_category
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` b,
UNNEST(b.items) AS i
WHERE EXISTS (
  SELECT 1
  FROM UNNEST(b.items) AS i
  WHERE i.item_category = 'Apparel'
);


-- 8. Аналіз по партиціях (_TABLE_SUFFIX)

SELECT 
  event_date,
  COUNT(*) AS total_events,
  COUNT(DISTINCT user_pseudo_id) AS unique_users,
  COUNTIF(event_name = 'purchase') AS purchase_events
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20210101' AND '20210131'
GROUP BY event_date
ORDER BY event_date;


-- 9. Ранжування користувачів за витратами

WITH user_revenue AS (
  SELECT
    user_pseudo_id,
    SUM(i.price * i.quantity) AS total_spent
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS i
  GROUP BY user_pseudo_id
)

SELECT
  user_pseudo_id,
  total_spent,
  RANK() OVER (ORDER BY total_spent DESC) AS rank,
  DENSE_RANK() OVER (ORDER BY total_spent DESC) AS dense_rank,
  ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS row_number
FROM user_revenue
ORDER BY total_spent DESC
LIMIT 20;


-- 10. Аналіз початку сесій (session start events)

WITH base AS (
  SELECT
    event_name,
    TIMESTAMP_MICROS(event_timestamp) AS event_time,
    user_pseudo_id,
    (SELECT value.int_value 
     FROM UNNEST(event_params)
     WHERE key = 'ga_session_id') AS ga_session_id
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
),

numbered AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY user_pseudo_id, ga_session_id 
      ORDER BY event_time
    ) AS rn
  FROM base
)

SELECT
  event_name,
  COUNT(*) AS session_starts
FROM numbered
WHERE rn = 1
GROUP BY event_name
ORDER BY session_starts DESC
LIMIT 1;