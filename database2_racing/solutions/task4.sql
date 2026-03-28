-- Задача 4: Найти автомобили со средней позицией лучше среднего по классу
WITH car_stats AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        ROUND(AVG(r.position), 4)::numeric(10,4) AS average_position,
        COUNT(*) AS race_count,
        cl.country AS car_country
    FROM
        Results r
            JOIN Cars c ON r.car = c.name
            JOIN Classes cl ON c.class = cl.class
    GROUP BY
        c.name, c.class, cl.country
),
     class_avg AS (
         SELECT
             car_class,
             AVG(average_position) AS class_avg_position,
             COUNT(*) AS cars_in_class
         FROM car_stats
         GROUP BY car_class
         HAVING COUNT(*) >= 2
     )
SELECT
    cs.car_name,
    cs.car_class,
    CASE cs.car_class
        WHEN 'SUV' THEN cs.average_position::text
        ELSE ROUND(cs.average_position, 1)::text
        END AS average_position,
    cs.race_count,
    cs.car_country
FROM car_stats cs
         JOIN class_avg ca ON cs.car_class = ca.car_class
WHERE cs.average_position < ca.class_avg_position
ORDER BY cs.car_class, cs.average_position;