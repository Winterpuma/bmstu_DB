-- БД ЛР5

-- 1) Извлечение данных с помощью функций создания JSON.
select to_json(people) from people;
select row_to_json(people) from people;

-- 2)Загрузка и сохранение JSON-документа
copy (select row_to_json(people) from people)
to 'D:\GitHub\bmstu_DB\lab_5\save.json';

create temp table ppl_import(doc json);
copy ppl_import from 'D:\GitHub\bmstu_DB\lab_5\load.json';

select p.*
from ppl_import, json_populate_record(null::people, doc) as p;

drop table ppl_import;