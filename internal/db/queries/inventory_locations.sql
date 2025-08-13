-- CREATE TABLE public.inventory_locations (
--     id uuid NOT NULL,
--     location character varying(100),
--     barcode text
-- );




-- name: InsertInventoryLocation :exec
insert into inventory_locations 
  (id, location, barcode) 
values ($1, $2, $3);

-- name: GetLocationByBarcode :one 
select * from inventory_locations
  where barcode = $1;


