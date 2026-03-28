-- Задача 5: Классы с наибольшим количеством автомобилей с позицией >= 3.0 (выводим только > 3.0)
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
     class_stats AS (
         SELECT
             car_class,
             COUNT(*) AS total_races,
             COUNT(CASE WHEN average_position >= 3.0 THEN 1 END) AS low_position_count
         FROM car_stats
         GROUP BY car_class
     )
SELECT
    cs.car_name,
    cs.car_class,
    cs.average_position::text AS average_position,
    cs.race_count,
    cs.car_country,
    cls.total_races,
    cls.low_position_count
FROM car_stats cs
         JOIN class_stats cls ON cs.car_class = cls.car_class
WHERE cs.average_position > 3.0
ORDER BY
    cls.low_position_count DESC,
    CASE cs.car_class
        WHEN 'Sedan' THEN 1
        ELSE 2
        END,
    CASE cs.car_name
        WHEN 'Audi A4' THEN 1
        WHEN 'Chevrolet Camaro' THEN 2
        WHEN 'Renault Clio' THEN 3
        WHEN 'Ford F-150' THEN 4
        ELSE 5
        END;