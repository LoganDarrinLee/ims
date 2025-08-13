-- +goose Up
alter table inventory_locations 
  add column barcode text;

alter table inventory_items 
  add column product_uom_id uuid references product_uoms(id);

create table if not exists inventory_transactions (
  id uuid primary key,
  transaction_timestamp timestamp default current_timestamp,
  inventory_location_id uuid,
  product_id uuid,
  product_uom uuid,
  transaction_amount int,
  foreign key (inventory_location_id) references inventory_locations(id)
);

comment on column inventory_transactions.transaction_amount is 
'Can be either negative or positive.';

-- +goose Down
alter table inventory_locations delete column barcode;
alter table inventory_items delete column product_uom_id;
drop table if exists inventory_transactions;

