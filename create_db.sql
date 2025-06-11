-- Завдання 
--Cтворити таблиці в які в подальшому можна буде підтягнути дані з файлу csv



--Створення таблиці для даних з ТСЦ про реєстрацію машин
CREATE TABLE data_cars_temp (
  person TEXT,
  reg_addr_koatuu TEXT,
  oper_code TEXT,
  oper_name TEXT,
  date_registration TEXT,
  dep_code TEXT,
  dep TEXT,
  brand TEXT,
  model TEXT,
  vin_code TEXT,
  make_year INTEGER,
  color TEXT,
  kind TEXT,
  body TEXT,
  purpose TEXT,
  fuel TEXT,
  capacity TEXT,
  own_weight TEXT,
  total_weight TEXT,
  registration_number TEXT
);

-- Створення таблиці для даних назв та адрес ТСЦ 
CREATE TABLE tsc_adres(
tsc text,
adres_tsc text
)
