-- CREATE TABLE public.products (
--     id uuid NOT NULL,
--     product_category_id uuid,
--     supplier_id uuid,
--     cost real,
--     selling real,
--     name character varying(40),
--     barcode text
-- );

-- name: InsertNewProduct :exec
insert into products (
  product_category_id,
  supplier_id,
  name,
  cost,
  selling,
  barcode
)
values (
  $1, $2, $3, $4, $5. $6
);

-- name: SelectProductByUUID :one
select * from prouducts where product.id = $1;

-- name: SearchProducts :many
select * from products 
  where name LIKE CONCAT('%', $1::text, '%');

-- name: SearchProductsInCategory :many
select * from products where product.product_category_id = $1;
