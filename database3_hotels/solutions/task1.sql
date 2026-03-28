-- Задача 1: Клиенты с более чем двумя бронированиями в разных отелях
WITH customer_stats AS (
    SELECT
        c.ID_customer,
        c.name,
        c.email,
        c.phone,
        COUNT(DISTINCT b.ID_booking) AS total_bookings,
        COUNT(DISTINCT h.ID_hotel) AS unique_hotels,
        AVG(b.check_out_date - b.check_in_date) AS avg_stay_days,
        STRING_AGG(DISTINCT h.name, ', ' ORDER BY h.name) AS hotels_list
    FROM Customer c
             JOIN Booking b ON c.ID_customer = b.ID_customer
             JOIN Room r ON b.ID_room = r.ID_room
             JOIN Hotel h ON r.ID_hotel = h.ID_hotel
    GROUP BY c.ID_customer, c.name, c.email, c.phone
)
SELECT
    name,
    email,
    phone,
    total_bookings,
    hotels_list,
    ROUND(avg_stay_days, 4)::text AS avg_stay_days
FROM customer_stats
WHERE total_bookings > 2 AND unique_hotels > 1
ORDER BY total_bookings DESC;