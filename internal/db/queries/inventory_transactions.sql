-- CREATE TABLE public.inventory_transactions (
--     id uuid NOT NULL,
--     transaction_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
--     inventory_location_id uuid,
--     product_id uuid,
--     product_uom uuid,
--     transaction_amount integer
-- );

-- name: InsertInventoryTransaction :exec 
insert into inventory_transactions 
(
  id, 
  inventory_location_id,
  product_id,
  product_uom,
  transaction_amount
) 
values ($1, $2, $3, $4, $5);

-- name: ListProductTransactions :many
select * 
from inventory_transactions 
where product_id = $1 
order by transaction_timestamp
limit 100;

-- name: ListLocationTransactions :many
select * 
from inventory_transactions 
where inventory_location_id = $1 
order by transaction_timestamp
limit 100;


