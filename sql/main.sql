CREATE TABLE School(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(60) NOT NULL,
    number SMALLINT NOT NULL,
    voivodeship_id INT NOT NULL,
    city VARCHAR(60) NOT NULL,
    street VARCHAR(60) NOT NULL,
    post_code VARCHAR(8) NOT NULL CHECK (post_code ~ '^[0-9]{2}-[0-9]{3}$'),
    secretary_phone VARCHAR(15) NOT NULL,
    director_id INT NOT NULL,
    profile_id INT NOT NULL,    
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Klucze obce
    CONSTRAINT fk_school_voivodeship
        FOREIGN KEY (voivodeship_id)
        REFERENCES Voivodeships (id),

    CONSTRAINT fk_school_profile
        FOREIGN KEY (profile_id)
        REFERENCES School_profiles (id),

    CONSTRAINT fk_school_director
        FOREIGN KEY (director_id)
        REFERENCES Users (id)
);

CREATE TABLE Voivodeships(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(40) NOT NULL UNIQUE,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ 
);

CREATE TABLE School_profiles(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(60) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ 
);

CREATE TABLE Users(
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    user_role_id INT NOT NULL,
    login VARCHAR(64) NOT NULL,
    password VARCHAR(64) NOT NULL,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    user_address_id INT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Klucze obce
    CONSTRAINT fk_user_role
        FOREIGN KEY (user_role_id)
        REFERENCES User_roles (id),
        
    CONSTRAINT fk_user_address
        FOREIGN KEY (user_address_id)
        REFERENCES User_address (id)
);

CREATE TABLE User_roles(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(20) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ 
);

CREATE TABLE User_address(
    id INT PRIMARY KEY NOT NULL,
    city VARCHAR(60) NOT NULL,
    street VARCHAR(60) NOT NULL,
    home_number VARCHAR(3) NOT NULL,
    post_code VARCHAR(8) NOT NULL CHECK (post_code ~ '^[0-9]{2}-[0-9]{3}$'),
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ 
);

