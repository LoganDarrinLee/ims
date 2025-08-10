-- +goose Up
create table if not exists product_units (
  id uuid primary key,
);

alter table products 
  add column name varchar(40);

alter table products 
  add column order_unit_id uuid;

comment on column products.order_unit_id is 
''; 

-- +goose Down
drop table if exists product_units;
