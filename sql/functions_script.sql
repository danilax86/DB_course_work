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

create or replace function get_animal_sort_description_by_sort_id(sort_id integer)
    returns table (id integer, type_id integer, name text, description text) as
$$
begin
    return query select * from animals_sort where animals_sort_id = sort_id;
end;
$$ language plpgsql;


create or replace function get_animal_sort_description_by_animal_id(animal_id integer)
    returns table (id integer, type_id integer, name text, description text) as
$$
begin
    return query select animals_sort.animals_sort_id,
                        animals_sort.animals_type_id,
                        animals_sort.name,
                        animals_sort.description
                 from animals_sort
                          inner join animals on animals_sort.animals_sort_id = animals.animals_sort_id
                 where animals.animals_id = animal_id;
end;
$$ language plpgsql;


create or replace function get_animal_sort_description_by_animal_name(animal_name text)
    returns table (id integer, type_id integer, name text, description text) as
$$
begin
    return query select animals_sort.animals_sort_id,
                        animals_sort.animals_type_id,
                        animals_sort.name,
                        animals_sort.description
                 from animals_sort
                          inner join animals on animals_sort.animals_sort_id = animals.animals_sort_id
                 where animals.name = animal_name;
end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------
create or replace function get_plant_sort_description_by_sort_id(sort_id integer)
    returns table (id integer, type_id integer, name text, description text) as
$$
begin
    return query select * from plants_sort where plants_sort_id = sort_id;
end;
$$ language plpgsql;


create or replace function get_plant_sort_description_by_plant_id(plant_id integer)
    returns table (id integer, type_id integer, name text, description text) as
$$
begin
    return query select plants_sort.plants_sort_id,
                        plants_sort.plants_type_id,
                        plants_sort.name,
                        plants_sort.description
                 from plants_sort
                          inner join plants on plants_sort.plants_sort_id = plants.plants_sort_id
                 where plants.plants_id = plant_id;
end;
$$ language plpgsql;


create or replace function get_plant_sort_description_by_plant_name(plant_name text)
    returns table (id integer, type_id integer, name text, description textt) as
$$
begin
    return query select plants_sort.plants_sort_id,
                        plants_sort.plants_type_id,
                        plants_sort.name,
                        plants_sort.description
                 from plants_sort
                          inner join plants on plants_sort.plants_sort_id = plants.plants_sort_id
                 where plants.name = plant_name;
end;
$$ language plpgsql;

------------------------------------------------------------------------------------------------------------------------
create or replace function get_animal_type_by_type_id(type_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select * from animals_type where animals_type_id = type_id;
end;
$$ language plpgsql;


create or replace function get_animal_type_by_animal_id(animal_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select animals_type.animals_type_id, animals_type.name from animals_type
                                                                                 inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
                                                                                 inner join animals on animals.animals_sort_id = animals_sort.animals_sort_id
                 where animals.animals_id = animal_id;
end;
$$ language plpgsql;


create or replace function get_animal_type_by_animal_name(animal_name text)
    returns table (id integer, name text) as
$$
begin
    return query select animals_type.animals_type_id, animals_type.name from animals_type
                                                                                 inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
                                                                                 inner join animals on animals.animals_sort_id = animals_sort.animals_sort_id
                 where  animals.name = animal_name;
end;
$$ language plpgsql;


create or replace function get_animal_type_by_animal_sort_id(sort_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select animals_type.animals_type_id, animals_type.name from animals_type
                                                                                 inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
                 where animals_sort.animals_sort_id = sort_id;
end;
$$ language plpgsql;

create or replace function get_animal_type_by_animal_sort_name(sort_name text)
    returns table (id integer, name text) as
$$
begin
    return query select animals_type.animals_type_id, animals_type.name from animals_type
                                                                                 inner join animals_sort on animals_type.animals_type_id = animals_sort.animals_type_id
                 where animals_sort.name = sort_name;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function get_plant_type_by_type_id(type_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select * from plants_type where plants_type_id = type_id;
end;
$$ language plpgsql;


create or replace function get_plant_type_by_plant_id(plant_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select plants_type.plants_type_id, plants_type.name from plants_type
                                                                              inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
                                                                              inner join plants on plants.plants_sort_id = plants_sort.plants_sort_id
                 where plants.plants_id = plant_id;
end;
$$ language plpgsql;


create or replace function get_plant_type_by_plant_name(plant_name text)
    returns table (id integer, name text) as
$$
begin
    return query select plants_type.plants_type_id, plants_type.name from plants_type
                                                                              inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
                                                                              inner join plants on plants.plants_sort_id = plants_sort.plants_sort_id
                 where  plants.name = plant_name;
end;
$$ language plpgsql;


create or replace function get_plant_type_by_plant_sort_id(sort_id integer)
    returns table (id integer, name text) as
$$
begin
    return query select plants_type.plants_type_id, plants_type.name from plants_type
                                                                              inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
                 where plants_sort.plants_sort_id = sort_id;
end;
$$ language plpgsql;

create or replace function get_plant_type_by_plant_sort_name(sort_name text)
    returns table (id integer, name text) as
$$
begin
    return query select plants_type.plants_type_id, plants_type.name from plants_type
                                                                              inner join plants_sort on plants_type.plants_type_id = plants_sort.plants_type_id
                 where plants_sort.name = sort_name;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function update_animal_sort_description(id integer, description_arg text)
    returns integer as
$$
begin
    update animals_sort set description = description_arg where animals_sort_id = id;
    return 1;
end;
$$ language plpgsql;

create or replace function update_plant_sort_description(id integer, description_arg text)
    returns integer as
$$
begin
    update plants_sort set description = description_arg where plants_sort_id = id;
    return 1;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function enable_symbiosis(plant_sort_id_arg integer, animal_sort_id_arg integer)
    returns table (plant integer, animal integer) as
$$
begin
    insert into animals_plants (plants_sort_id, animals_sort_id)
    values (plant_sort_id_arg, animal_sort_id_arg);
    return query select * from animals_plants
                 where plants_sort_id = plant_sort_id_arg and animals_sort_id = animal_sort_id_arg;
end;
$$ language plpgsql;

create or replace function disable_symbiosis(plant_sort_id_arg integer, animal_sort_id_arg integer)
    returns table (plant integer, animal integer) as
$$
begin
    delete from animals_plants
    where plants_sort_id = plant_sort_id_arg and animals_sort_id = animal_sort_id_arg;
    return query select * from animals_plants;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function insert_animal_object(sort_id integer,
                                                name_arg text,
                                                x_arg integer,
                                                y_arg integer)
    returns table (animal integer, sort integer, name text, x integer, y integer) as
$$
declare animal_id integer;
begin
    insert into animals (animals_sort_id, name, x, y) values (sort_id, name_arg, x_arg, y_arg)
    returning animals_id into animal_id;
    return query select * from animals where animals_id = animal_id;
end;
$$ language plpgsql;

create or replace function insert_animal_sort_object(type_id integer,
                                                     name_arg text,
                                                     description_arg text,
                                                     world_part_id_arg integer)
    returns table (sort integer, type integer, name text, description text) as
$$
declare sort_id integer;
begin
    insert into animals_sort (animals_type_id, name, description) values (type_id, name_arg, description_arg)
    returning animals_sort_id into sort_id;
    insert into animals_location (animals_sort_id, world_part_id) values (sort_id, world_part_id_arg);
    return query select * from animals_sort where animals_sort_id = sort_id;
end;
$$ language plpgsql;

create or replace function insert_animal_type_object(name_arg text)
    returns table (type integer, name text) as
$$
declare type_id integer;
begin
    insert into animals_type (name) values (name_arg)
    returning animals_type_id into type_id;
    return query select * from animals_type where animals_type_id = type_id;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function insert_plant_object(sort_id integer,
                                               name_arg text,
                                               x_arg integer,
                                               y_arg integer)
    returns table (plant integer, sort integer, name text, x integer, y integer) as
$$
declare plant_id integer;
begin
    insert into plants (plants_sort_id, name, x, y) values (sort_id, name_arg, x_arg, y_arg)
    returning plants_id into plant_id;
    return query select * from plants where plants_id = plant_id;
end;
$$ language plpgsql;

create or replace function insert_plant_sort_object(type_id integer,
                                                    name_arg text,
                                                    description_arg text,
                                                    world_part_id_arg integer)
    returns table (sort integer, type integer, name text, description text) as
$$
declare sort_id integer;
begin
    insert into plants_sort (plants_type_id, name, description) values (type_id, name_arg, description_arg)
    returning plants_sort_id into sort_id;
    insert into plants_location (plants_sort_id, world_part_id) values (sort_id, world_part_id_arg);
    return query select * from plants_sort where plants_sort_id = sort_id;
end;
$$ language plpgsql;

create or replace function insert_plant_type_object(name_arg text)
    returns table (type integer, name text) as
$$
declare type_id integer;
begin
    insert into plants_type (name) values (name_arg)
    returning plants_type_id into type_id;
    return query select * from plants_type where plants_type_id = type_id;
end;
$$ language plpgsql;
------------------------------------------------------------------------------------------------------------------------
create or replace function update_animal_sort_location(sort_arg integer, world_part_id_arg integer)
    returns table (sort integer, world_part integer) as
$$
begin
    update animals_location set world_part_id = world_part_id_arg where animals_sort_id = sort_arg;
    return query select * from animals_location where animals_sort_id = sort_arg;
end;
$$ language plpgsql;

create or replace function update_plant_sort_location(sort_arg integer, world_part_id_arg integer)
    returns table (sort integer, world_part integer) as
$$
begin
    update plants_location set world_part_id = world_part_id_arg where plants_sort_id = sort_arg;
    return query select * from plants_location where plants_sort_id = sort_arg;
end;
$$ language plpgsql;
