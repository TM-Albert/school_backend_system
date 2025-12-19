import os
from contextlib import asynccontextmanager

import asyncpg
from fastapi import FastAPI

DB_URL = os.getenv("DATABASE_URL")


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.pool = await asyncpg.create_pool(DB_URL, min_size=5, max_size=20)
    yield
    await app.state.pool.close()


app = FastAPI(lifespan=lifespan)
