--Завдання
--Знайти кількість червоних фабій по Україні
--З тих червоних фабій знайти ті які зареєстровані у Львівській області
select brand, model, color, dep, adres from data_cars_temp
left join tsc_adres on data_cars_temp.dep = tsc_adres.number_tsc
where brand = 'SKODA' and model ='FABIA' and color='ЧЕРВОНИЙ' and adres  LIKE '%Львів%'

;

CREATE OR REPLACE FUNCTION get_red_fabia_in_region(region varchar) RETURN real 
	select brand, model, color, dep, adres from data_cars_temp
	left join tsc_adres on data_cars_temp.dep = tsc_adres.number_tsc
	where brand = 'SKODA' and model ='FABIA' and color='ЧЕРВОНИЙ' and adres  LIKE '%Львів%'
LANGUAGE SQL 
