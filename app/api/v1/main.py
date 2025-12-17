from contextlib import asynccontextmanager

from fastapi import FastAPI


def load():
    print("load")


@asynccontextmanager
async def lifespan(app: FastAPI):
    load()
    yield
    print("shutdown")


app = FastAPI(lifespan=lifespan)
