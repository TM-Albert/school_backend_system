import aiosqlite

DB_PATH = ""


async def get_db():
    connection = await aiosqlite.connect(DB_PATH)
    connection.row_factory = aiosqlite.Row

    try:
        async with connection.cursor() as cursor:
            yield cursor

        await connection.commit()
    except Exception as e:
        await connection.rollback()
        raise e

    finally:
        await connection.commit()
        await connection.close()
