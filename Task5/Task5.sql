--У тебе є фабії різних кольорів, знайди у % кількість кольорів фабій. А-ля червоні фабії - 10%, зелені - 20%

-- функція що рахує кількість фабій по кольору
create or replace function count_color_of_fabia(color_fabia text)
returns numeric as $$
declare color_fabia_count numeric;
begin 
	select count(*) into color_fabia_count
	from data_cars_temp d
	where  d.model = 'FABIA' and d.color = color_fabia;
	return color_fabia_count;
end;
$$ LANGUAGE plpgsql;



-- Функція що рахує загальну кількість фабій
create or replace function count_number_of_fabia()
returns numeric as $$
declare precent_in_color numeric;
begin
	select count(*) into precent_in_color
	from data_cars_temp
	where model = 'FABIA' 
	and brand = 'SKODA' ;
	return precent_in_color;
end;
$$ LANGUAGE plpgsql;



-- Створення функції для підрахунку відсоткового відношення по кольору
create or replace function percentage_of_cars_by_color()
returns table (white_fabia numeric, bege_fabia numeric, yellow_fabia numeric, green_fabia numeric, broun_fabia numeric, orange_fabia numeric, gray_fabia numeric, blue_fabia numeric, red_fabia numeric, black_fabia numeric) as $$
declare precentage_cars_by_color numeric;
begin
	precentage_cars_by_color := count_number_of_fabia();
	return query
	select round((count_color_of_fabia('БІЛИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as white_fabia 
	,round((count_color_of_fabia('БЕЖЕВИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as beige_fabia
	,round((count_color_of_fabia('ЖОВТИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as yellow_fabia 
	,round((count_color_of_fabia('ЗЕЛЕНИЙ')* 1.0/precentage_cars_by_color)*100, 2) as green_fabia 
	,round((count_color_of_fabia('КОРИЧНЕВИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as broun_fabia 
	,round((count_color_of_fabia('ОРАНЖЕВИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as orange_fabia 
	,round((count_color_of_fabia('СІРИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as gray_fabia 
	,round((count_color_of_fabia('СИНІЙ')* 1.0/ precentage_cars_by_color)*100, 2) as blue_fabia 
	,round((count_color_of_fabia('ЧЕРВОНИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as red_fabia 
	,round((count_color_of_fabia('ЧОРНИЙ')* 1.0/ precentage_cars_by_color)*100, 2) as black_fabia
	;
end;
$$ LANGUAGE plpgsql;



--Виклик функціїї
select* from  percentage_of_cars_by_color()
