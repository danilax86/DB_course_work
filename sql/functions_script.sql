drop function get_animal_objects(integer);
create or replace function get_animal_objects(animal_id integer)
returns table (
                animals_id integer,
                animals_sort_id integer,
                name text,
                x integer,
                y integer
)
as
$$
begin
    return query select * from animals where animals.animals_id = animal_id;
end;
$$ language plpgsql;

drop function get_plant_objects(integer);
create or replace function get_plant_objects(plant_id integer)
returns table (
                plants_id integer,
                plants_sort_id integer,
                name text,
                x integer,
                y integer
)
as
$$
begin
    return query select * from plants where plants.plants_id = plant_id;
end;
$$ language plpgsql;

drop function update_plant_location(integer, integer, integer);
create or replace function update_plant_location(id integer, x_arg integer, y_arg integer)
returns table (
                plants_id integer,
                plants_sort_id integer,
                name text,
                x integer,
                y integer
) as
$$
    begin
        update plants set x = x_arg, y = y_arg where plants.plants_id = id;
        return query select * from plants where plants.plants_id = id;
    end;
$$ language plpgsql;


drop function update_animal_location(integer, integer, integer);
create or replace function update_animal_location(id integer, x_arg integer, y_arg integer)
returns table (
                animals_id integer,
                animals_sort_id integer,
                name text,
                x integer,
                y integer
) as
$$
    begin
        update animals set x = x_arg, y = y_arg where animals.animals_id = id;
        return query select * from animals where animals.animals_id = id;
    end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------

drop function get_animal_sort_description_by_sort_id(integer);
create or replace function get_animal_sort_description_by_sort_id(sort_id integer)
returns text as
$$
    declare
        name text := (select animals_sort.name from animals_sort where animals_sort_id = sort_id);
        description text := (select animals_sort.description from animals_sort where animals_sort_id = sort_id);
    begin
        return name || '; ' ||  description;
    end;
$$ language plpgsql;


drop function get_animal_sort_description_by_animal_id(integer);
create or replace function get_animal_sort_description_by_animal_id(animal_id integer)
returns text as
$$
    declare
        sort_id integer := (select animals.animals_sort_id from animals where animals.animals_id = animal_id);
        description text := (select get_animal_sort_description_by_sort_id(sort_id));
    begin
        return description;
    end;
$$ language plpgsql;


drop function get_animal_sort_description_by_animal_name(text);
create or replace function get_animal_sort_description_by_animal_name(animal_name text)
returns text as
$$
    declare
        sort_id integer := (select animals.animals_sort_id from animals where animals.name = animal_name);
        description text := (select get_animal_sort_description_by_sort_id(sort_id));
    begin
        return description;
    end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------
drop function get_plant_sort_description_by_sort_id(integer);
create or replace function get_plant_sort_description_by_sort_id(sort_id integer)
returns text as
$$
    declare
        name text := (select plants_sort.name from plants_sort where plants_sort_id = sort_id);
        description text := (select plants_sort.description from plants_sort where plants_sort_id = sort_id);
    begin
        return name || '; ' ||  description;
    end;
$$ language plpgsql;


drop function get_plant_sort_description_by_plant_id(integer);
create or replace function get_plant_sort_description_by_plant_id(plant_id integer)
returns text as
$$
    declare
        sort_id integer := (select plants.plants_sort_id from plants where plants.plants_id = plant_id);
        description text := (select get_plant_sort_description_by_sort_id(sort_id));
    begin
        return description;
    end;
$$ language plpgsql;


drop function get_plant_sort_description_by_plant_name(text);
create or replace function get_plant_sort_description_by_plant_name(plant_name text)
returns text as
$$
    declare
        sort_id integer := (select plants.plants_sort_id from plants where plants.name = plant_name);
        description text := (select get_plant_sort_description_by_sort_id(sort_id));
    begin
        return description;
    end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------
drop function get_animal_type_by_type_id(integer);
create or replace function get_animal_type_by_type_id(type_id integer)
returns text as
$$
    declare
        name text := (select animals_type.name from animals_type where animals_type_id = type_id);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_animal_type_by_animal_id(integer);
create or replace function get_animal_type_by_animal_id(animal_id integer)
returns text as
$$
    declare
        name text := (select animals_type.name from animals_type
        inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
        inner join animals on animals.animals_sort_id = animals_sort.animals_sort_id
        where  animals.animals_id = animal_id);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_animal_type_by_animal_name(text);
create or replace function get_animal_type_by_animal_name(animal_name text)
returns text as
$$
    declare
        name text := (select animals_type.name from animals_type
        inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
        inner join animals on animals.animals_sort_id = animals_sort.animals_sort_id
        where  animals.name = animal_name);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_animal_type_by_animal_sort_id(integer);
create or replace function get_animal_type_by_animal_sort_id(sort_id integer)
returns text as
$$
    declare
        name text := (select animals_type.name from animals_type
        inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
        where animals_sort.animals_sort_id = sort_id);
    begin
        return name;
    end;
$$ language plpgsql;

drop function get_animal_type_by_animal_sort_name(text);
create or replace function get_animal_type_by_animal_sort_name(sort_name text)
returns text as
$$
    declare
        name text := (select animals_type.name from animals_type
        inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
        where animals_sort.name = sort_name);
    begin
        return name;
    end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
drop function get_plant_type_by_type_id(integer);
create or replace function get_plant_type_by_type_id(type_id integer)
returns text as
$$
    declare
        name text := (select plants_type.name from plants_type where plants_type_id = type_id);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_plant_type_by_plant_id(integer);
create or replace function get_plant_type_by_plant_id(plant_id integer)
returns text as
$$
    declare
        name text := (select plants_type.name from plants_type
        inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
        inner join plants on plants.plants_sort_id = plants_sort.plants_sort_id
        where  plants.plants_id = plant_id);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_plant_type_by_plant_name(text);
create or replace function get_plant_type_by_plant_name(plant_name text)
returns text as
$$
    declare
        name text := (select plants_type.name from plants_type
        inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
        inner join plants on plants.plants_sort_id = plants_sort.plants_sort_id
        where  plants.name = plant_name);
    begin
        return name;
    end;
$$ language plpgsql;


drop function get_plant_type_by_plant_sort_id(integer);
create or replace function get_plant_type_by_plant_sort_id(sort_id integer)
returns text as
$$
    declare
        name text := (select plants_type.name from plants_type
        inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
        where plants_sort.plants_sort_id = sort_id);
    begin
        return name;
    end;
$$ language plpgsql;

drop function get_plant_type_by_plant_sort_name(text);
create or replace function get_plant_type_by_plant_sort_name(sort_name text)
returns text as
$$
    declare
        name text := (select plants_type.name from plants_type
        inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
        where plants_sort.name = sort_name);
    begin
        return name;
    end;
$$ language plpgsql;
-- todo: add more functions
