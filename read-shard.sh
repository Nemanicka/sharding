docker exec $1 psql --user postgres -d books -c "Select * from books$2;" 
