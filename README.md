# pg-playground
A PostgreSQL playground with preloaded sample data to make playing with PostgreSQL easy.
The sample data is historical records of Formula One motor car racing.

The source of the sample data is [here](http://ergast.com/mrd/).

## Usage

Given you're in the repository folder, run the following command to start PostgreSQL inside a docker container.

```
./start-postgres-playground.sh
```

NOTE! IT TAKES AROUND 30 SECONDS FOR EVERYTHING TO START UP.

Wait until it says `Press any key to stop ...` and then connect to the database to start playing by running the below command.

```
psql "postgres://postgres:postgres@localhost:15432/postgres?sslmode=disable"
```

## Prerequisites

- Docker must be installed
- Psql must be installed

