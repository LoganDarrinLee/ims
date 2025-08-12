-- CREATE TABLE public.product_categories (
--     id uuid NOT NULL,
--     category character varying(40),
--     category_info text
-- );

-- name: InsertProductCategory :exec
insert into product_categories (
  category,
  category_info
) values ( $1, $2 );

-- name: ListProductCategories :many
select * from product_categories;

-- name: UpdateProductCategory :exec 
select * from product_categories;

-- name: ListProductsInCategory :many
select * from products where product.product_category_id = $1;


