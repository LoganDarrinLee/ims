
-- name: InsertUser :exec
insert into users (id) values ($1);

-- name: GetRandomUser :one
select * from users 
  order by random()
limit 1;

-- name: GetUserByName :one 
select * from users 
  where user.name = $1
limit 1;
