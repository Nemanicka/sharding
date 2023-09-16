./create psql-b1

docker exec psql-b1 psql --user postgres -d books -c "$createBooksTableStmt"
for i in {1..5}; do
    docker exec psql-b1 psql --user postgres -d books -c "
        CREATE TABLE books_$i (
        CHECK ( category_id=$i )
        ) INHERITS ( books )
    "
done

for i in {1..5}; do
    docker exec psql-b1 psql --user postgres -d books -c "
        CREATE RULE books_insert_to_category_$i AS ON INSERT TO books
        WHERE ( category_id = $i )
        DO INSTEAD INSERT INTO books_$i VALUES (NEW.*);
    "
done
