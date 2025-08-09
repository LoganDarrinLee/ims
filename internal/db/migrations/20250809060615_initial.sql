-- +goose Up
create table if not exists users ();

-- +goose Down
drop table if exists users;
