-- Завдання
-- Знайти 5 найполярніших машин в україні за 1 половину 2025 року.
-- Знйти 3 найпопулярніших кольори у кожної з цих машин. 
-- Вивести кількість машин такого кольору



-- PostgreSQL query to find top 5 most popular cars and their top 3 colors

WITH top_cars AS (
    SELECT 
        brand,
        model,
        COUNT(*) as car_count
    FROM data_cars_temp
    GROUP BY brand, model
    ORDER BY car_count DESC
    LIMIT 5
),

-- Find the top 3 colors for each of these top 5 cars
car_colors AS (
    SELECT 
        vr.brand,
        vr.model,
        vr.color,
        COUNT(*) as color_count,
        ROW_NUMBER() OVER (PARTITION BY vr.brand, vr.model ORDER BY COUNT(*) DESC) as color_rank
    FROM data_cars_temp vr
    WHERE EXISTS (
        SELECT 1 FROM top_cars tc 
        WHERE tc.brand = vr.brand AND tc.model = vr.model
    )
    GROUP BY vr.brand, vr.model, vr.color
)

-- Final result: Top 5 cars with their counts and top 3 colors for each car
SELECT 
    tc.brand,
    tc.model,
    tc.car_count as total_cars,
    cc.color,
    cc.color_count,
    cc.color_rank
FROM top_cars tc
LEFT JOIN car_colors cc ON tc.brand = cc.brand AND tc.model = cc.model
WHERE cc.color_rank <= 3 OR cc.color_rank IS NULL
ORDER BY tc.car_count DESC, COALESCE(cc.color_rank, 999) ASC;