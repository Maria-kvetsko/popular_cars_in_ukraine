--Створити процедуру яка може трансформувати машину за вказаним номером у червону фабію!
create or replace procedure transform_to_red_fabia_in_number(numbe text)
language SQL
as $$

	update data_cars_temp set color = 'ЧЕРВОНИЙ', brand = 'SKODA', model = 'FABIA'
	where numbe = registration_number
		
$$

CALL transform_to_red_fabia_in_number('КА5010НС')

select brand, model, color, registration_number from data_cars_temp
where registration_number = 'КА5010НС'