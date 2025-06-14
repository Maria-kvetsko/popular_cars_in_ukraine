--Завдання
--Знайти кількість червоних фабій по Україні
--Зробити функцію яка повертає кількість червоних фабій по обласі
--Зробити функцію яка повертає список червоних фабій по області


--Створення функції для хбереження даних ТСЦ в масив по областях
create or replace function dep_tsc_number(region_name varchar)
returns text[] AS $$
declare number_tsc_adres text[];
begin
	SELECT ARRAY(
        SELECT DISTINCT t.number_tsc
        FROM data_cars_temp d
        LEFT JOIN tsc_adres t ON d.dep = t.number_tsc
        WHERE t.number_tsc = ANY (
            CASE region_name
                WHEN 'Львівська' THEN ARRAY['ТСЦ 4641', 'ТСЦ 4642', 'ТСЦ 4643', 'ТСЦ 4644', 'ТСЦ 4645', 'ТСЦ 4646', 'ТСЦ 4647', 'ТСЦ 4648', 'ТСЦ 4649', 'ТСЦ 4650']
                WHEN 'Івано-Франківська' THEN ARRAY['ТСЦ 2641', 'ТСЦ 2642', 'ТСЦ 2643', 'ТСЦ 2644', 'ТСЦ 2645']
                WHEN 'Закарпатська' THEN ARRAY['ТСЦ 2141', 'ТСЦ 2642', 'ТСЦ 2142', 'ТСЦ 2143', 'ТСЦ 2144']
                ELSE ARRAY[]::text[]
            END
        )
    ) INTO number_tsc_adres;

    RETURN number_tsc_adres;
END;
$$ LANGUAGE plpgsql;



-- Створення функції яка повертає список всіх червоних фабій по обласі
CREATE OR REPLACE FUNCTION get_red_fabia_list_by_region(region_name varchar)
RETURNS table (model text, brand text, color text, adres text)  AS $$
BEGIN
	RETURN QUERY
    SELECT d.model, d.brand, d.color, t.adres
    FROM data_cars_temp d
    LEFT JOIN tsc_adres t ON d.dep = t.number_tsc
    WHERE d.brand = 'SKODA'
      AND d.model = 'FABIA'
      AND d.color = 'ЧЕРВОНИЙ'
      AND d.dep = ANY(dep_tsc_number(region_name));   
END;
$$ LANGUAGE plpgsql;



--Виклик функціїї що повертає список всіх червоних фабій по області
SELECT get_red_fabia_list_by_region('Львівська');



--Створення функції що повертає кількість червоних фабій по області числом
CREATE OR REPLACE FUNCTION get_count_red_fabia_by_region(region_name varchar)
RETURNS integer AS $$
DECLARE
    red_fabia_count integer;
BEGIN
    SELECT COUNT(*) INTO red_fabia_count
	from get_red_fabia_list_by_region(region_name);
	RETURN red_fabia_count;
END;
$$ LANGUAGE plpgsql;

--Виклик функціїї що повертає кількість червоних фабій по області числом
SELECT get_count_red_fabia_by_region('Львівська');

