CREATE TABLE muscles (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    group_id INTEGER
);

CREATE TABLE exercises (
    id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    group_id INTEGER
);

CREATE TABLE exercise_muscles (
    id INTEGER PRIMARY KEY,
    type VARCHAR(255),
    muscle_id INTEGER,
    exercise_id INTEGER
);

CREATE TABLE groups (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);

