-- створити trigger на insert в базу даних з машинами який буде дублювати інформацію в нову таблицю DWH_cars


--Створення таблиці
create table DWH_Cars(
person text,
reg_addr_koatuu text,
oper_code text,
oper_name text,
date_registration text,
dep_code text,
dep text, 
brand text,
model text,
vin_code text,
make_year integer,
color text, 
kind text, 
body text,
purpose text,
fuel text,
capacity text,
own_weight text,
total_weight text,
registration_number text)


--Створення тригерної функції
create or replace function dublicate_insert()
returns trigger AS $$
begin
	insert into DWH_cars(person, reg_addr_koatuu, oper_code, oper_name, date_registration, dep_code, dep, brand, model, vin_code, make_year, color, kind, body, purpose, fuel, capacity, own_weight, total_weight, registration_number)
	values(new.person, new.reg_addr_koatuu, new.oper_code, new.oper_name, new.date_registration, new.dep_code, new.dep, new.brand, new.model, new.vin_code, new.make_year, new.color, new.kind, new.body, new.purpose, new.fuel, new.capacity, new.own_weight, new.total_weight, new.registration_number);
	return new;
end;
$$ LANGUAGE PLPGSQL

--Створення тригеру
create trigger dublication_insert_data_in_data_cars_temp
	after insert 
	on data_cars_temp
	for each row
	execute procedure dublicate_insert()


--Додавання нових даних в таблицю
insert into data_cars_temp(person, reg_addr_koatuu, oper_code, oper_name, date_registration, dep_code, dep, brand, model, vin_code, make_year, color, kind, body, purpose, fuel, capacity, own_weight, total_weight, registration_number)
values ('Maria', '69989438', '434', 'Видача тз', '21.09.2023', '1234567','ТСЦ 8046', 'Hundai', 'SONATA',  'jdfhj6jjr85574hfdn', '2020', 'ЧОРНИЙ', 'ЛЕГКОВИК', 'СЕДАН','ЗАГАЛЬНИЙ', 'БЕНЗИН', '5456', '5432', '5356', 'AA6643BB')
