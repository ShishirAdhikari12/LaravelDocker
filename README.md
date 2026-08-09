# Start
docker compose up --build

# Stop
docker compose down

# Enter PHP
docker compose exec php bash

# Migrate
docker compose exec php php artisan migrate

# Queue
docker compose logs queue

# WebSocket
docker compose logs websocket

# Node
docker compose exec node npm run dev