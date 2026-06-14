# Config API

FastAPI backend that serves per-client theme and feature config.

## Run

```bash
pip install -r requirements.txt
uvicorn main:app --reload --port 8000
```

## Endpoints

| Endpoint | Description |
|---|---|
| `GET /config/{client_id}` | Full config for a client |
| `GET /clients` | List all registered clients |
| `GET /health` | Health check |

## Test

```
http://localhost:8000/config/healthplus
http://localhost:8000/config/vitacare
http://localhost:8000/clients
```

## Adding a client

Drop a new JSON file in `configs/`. Follow the schema of `healthplus.json`. No code changes needed.
