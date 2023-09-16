docker exec $1 psql --user postgres -d books -c "drop table books;"
