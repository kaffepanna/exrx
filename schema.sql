CREATE TABLE muscles (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE exercises (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    description TEXT
);

CREATE TABLE exercise_muscles (
    id INTEGER PRIMARY KEY,
    type VARCHAR(255),
    muscle_id INTEGER,
    exercise_id INTEGER
);

