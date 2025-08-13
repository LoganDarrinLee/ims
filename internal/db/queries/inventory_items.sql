-- CREATE TABLE public.inventory_items (
--     id uuid NOT NULL,
--     product_id uuid,
--     inventory_location_id uuid,
--     quantity_in_location integer,
--     product_uom_id uuid
-- );

-- name: InsertInventoryItem :exec
insert into inventory_items (
  id, 
  inventory_location_id,
  product_id,
  product_uom_id,
  quantity_in_location
) values (
  $1, $2, $3, $4
);

-- name: SearchInventoryItem :many 
select * from inventory_items 
  where product_id = $1 
limit 100;

-- name: ListAllInventoryItems :many 
select * from inventory_items;
