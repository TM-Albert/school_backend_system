--
--
--
CREATE TYPE parent_relationship_type AS ENUM ('father', 'mother');

--
--
--
CREATE TABLE School(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(60) NOT NULL,
    number SMALLINT NOT NULL,
    voivodeship_id INT NOT NULL,
    city VARCHAR(60) NOT NULL,
    street VARCHAR(60) NOT NULL,
    post_code VARCHAR(8) NOT NULL CHECK (post_code ~ '^[0-9]{2}-[0-9]{3}$'),
    secretary_phone VARCHAR(15) NOT NULL,
    director_id INT,
    profile_id INT,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
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

CREATE TABLE Currencies(
    id INT PRIMARY KEY NOT NULL,
    value VARCHAR(5) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Departments(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(40) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE School_years(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(9) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Classroom(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(2) NOT NULL,
    school_year_id INT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Class_students(
    id INT PRIMARY KEY NOT NULL,
    class_id INT NOT NULL,
    student_id INT NOT NULL,
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Subjects(
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Subject_lessons_plan(
    id INT PRIMARY KEY NOT NULL,
    subject_id INT NOT NULL,
    description TEXT,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Users(
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    user_role_id INT NOT NULL,
    school_id INT NOT NULL,
    login VARCHAR(64) NOT NULL,
    password VARCHAR(64) NOT NULL,
    user_address_id INT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
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

CREATE TABLE Director_details(
    id INT PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    date_of_appointment DATE NOT NULL,
    mandate_expiry_date DATE NOT NULL,
    contact_email_official VARCHAR(255),
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Student_details(
    id INT PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    grade_level SMALLINT NOT NULL,
    pesel VARCHAR(64) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Parent_details(
    id INT PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    student_id INT NOT NULL,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    relationship_to_student parent_relationship_type NOT NULL,
    emergency_contact_priority BOOLEAN NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_parent_user
        FOREIGN KEY (user_id)
        REFERENCES Users (id),

    CONSTRAINT fk_parent_student_details
        FOREIGN KEY (student_id)
        REFERENCES Student_details(id)
);

CREATE TABLE Teacher_details(
    id INT PRIMARY KEY NOT NULL,
    user_id UUID NOT NULL,
    name VARCHAR(40) NOT NULL,
    surname VARCHAR(40) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    pesel VARCHAR(64) NOT NULL,
    base_salary NUMERIC NOT NULL,
    currency_id INT NOT NULL,
    department_id INT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_teacher_user
        FOREIGN KEY (user_id)
        REFERENCES Users (id),

    CONSTRAINT fk_teacher_currency
        FOREIGN KEY (currency_id)
        REFERENCES Currencies (id),

    CONSTRAINT fk_teacher_department
        FOREIGN KEY (department_id)
        REFERENCES Departments (id)
);

CREATE TABLE Periods(
    id INT PRIMARY KEY NOT NULL,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ
);

CREATE TABLE Lessons(
    id INT PRIMARY KEY NOT NULL,
    class_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    week_day SMALLINT NOT NULL,
    period_id INT NOT NULL,
    is_active BOOLEAN NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_lessons_class
        FOREIGN KEY (class_id)
        REFERENCES Classroom (id),

    CONSTRAINT fk_lessons_subject
        FOREIGN KEY (subject_id)
        REFERENCES Subjects (id),

    CONSTRAINT fk_lessons_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES Teacher_details (id)
);

CREATE TABLE Attendance(
    id INT PRIMARY KEY NOT NULL,
    lesson_id INT NOT NULL,
    student_id INT NOT NULL,
    status VARCHAR(10) NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_attendance_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES Lessons (id),

    CONSTRAINT fk_attendance_student
        FOREIGN KEY (student_id)
        REFERENCES Student_details (id)
);

CREATE TABLE Teacher_absence(
    id INT PRIMARY KEY NOT NULL,
    teacher_id INT NOT NULL,
    date DATE NOT NULL,
    reason TEXT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_teacher_absence_teacher
        FOREIGN KEY (teacher_id)
        REFERENCES Teacher_details (id)
);

CREATE TABLE Teacher_replacement(
    id INT PRIMARY KEY NOT NULL,
    absence_id INT NOT NULL,
    replacement_teacher_id INT NOT NULL,
    lesson_id INT NOT NULL,
    creation_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_date TIMESTAMPTZ,
    deleted_date TIMESTAMPTZ,

    -- Foreign keys
    CONSTRAINT fk_teacher_replacement_absence
        FOREIGN KEY (absence_id)
        REFERENCES Teacher_absence (id),

    CONSTRAINT fk_teacher_replacement_teacher
        FOREIGN KEY (replacement_teacher_id)
        REFERENCES Teacher_details (id),

    CONSTRAINT fk_teacher_replacement_lesson
        FOREIGN KEY (lesson_id)
        REFERENCES Lessons (id)
);

CREATE TABLE Refresh_tokens(
    id BIGINT PRIMARY KEY NOT NULL,
    token_hash CHAR(64) NOT NULL UNIQUE,
    user_id UUID NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    is_revoked BOOLEAN NOT NULL DEFAULT FALSE,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_ip INET,
    device_info VARCHAR(255),

    -- Foreign keys
    CONSTRAINT fk_refresh_tokens_user
        FOREIGN KEY (user_id)
        REFERENCES Users (id)
);

ALTER TABLE School
ADD CONSTRAINT fk_school_voivodeship
    FOREIGN KEY (voivodeship_id) REFERENCES Voivodeships (id),

ADD CONSTRAINT fk_school_profile
    FOREIGN KEY (profile_id) REFERENCES School_profiles (id),

ADD CONSTRAINT fk_school_director
    FOREIGN KEY (director_id) REFERENCES Director_details (id);


ALTER TABLE Classroom
ADD CONSTRAINT fk_classroom_school_year
    FOREIGN KEY (school_year_id) REFERENCES School_years (id);


ALTER TABLE Class_students
ADD CONSTRAINT fk_class_students_classroom
    FOREIGN KEY (class_id) REFERENCES Classroom (id),

ADD CONSTRAINT fk_class_students_student
    FOREIGN KEY (student_id) REFERENCES Student_details (id);


ALTER TABLE Subject_lessons_plan
ADD CONSTRAINT fk_subject_lessons_plan_subject
    FOREIGN KEY (subject_id) REFERENCES Subjects (id);


ALTER TABLE Users
ADD CONSTRAINT fk_user_school
    FOREIGN KEY (school_id) REFERENCES School (id),

ADD CONSTRAINT fk_user_role
    FOREIGN KEY (user_role_id) REFERENCES User_roles (id),

ADD CONSTRAINT fk_user_address
    FOREIGN KEY (user_address_id) REFERENCES User_address (id);


ALTER TABLE Director_details
ADD CONSTRAINT fk_director_details_user
    FOREIGN KEY (user_id) REFERENCES Users (id);


ALTER TABLE Student_details
ADD CONSTRAINT fk_student_details_user
    FOREIGN KEY (user_id) REFERENCES Users (id);
