INSERT_SCHOOL = """
INSERT INTO schools (
    id, name, number, voivodeship_id, city, street,
    post_code, secretary_phone, director_id, profile_id
)
VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
"""

SELECT_SCHOOL_BY_ID = """
SELECT * FROM schools
WHERE id = $1
"""

SELECT_ALL_SCHOOLS = """
SELECT * FROM schools
"""
