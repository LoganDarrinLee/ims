-- +goose Up
alter table users 
   alter column created_at set default current_timestamp;


-- +goose Down

