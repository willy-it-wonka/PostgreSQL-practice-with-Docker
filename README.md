## Description and goals
The goal is to deepen understanding of database management, containerization with Docker, and improve proficiency in writing efficient and scalable SQL queries.\
This project is focused on practicing and enhancing skills in:
* Docker
* PostgreSQL
* SQL - advanced topics like indexing, query optimization, and database normalization
* tools like Flyway for managing database migrations
</br></br>

## Docker
1. In cmd/terminal go to the `docker` directory and run Postgres container:
   ```
   docker-compose up -d
   ```
   `-d` flag means detach mode - the containers run in the background, and you have access to the terminal.\
   `--build` - add this flag if you change something in `docker-compose.yml`.
2. Check the list of running containers:
   ```
   docker-compose ps
   ```
3. Access the Postgres container terminal:
   ```
   docker exec -it <container_name> sh
   ```
   If you see `#` then you are logged into the container's operating system shell and have access to its environment.\
   Connect to the PostgreSQL database in the container using the data defined in `docker-compose`:
   ```
   psql -U admin -d postgres_db
   ```
   You can perform SQL operations:
   ```
   CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100)
   );

   INSERT INTO users (username, email) VALUES ('john_doe', 'john.doe@example.com');

   SELECT * FROM users;
   ```
   Exit the command line client for PostgreSQL (psql) with `\q`.\
   Use `exit` to exit the sh shell.
4. ...
