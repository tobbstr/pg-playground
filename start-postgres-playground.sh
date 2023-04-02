#!/bin/zsh
# start mysql
mysqlId=$(docker run \
	-d \
	--rm \
	-p 3306:3306 \
	--name my_tmp_mysql \
	-e MYSQL_ROOT_PASSWORD=secret \
	-e MYSQL_DATABASE=f1db \
	-e MYSQL_USER=mysqlusr \
	-e MYSQL_PASSWORD=mysqlpwd \
	-v ${PWD}/mysql-dump-f1db.sql:/docker-entrypoint-initdb.d/dump.sql \
	mysql:5.6.51)

# start postgres
postgresId=$(docker run \
	--name postgres-playground \
	-d \
	--rm \
	-p 15432:5432 \
	-e POSTGRES_DB=f1db \
	-e POSTGRES_USER=postgres \
	-e POSTGRES_PASSWORD=postgres \
	postgres:15.2-alpine3.17)

# wait for MySQL and PostgreSQL to startup properly
sleep 30

# migrate MySQL database (f1db) into PostgreSQL
docker run \
	--rm \
	--network host \
	dimitri/pgloader:v3.6.7 \
	pgloader \
	mysql://root:secret@localhost/f1db \
	pgsql://postgres:postgres@localhost:15432/f1db

read -s -k '?Press any key to stop ...'
echo ""

# cleanup
dummy=$(docker kill $mysqlId)
dummy=$(docker kill $postgresId)

