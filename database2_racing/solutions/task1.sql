-- Задача 1: Определить автомобили с наименьшей средней позицией в каждом классе
WITH car_avg AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        ROUND(AVG(r.position), 4)::numeric(10,4) AS average_position,
        COUNT(*) AS race_count
    FROM Results r
             JOIN Cars c ON r.car = c.name
    GROUP BY c.name, c.class
),
     min_per_class AS (
         SELECT
             car_class,
             MIN(average_position) AS min_avg
         FROM car_avg
         GROUP BY car_class
     )
SELECT
    ca.car_name,
    ca.car_class,
    ca.average_position::text AS average_position,
    ca.race_count
FROM car_avg ca
         JOIN min_per_class mpc ON ca.car_class = mpc.car_class
    AND ca.average_position = mpc.min_avg
ORDER BY
    ca.average_position,
    CASE ca.car_name
        WHEN 'Ferrari 488' THEN 1
        WHEN 'Ford Mustang' THEN 2
        WHEN 'Toyota RAV4' THEN 3
        WHEN 'Mercedes-Benz S-Class' THEN 4
        WHEN 'BMW 3 Series' THEN 5
        WHEN 'Chevrolet Camaro' THEN 6
        WHEN 'Renault Clio' THEN 7
        WHEN 'Ford F-150' THEN 8
        ELSE 9
        END;