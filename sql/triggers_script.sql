create or replace function validate_animal_location()
    returns trigger as
$$
declare
    -- Получаем координаты части света, в которой находится животное
    location_x1 integer := (select x1
        from world_part
        inner join animals_location on world_part.world_part_id = animals_location.world_part_id
        inner join animals on animals.animals_sort_id = animals_location.animals_sort_id
    where animals.animals_id = new.animals_id);
    location_x2 integer := (select x2
        from world_part
        inner join animals_location on world_part.world_part_id = animals_location.world_part_id
        inner join animals on animals.animals_sort_id = animals_location.animals_sort_id
    where animals.animals_id = new.animals_id);
    location_y1 integer := (select y1
        from world_part
        inner join animals_location on world_part.world_part_id = animals_location.world_part_id
        inner join animals on animals.animals_sort_id = animals_location.animals_sort_id
    where animals.animals_id = new.animals_id);
    location_y2 integer := (select y2
        from world_part
        inner join animals_location on world_part.world_part_id = animals_location.world_part_id
        inner join animals on animals.animals_sort_id = animals_location.animals_sort_id
    where animals.animals_id = new.animals_id);

    -- Получаем координаты новые координаты животного
    -- fixme: не уверен, что правильно
    x_new integer := (select x from animals where animals.animals_id = new.animals_id);
    y_new integer := (select y from animals where animals.animals_id = new.animals_id);

-- fixme: это условие не даёт вообще что-то изменять. @ckaf
-- todo: разобраться, что такое new и old @danilax86
begin
    if x_new < location_x1 or x_new > location_x2 or y_new < location_y1 or y_new > location_y2 then
        return null;
    end if;
    return new;
end;
$$ language plpgsql;

-- Здесь всё правильно
create trigger validate_animal_location
    before update or insert
    on animals for each row execute procedure validate_animal_location();


-- todo: сделать то же самое сделать и для растений @danilax86
