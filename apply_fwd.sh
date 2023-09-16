shardStmt="
CREATE TABLE books_$i (
CHECK ( category_id=$i )
) INHERITS ( books )
"

for i in {1..5}; do
    docker exec psql-b1 psql --user postgres -d books -c "$shardStmt"
done

inseetRuleStmt="
CREATE RULE books_insert_to_category_$i AS ON INSERT TO books
WHERE ( category_id = $i )
DO INSTEAD INSERT INTO books_$i VALUES (NEW.*);
"

for i in {1..5}; do
    docker exec psql-b1 psql --user postgres -d books -c "$insertRuleStmt"
done


