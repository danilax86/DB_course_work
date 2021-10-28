create table animals_type
(
    animals_type_id serial
        constraint animals_type_pk
            primary key,
    name            text not null
);

create table animals_sort
(
    animals_sort_id serial
        constraint animals_sort_pk
            primary key,
    animals_type_id integer not null
        constraint animals_sort_fk
            references animals_type,
    name            text    not null,
    description     text
);

create table animals
(
    animals_id      serial
        constraint animals_pk
            primary key,
    animals_sort_id integer not null
        constraint animals_animals_sort_fk
            references animals_sort,
    name            text    not null,
    x               integer not null,
    y               integer not null,
    constraint animals_check
        check ((x >= 0) AND (x <= 500) AND (y >= 0) AND (y <= 500))
);

create unique index animals_animals_id_uindex
    on animals (animals_id);

create unique index animals_sort_animals_sort_id_uindex
    on animals_sort (animals_sort_id);

create unique index animals_type_animals_type_id_uindex
    on animals_type (animals_type_id);

create table plants_type
(
    plants_type_id serial
        constraint plants_type_pk
            primary key,
    name           text
);

create unique index plants_type_plants_type_id_uindex
    on plants_type (plants_type_id);

create table plants_sort
(
    plants_sort_id serial
        constraint plants_sort_pk
            primary key,
    plants_type_id integer not null
        constraint plants_sort_plants_type_fk
            references plants_type,
    name           text,
    description    text
);

create unique index plants_sort_plants_sort_id_uindex
    on plants_sort (plants_sort_id);

create table plants
(
    plants_id      serial
        constraint plants_pk
            primary key,
    plants_sort_id integer not null
        constraint plants_plants_sort_fk
            references plants_sort,
    name           text    not null,
    x              integer not null,
    y              integer not null,
    constraint plants_check
        check ((x >= 0) AND (x <= 500) AND (y >= 0) AND (y <= 500))
);

create unique index plants_plants_id_uindex
    on plants (plants_id);

create table animals_plants
(
    plants_sort_id  integer not null
        constraint animals_plants_pk
            primary key
        constraint animals_plants_fk2
            references plants_sort,
    animals_sort_id integer not null
        constraint animals_plants_fk1
            references animals_sort
);

create table world_part
(
    world_part_id serial
        constraint world_part_pk
            primary key,
    name          text,
    x1            integer not null,
    x2            integer not null,
    y1            integer,
    y2            integer,
    constraint world_part_check
        check ((x1 >= 0) AND (x1 <= 500) AND (y1 >= 0) AND (y1 <= 500) AND (x2 >= 0) AND (x2 <= 500) AND (y2 >= 0) AND
               (y2 <= 500))
);

create table plants_location
(
    plants_sort_id integer not null
        constraint plants_location_pk
            primary key
        constraint plants_location_fk1
            references plants_sort,
    world_part_id  integer not null
        constraint plants_location_fk2
            references world_part
);

create unique index plants_location_plants_sort_id_uindex
    on plants_location (plants_sort_id);

create unique index world_part_world_part_id_uindex
    on world_part (world_part_id);

create table animals_location
(
    animals_sort_id integer not null
        constraint animals_location_pk
            primary key
        constraint animals_location_fk1
            references animals_sort,
    world_part_id   integer not null
        constraint animals_location_fk2
            references world_part
);
