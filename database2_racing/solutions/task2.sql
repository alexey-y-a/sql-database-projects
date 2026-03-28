-- Задача 2: Определить автомобиль с наименьшей средней позицией среди всех
WITH car_avg AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        ROUND(AVG(r.position), 4)::numeric(10,4) AS average_position,
        COUNT(*) AS race_count,
        cl.country AS car_country
    FROM Results r
             JOIN Cars c ON r.car = c.name
             JOIN Classes cl ON c.class = cl.class
    GROUP BY c.name, c.class, cl.country
)
SELECT
    car_name,
    car_class,
    average_position::text AS average_position,
    race_count,
    car_country
FROM car_avg
WHERE average_position = (SELECT MIN(average_position) FROM car_avg)
ORDER BY car_name
    LIMIT 1;