-- Задача 3: Определить классы с наименьшей средней позицией
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
),
     class_avg AS (
         SELECT
             car_class,
             AVG(average_position) AS class_avg_position
         FROM car_avg
         GROUP BY car_class
     ),
     min_class_avg AS (
         SELECT MIN(class_avg_position) AS min_avg
         FROM class_avg
     )
SELECT
    ca.car_name,
    ca.car_class,
    ca.average_position::text AS average_position,
    ca.race_count,
    ca.car_country,
    (SELECT COUNT(*) FROM Results r2
                              JOIN Cars c2 ON r2.car = c2.name
     WHERE c2.class = ca.car_class) AS total_races
FROM car_avg ca
WHERE ca.car_class IN (
    SELECT car_class FROM class_avg
    WHERE class_avg_position = (SELECT min_avg FROM min_class_avg)
)
ORDER BY ca.car_name;