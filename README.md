## Description and goals
The goal is to deepen understanding of database management, containerization with Docker, and improve proficiency in writing efficient and scalable SQL queries.\
This project is focused on practicing and enhancing skills in:
* Docker
* PostgreSQL
* SQL - advanced topics like indexing, query optimization, and database normalization
* tools like Flyway for managing database migrations
</br></br></br>

## 1. Docker setup and usage
1. Open the terminal/cmd, navigate to the `docker` directory and run the PostgreSQL container:
   ```
   docker-compose up -d
   ```
   `-d` flag stands for detach mode - the containers run in the background, and you have access to the terminal.\
   `--build` - add this flag if you change something in `docker-compose.yml`.
2. Check the list of running containers:
   ```
   docker-compose ps
   ```
3. Access the PostgreSQL container terminal:
   ```
   docker exec -it <container_name> bash
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
7. To delete the volumes and the data in them type `docker volume ls` to get the name of the volume. Then, use the following command:
   ```
   docker volume rm <volume_name>
   ```
   Or when deleting containers use the `-v` flag:
   ```
   docker-compose down -v
   ```
</br></br>

## 2. pgAdmin
As a GUI, we use [pgAdmin](https://www.pgadmin.org).\
Once the containers are running, go to your browser and type:
```
http://localhost:8080
```
To login, use the data defined in the `docker-compose.yml` file.\
Once logged into pgAdmin, you will need to add a new server:
1. Right-click on `Servers` in the left panel and select `Register` → `Server...`.
2. In the `General` tab, name the server (e.g. "Company").
3. In the `Connection` tab, use the following settings (as defined in docker-compose.yml):
   - Host: `postgres` (the name of the service in docker-compose)
   - Port: `5432`
   - Username: `admin`
   - Password: `admin123`
   - Maintenance database: `postgres_db`
</br></br></br>

## 3. Faker
To generate data for the database, we will use the [Faker](https://pypi.org/project/Faker) (Python library). Install it with the command:
```
pip install Faker
```
You can see the usage in `...\scripts\generate_employees.py` and `...\scripts\generate_contacts.py`. These scripts generate random employee and contact data and save it as CSV files in the `scripts` directory.\
If you want to generate new data: In the terminal, navigate to the `...\scripts` directory and use the following commands:
```
python generate_employees.py
```
```
python generate_contacts.py
```
</br></br>

## 4. Import data
**• Import data using the pgAdmin graphical interface:**
1. Navigate to the `employees` table.
2. Right-click on the table and select `Import/Export Data...`.
3. In the `General` tab, in the `Filename`, click the folder icon.
4. Then click `...` / `Options` → `Upload`.
5. Select the `employees.csv` file from your disk and click `Close` - the second one, we don't want to close the entire window.
6. Mark the file from the list and click `Select`.
7. In the `Options` tab, ensure that the following settings are configured:
   - Header: make sure it is checked, as the CSV file includes a header row.
   - Delimiter: set to `,` (comma) for CSV files.
8. Click `Ok`.

**• Import data using the terminal:**
1. Copy the CSV file to the PostgreSQL container:
   ```
   docker cp path/on/your/disk/scripts/contacts.csv <container_name>:/tmp/contacts.csv
   ```
2. Login to the PostgreSQL container:
   ```
   docker exec -it <container_name> bash
   ```
3. Connect to PostgreSQL database:
   ```
   psql -U admin -d postgres_db
   ```
4. Import the data into the `contacts` table using the `COPY` command:
   ```
   COPY contacts FROM '/tmp/contacts.csv' DELIMITER ',' CSV HEADER;
   ```
5. Verify the data import:
   ```
   SELECT * FROM contacts LIMIT 10;
   ```
6. Delete temporary file (the command to use at the PostgreSQL container level):
   ```
   rm /tmp/contacts.csv
   ```
