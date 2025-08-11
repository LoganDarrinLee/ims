-- +goose Up
create table if not exists units_of_measurements (
  id uuid primary key,
  uom_name varchar(40) unique not null, 
  uom_abbreviation varchar(4) 
);

create table if not exists product_uoms (
  id uuid primary key,
  uom_id uuid,
  parent_uom_id uuid,
  product_id uuid,
  purchasing_cost real,
  foreign key (uom_id) references units_of_measurements(id),
  foreign key (parent_uom_id) references units_of_measurements(id),
  foreign key (product_id) references products(id)
);

alter table products 
  add column name varchar(40);

-- +goose Down
drop table if exists units_of_measurements;
drop table if exists product_uoms;

alter table products delete column name;
