
# RTS-PT: Real-Time Stock Price Tracker

A real-time stock price feed system built with Elixir, Phoenix LiveView, and PostgreSQL. Ready to run locally via Docker Compose.

## Features
- Real-time stock price updates via Phoenix LiveView
- Dynamic subscription to stock symbols
- User authentication and account management
- Modern UI/UX with theme toggle
- Robust test coverage for business logic and core modules
- Dockerized for easy local development

## Getting Started

### Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Running with Docker Compose

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
	- Or manually create a `.env` file with the required environment variables.
3. **Start the containers:**
	```sh
	docker compose up --build
	```
4. **Access the application:**
	- Open [http://localhost:4000](http://localhost:4000) in your browser.
5. **(Optional) Run migrations:**
	```sh
	docker compose exec app mix ecto.migrate
	```

### Stopping and Cleaning Up
- Stop and remove containers:
  ```sh
  docker compose down
  ```
- Remove database volumes (optional):
  ```sh
  docker compose down -v
  ```

## Project Structure
- `apps/` — Umbrella apps: core business logic and web interface
- `config/` — Configuration files
- `docker-compose.yml` — Docker Compose setup
- `test/` — Automated tests

## Running Tests
To run the test suite:
```sh
mix test
```
Or, inside the Docker container:
```sh
docker compose exec app mix test
```

## License
MIT

---

For more details, see `how_to_use.md` or contact the project maintainer.
