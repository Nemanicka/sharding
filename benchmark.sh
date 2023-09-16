insertStmt="DO \$\$ 
DECLARE 
    i INT;
BEGIN 
    FOR i IN 1..1000000 LOOP
        INSERT INTO books (id, category_id, author, title, year) VALUES (i, i%5, 'Oleksii', 'Homework', 2023);
    END LOOP;
END \$\$;
"

time docker exec $1 psql --user postgres -d books -c "$insertStmt"

time docker exec $1 psql --user postgres -d books -c "Select * from books;" > /dev/null

time docker exec $1 psql --user postgres -d books -c "Select * from books where id=666666;"

docker exec $1 psql --user postgres -d books -c "delete from books;"
