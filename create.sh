docker exec -it $1 createdb -U postgres books 

createBooksTableStmt="CREATE TABLE IF NOT EXISTS books (id bigint not null, category_id int not null, author character varying not null, title character varying not null, year int not null)"

docker exec $1 psql --user postgres -d books -c "$createBooksTableStmt"
