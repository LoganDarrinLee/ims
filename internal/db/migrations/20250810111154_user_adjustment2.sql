-- +goose Up
alter table users
  add column name varchar(40);

-- +goose Down
alter table users 
  delete column name;
