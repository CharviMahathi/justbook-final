# JustBook

JustBook is a minimal online movie ticket system with a React frontend, Spring Boot backend, and MySQL database. The project ships with Docker configuration and a Jenkins pipeline for CI/CD.

## Project Structure

- `frontend` – React single-page application
- `backend` – Spring Boot REST API
- `docker-compose.yml` – Local orchestration of frontend, backend, and MySQL
- `Jenkinsfile` – Declarative pipeline covering build, test, and Docker image packaging

## Prerequisites

- Docker Desktop (or Docker Engine + Docker Compose)
- Java 17+ (only required for manual backend runs)
- Node.js 18+ (only required for manual frontend runs)
- Maven 3.9+ (only required for manual backend runs)

## Quick Start with Docker

1. Launch the stack:
   ```sh
   docker compose up --build
   ```
2. Access the application:
   - Frontend UI: http://localhost:3000
   - Backend API: http://localhost:8080/api/bookings
   - MySQL: host `localhost`, port `3306`, user `justbook`, password `justbook`

The compose file seeds a few sample movies automatically on first start.

## Manual Development (Optional)

Run each service locally outside Docker for rapid iteration.

### Backend

```sh
cd backend
mvn spring-boot:run
```

Override database connection settings with environment variables when needed:

- `SPRING_DATASOURCE_URL`
- `SPRING_DATASOURCE_USERNAME`
- `SPRING_DATASOURCE_PASSWORD`
- `SPRING_JPA_HIBERNATE_DDL_AUTO`

### Frontend

```sh
cd frontend
npm install
npm start
```

Optionally point the UI to a different API host:

```sh
VITE_API_BASE_URL=http://localhost:8080/api npm start
```

The React dev server runs at http://localhost:3000 and proxies API requests to the backend by default.

## Running Tests

- Backend tests: `mvn test`
- Frontend tests: `npm test`

## Jenkins Pipeline

The included `Jenkinsfile` assumes the Jenkins agent has Docker installed. The pipeline stages are:

1. **Install Frontend** – `npm install`
2. **Frontend Tests & Build** – `npm test` and `npm run build`
3. **Backend Build** – `mvn -B verify`
4. **Docker Build & Publish** – build/tag images and push to a Docker registry (configure credentials and registry URL)

Adjust registry settings and credentials IDs in the Jenkinsfile to match your environment.

## Environment Variables

`docker-compose.yml` defines sensible defaults for local development. Override them by editing the compose file or using `.env` files supported by Docker Compose.

## Data Model Overview

- `Movie` – title, description, rating, available seats
- `Booking` – customer name, seat count, reference to a movie

## API Summary

| Method | Endpoint              | Description              |
|--------|-----------------------|--------------------------|
| GET    | `/api/movies`         | List available movies    |
| POST   | `/api/bookings`       | Create a new booking     |

Refer to the controller source for request/response formats.

## License

MIT
