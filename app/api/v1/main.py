from contextlib import asynccontextmanager

import asyncpg
from fastapi import FastAPI


@asynccontextmanager
async def lifespan(app: FastAPI):
    app.state.pool = await asyncpg.create_pool("DATABASE_URL", min_size=5, max_size=20)
    yield
    await app.state.pool.close()


app = FastAPI(lifespan=lifespan)
