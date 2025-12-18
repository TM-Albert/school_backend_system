GET_USER_BY_ID = """
SELECT id, email, is_active
FROM users
WHERE id = $1
"""
