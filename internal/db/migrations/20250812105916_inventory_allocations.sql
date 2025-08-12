-- +goose Up
create table if not exists total_product_in_inventory (
  id uuid primary key,
  product_id uuid, 
  updated_at timestamp default current_timestamp,
  total_product_on_hand int,
  foreign key (product_id) references products(id)
);

create table if not exists total_allocated_products (
  id uuid primary key,
  product_id uuid,
  allocated int,
  available int,
  foreign key (product_id) references products(id)
);

alter table orders 
  add column completed bool;

-- +goose Down
drop table if exists total_product_in_inventory;
drop table if exists allocated_products;

alter table orders
  delete column completed;
