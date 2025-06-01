## Description and goals
The goal is to deepen understanding of database management, containerization with Docker, and to improve proficiency in writing efficient and scalable SQL queries.\
This project is focused on practicing and enhancing skills in:
* **Docker**
* **PostgreSQL**
* **SQL** - advanced topics like indexing, query optimization, and database normalization
* database migration management tools such as **Flyway**

The order of the sections below is intentional — it reflects the natural progression of the project. To make sure everything works as expected, follow them step by step in the given order.
</br></br></br>

## 1. Docker setup and usage
1. Open the terminal/cmd, navigate to the `docker` directory and run the PostgreSQL container:
   ```
   docker-compose up -d
   ```
   `-d` flag stands for **detached mode** - the containers run in the background, and you have access to the terminal.\
   `--build` - add this flag if you change something in `docker-compose.yml`.
2. Check the list of running containers:
   ```
   docker-compose ps
   ```
3. Access the PostgreSQL container terminal:
   ```
   docker exec -it <container_name> bash
   ```
   If you see the `#` prompt, you are logged into the container's shell and have access to its environment.
4. Connect to the PostgreSQL database in the container using the credentials defined in `docker-compose.yml`:
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
5. Closing:\
   Exit the PostgreSQL command-line client (psql) by typing `\q`.\
   Type `exit` to leave the container shell.\
   Stop the container by typing `docker-compose stop` or remove it by `docker-compose down`.
6. If you used the `-d` flag with `docker-compose up`, you won't see the logs. To display them, use:
   ```
   docker-compose logs --tail=100
   ```   
7. To delete the volumes and the data in them type `docker volume ls` to get the name of the volume. Then, use the following command:
   ```
   docker volume rm <volume_name>
   ```
   Or when removing containers use the `-v` flag:
   ```
   docker-compose down -v
   ```
**Note on database initialization:**\
When the PostgreSQL container starts for the first time (or after its data volume has been cleared), it will automatically execute SQL scripts located in its `/docker-entrypoint-initdb.d/` directory. In this project, the `docker/init.sql` script is configured (via `docker-compose.yml`) to be run during initialization phase. This script is responsible for creating the necessary database schema and defining the employees and contacts tables.
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
You can find examples of how to use it in the following scripts `...\scripts\generate_employees.py` and `...\scripts\generate_contacts.py`. These scripts generate random employee and contact data and save it as CSV files in the `scripts` directory.\
If you want to generate new data: Navigate to the `scripts` directory in your terminal and run the following commands:
```
python generate_employees.py
```
```
python generate_contacts.py
```
</br></br>

## 4. Import data
**• Import data using pgAdmin:**
1. Navigate to the `employees` table.
2. Right-click on the table and select `Import/Export Data...`.
3. In the `General` tab, in the `Filename`, click the folder icon.
4. Then, click `...` / `Options` → `Upload`.
5. Select the `employees.csv` file from your disk and click `Close` - the second one, we don't want to close the entire window.
6. Mark the file in the list and click `Select`.
7. In the `Options` tab, ensure that the following settings are configured:
   - Header: make sure it is checked, as the CSV file includes a header row.
   - Delimiter: set to `,` (comma) for CSV files.
8. Click `OK`.

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
   COPY company.contacts FROM '/tmp/contacts.csv' DELIMITER ',' CSV HEADER;
   ```
5. Verify the data import:
   ```
   SELECT * FROM company.contacts LIMIT 10;
   ```
6. Delete temporary file (the command to use at the PostgreSQL container level):
   ```
   rm /tmp/contacts.csv
   ```
**Note:** The `employees` table should be imported first, as the `contacts` table contains a foreign key referencing `employees`.
</br></br></br>


## 5. Database backup
This project includes a `backup.sh` script, designed to automate the process of creating backups of the PostgreSQL database running inside a Docker container.\
**How it works:**
- The `backup.sh` script utilizes docker-compose exec to run the pg_dump command inside the postgres service container.
- The resulting SQL dump file is saved to the `backups/` directory located at the root of this project on your host machine.
- Each backup file is timestamped (backup_YYYY-MM-DD_HH-MM-SS.sql).
- The script logs its activity to the `$PROJECT_ROOT/backups/cron.log` file.

**How to use it:**
1. Open the `backup.sh` script and make sure the variables at the top are configured correctly for your environment (including PROJECT_ROOT).
2. Make the script executable: navigate to the project's root directory in your terminal and run:
   ```
   chmod +x scripts/backup.sh
   ```
   To schedule the `backup.sh` script to run automatically, we need to add a job to the user's crontab:
3. In the terminal, execute:
   ```
   crontab -e
   ```
   If this is your first time running crontab, you might be prompted to select a text editor (e.g., nano, vim). Choose one you are comfortable with.
4. Add the cron job entry:
   ```
   0 2 * * * /home/USER/Desktop/PostgreSQL-practice-with-Docker/scripts/backup.sh
   ```
5. Save the crontab file and exit the editor.
   For nano: Press Ctrl+O (Write Out), then Enter to confirm, then Ctrl+X to exit.\
   For vim: Press Esc, then type :wq and press Enter.
