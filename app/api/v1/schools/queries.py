INSERT_SCHOOL = """
INSERT INTO school (
    id, name, number, voivodeship_id, city, street,
    post_code, secretary_phone, director_id, profile_id
)
VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
"""
