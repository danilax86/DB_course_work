drop function get_animal_objects;
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

drop function get_plant_objects;
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

drop function update_plant_location;
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


drop function update_animal_location;
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


-- todo: add more functions
