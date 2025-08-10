
-- name: InsertNewProduct :exec
insert into products (
  product_category_id,
  supplier_id,
  cost,
  selling
)
values (
  $1, $2, $3, $4
);

-- name: Select

