## Description and goals
The goal is to deepen understanding of database management, containerization with Docker, and improve proficiency in writing efficient and scalable SQL queries.\
This project is focused on practicing and enhancing skills in:
* Docker
* PostgreSQL
* SQL - advanced topics like indexing, query optimization, and database normalization
* tools like Flyway for managing database migrations
</br></br></br>

## Docker setup and usage
1. Open the terminal/cmd, navigate to the `docker` directory and run the PostgreSQL container:
   ```
   docker-compose up -d
   ```
   `-d` flag means detach mode - the containers run in the background, and you have access to the terminal.\
   `--build` - add this flag if you change something in `docker-compose.yml`.
2. Check the list of running containers:
   ```
   docker-compose ps
   ```
3. Access the PostgreSQL container terminal:
   ```
   docker exec -it <container_name> sh
   ```
   If you see the `#` prompt, you are logged into the container's shell and have access to its environment.\
   Connect to the PostgreSQL database in the container using the data defined in `docker-compose`:
   ```
   psql -U admin -d postgres_db
   ```
   You can now execute SQL queries, such as:
   ```
   CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100)
   );

   INSERT INTO users (username, email) VALUES ('john_doe', 'john.doe@example.com');

   SELECT * FROM users;
   ```
   Exit the PostgreSQL command-line client (psql) by typing `\q`.\
   Type `exit` to leave the `sh`.\
   Stop the container by typing `docker-compose stop` or remove it by `docker-compose down`.
5. If we use the `-d` flag for `docker-compose up`, we can't see the logs. To display them:
   ```
   docker-compose logs --tail=100
   ```
</br></br>

## pgAdmin
As a GUI, we use pgAdmin.\
Once the containers are running, go to your browser and type:
```
http://localhost:8080
```
To login, use the data defined in the `docker-compose.yml` file.
