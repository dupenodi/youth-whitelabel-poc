from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
import json
import os

app = FastAPI(title="YOUTH White-Label Config API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

CONFIG_DIR = os.path.join(os.path.dirname(__file__), "configs")


@app.get("/config/{client_id}")
def get_config(client_id: str):
    config_path = os.path.join(CONFIG_DIR, f"{client_id}.json")
    if not os.path.exists(config_path):
        raise HTTPException(
            status_code=404, detail=f"No config found for client: {client_id}"
        )
    with open(config_path) as f:
        return json.load(f)


@app.get("/clients")
def list_clients():
    clients = [
        f.replace(".json", "") for f in os.listdir(CONFIG_DIR) if f.endswith(".json")
    ]
    return {"clients": clients}


@app.get("/health")
def health():
    return {"status": "ok"}
