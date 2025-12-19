from fastapi import Request


async def get_connection(request: Request):
    async with request.app.state.pool.acquire() as conn:
        yield conn


async def get_transaction(request: Request):
    async with request.app.state.pool.acquire() as conn:
        async with conn.transaction():
            yield conn
