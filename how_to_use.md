# How to Run the Project with Docker Compose

This project uses Docker Compose to easily run all required services (Elixir/Phoenix app and PostgreSQL database).

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

## Steps to Run

1. **Clone the repository:**
   ```sh
   git clone <REPOSITORY_URL>
   cd <PROJECT_FOLDER>
   ```

2. **Create the `.env` file (if needed):**
   - Copy the example file, if it exists:
     ```sh
     cp .env.example .env
     ```
   - Or manually create a `.env` file with the required environment variables for the app.

3. **Start the containers:**
   ```sh
   docker compose up --build
   ```
   This will:
   - Build the application image
   - Start the PostgreSQL database
   - Start the Phoenix application

4. **Access the application:**
   - Go to [http://localhost:4000](http://localhost:4000) in your browser.

5. **(Optional) Run migrations:**
   If the app does not run migrations automatically, execute:
   ```sh
   docker compose exec app mix ecto.migrate
   ```

## Notes
- The database is persisted in a Docker volume named `pgdata`.
- The `db` (PostgreSQL) service uses a healthcheck to ensure it is ready before the app starts.
- The `SECRET_KEY_BASE` is generated automatically on each build, but you can set it manually in `.env` for production environments.

## Stop and remove containers
```sh
docker compose down
```

## Clean database volumes (optional)
```sh
docker compose down -v
```

---

If you have any questions, check the `docker-compose.yml` file or contact the project maintainer.
