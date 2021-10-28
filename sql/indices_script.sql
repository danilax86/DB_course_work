-- Hash index для таблицы animals по атрибуту animals_sort_id
-- (позволит оптимизировать выборку конкретных животных по видам в функциях получения списка животных определенного вида)

create index animal_index_sort on animals using hash(animals_sort_id);

-- Hash index для таблицы animals_sort по атрибуту animals_type_id
-- (позволит оптимизировать выборку видов животных по типам в функциях получения списка животных определенного типа)

create index animal_index_type on animals_sort using hash(animals_type_id);

-- Hash index для таблицы plants по атрибуту plants_sort_id
-- (позволит оптимизировать выборку конкретных растений по видам в функциях получения списка растений определенного вида)

create index plant_index_sort on plants using hash(plants_sort_id);

-- Hash index для таблицы plants_sort по атрибуту plants_type_id
-- (позволит оптимизировать выборку видов растений по типам в функциях получения списка растений определенного типа)

create index plant_index_type on plants_sort using hash(plants_type_id);

-- B-Tree индекс для таблицы animals_location по атрибуту world_part_id
-- (позволит оптимизировать выборку видов животных по частям света в функциях получения списка видов животных из определённой части света)

create index animal_index_world_part on animals_location using btree(world_part_id);

-- B-Tree индекс для таблицы plants_location по атрибуту world_part_id
-- (позволит оптимизировать выборку видов растений по частям света в функциях получения списка видов растений из определённой части света)

create index plant_index_world_part on plants_location using btree(world_part_id);

