-- CREATE TABLE public.inventory_locations (
--     id uuid NOT NULL,
--     location character varying(100)
-- );

-- name: InsertInventoryLocation :exec
insert into inventory_locations (location) values $1;

