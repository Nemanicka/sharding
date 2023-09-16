docker exec $1 psql --user postgres -d books -c "delete from books;"
