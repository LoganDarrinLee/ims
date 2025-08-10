-- +goose Up
create table if not exists users (
  id uuid primary key,
  created_at timestamp
);

create table if not exists inventory_locations (
  id uuid primary key,
  location varchar(100)
);

create table if not exists suppliers (
  id uuid primary key,
  supplier_name varchar(100)
);

create table if not exists product_categories (
  id uuid primary key,
  category varchar(40),
  category_info text
);

create table if not exists products (
  id uuid primary key,
  product_category_id uuid,
  supplier_id uuid,
  cost real,
  selling real,
  foreign key (product_category_id) references product_categories(id)
);

create table if not exists inventory_items (
  id uuid primary key,
  product_id uuid, 
  inventory_location_id uuid,
  quantity_in_location int,
  foreign key (product_id) references products(id),
  foreign key (inventory_location_id) references inventory_locations(id)
);

create table if not exists orders (
  id uuid primary key,
  order_total real,
  tax_amount real,
  final_total real
);

create table if not exists order_items (
  id uuid primary key,
  order_id uuid,
  quantity int,
  total_price real,
  foreign key (order_id) references orders(id)
);


-- +goose Down
drop table if exists users;
drop table if exists inventory_locations;
drop table if exists suppliers;
drop table if exists product_categories;
drop table if exists products;
drop table if exists inventory_items;
drop table if exists orders;
drop table if exists order_items;
