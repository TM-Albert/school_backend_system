import sys
from contextlib import asynccontextmanager

import asyncpg
from env import get_database_connection_link
from fastapi import FastAPI
from schools import schools


@asynccontextmanager
async def lifespan(app: FastAPI):
    DB_CONNECTION_LINK: str | None = get_database_connection_link()

    if DB_CONNECTION_LINK is None:
        sys.exit(1)

    app.state.pool = await asyncpg.create_pool(
        DB_CONNECTION_LINK, min_size=5, max_size=20
    )

    try:
        yield
    finally:
        await app.state.pool.close()


app = FastAPI(lifespan=lifespan)

app.include_router(schools.router)
