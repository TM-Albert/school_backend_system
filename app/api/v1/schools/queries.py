INSERT_SCHOOL = """
INSERT INTO schools (
    id, name, number, voivodeship_id, city, street,
    post_code, secretary_phone, director_id, profile_id
)
VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
"""

SELECT_SCHOOL_BY_ID = """
SELECT s.name, s.number, v.voivodeship_name, s.city, s.street, s.post_code, s.secretary_phone, dd.director_name, dd.director_surname, p.profile_name FROM schools AS s
LEFT JOIN Voivodeships as s ON s.voivodeship_id = s.voivodeship_id
LEFT JOIN Director_details as dd ON dd.id = s.director_id
LEFT JOIN School_profiles as p ON p.id = s.profile_id
WHERE id = $1
"""

SELECT_ALL_SCHOOLS = """
SELECT * FROM schools
"""
