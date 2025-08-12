-- +goose Up
create table if not exists units_of_measurements (
  id uuid primary key,
  uom_name varchar(40) unique not null, 
  uom_abbreviation varchar(4) 
);

create table if not exists product_uoms (
  id uuid primary key,
  product_id uuid,
  uom_id uuid,
  parent_uom_id uuid,
  senior_uom bool default false,
  has_child_uom bool default false,
  parent_uom_qantity_multiplier int,
  purchasing_cost real,
  uom_barcode text,
  foreign key (uom_id) references units_of_measurements(id),
  foreign key (parent_uom_id) references units_of_measurements(id),
  foreign key (product_id) references products(id)
);

comment on column product_uoms.parent_uom_qantity_multiplier is 
'
  The quantity of the current product_uom that come in the parent_uom.  
  For exampe selling soda cans: Pallets have 100 boxes, each box has twelve cans.
';

comment on column product_uoms.senior_uom is 
'The largest unit of measurement we purchase in.';

alter table products 
  add column name varchar(40);

alter table products 
  add column barcode text;

-- +goose Down
drop table if exists units_of_measurements;
drop table if exists product_uoms;

alter table products delete column name;
alter table products delete column barcode;
