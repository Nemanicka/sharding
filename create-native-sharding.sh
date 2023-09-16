docker exec -it psql-b2 createdb -U postgres books 

createBooksTableStmt="CREATE TABLE IF NOT EXISTS books (id bigint not null, category_id int not null, author character varying not null, title character varying not null, year int not null) PARTITION BY LIST (category_id);"

docker exec psql-b2 psql --user postgres -d books -c "$createBooksTableStmt"

for i in {0..4}; do
    docker exec psql-b2 psql --user postgres -d books -c "
        CREATE TABLE books_$i
        PARTITION OF books
        FOR VALUES IN ($i)
    "
done
