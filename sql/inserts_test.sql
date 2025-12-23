INSERT INTO voivodeships (name) VALUES
('Dolnośląskie'),
('Kujawsko-Pomorskie'),
('Lubelskie'),
('Lubuskie'),
('Łódzkie'),
('Małopolskie'),
('Mazowieckie'),
('Opolskie'),
('Podkarpackie'),
('Podlaskie'),
('Pomorskie'),
('Śląskie'),
('Świętokrzyskie'),
('Warmińsko-Mazurskie'),
('Wielkopolskie'),
('Zachodniopomorskie');


INSERT INTO school_profiles (name) VALUES
('Technik Programista'),
('Technik Informatyk'),
('Technik Elektronik'),
('Technik Mechatronik'),
('Technik Ekonomista'),
('Technik Logistyk'),
('Technik Budownictwa'),
('Gastronomia'),
('Hotelarstwo'),
('Liceum Ogólnokształcące');


INSERT INTO departments (name) VALUES
('IT'),
('Administracja'),
('Finanse'),
('Kadry'),
('Edukacja'),
('Techniczne'),
('Gastronomia');


INSERT INTO currencies (value) VALUES
('PLN'),
('EUR'),
('USD');


INSERT INTO School (
    name,
    number,
    voivodeship_id,
    city,
    street,
    post_code,
    secretary_phone,
    director_id,
    profile_id
)
VALUES
(
    'Zespół Szkół Technicznych',
    101,
    7,
    'Warszawa',
    'ul. Nowoczesna 10',
    '00-001',
    '+48 221 224 567',
    NULL,
    1
),
(
    'Technikum Informatyczne',
    202,
    12,
    'Katowice',
    'ul. Techniczna 5',
    '40-001',
    '+48 329 876 543',
    NULL,
    2
),
(
    'Szkoła Branżowa Gastronomiczna',
    303,
    16,
    'Szczecin',
    'ul. Smakoszy 8',
    '70-001',
    '+48 915 554 433',
    NULL,
    8
);
