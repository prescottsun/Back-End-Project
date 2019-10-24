-- Database name: back_end_project
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(200),
    password VARCHAR(200),
    description VARCHAR(500),

    profile_picture,
    status,
    points,
    friends
);
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    rating INTEGER,
    content TEXT,
    user_id INTEGER REFERENCES users(id),
    resource_id


);

CREATE TABLE resources (
    id SERIAL PRIMARY KEY,

    title,
    url,

);
CREATE TABLE activity_log (
    id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    project_content VARCHAR,
    user_id INTEGER REFERENCES users(id),
    resource_id,
    reviews_id

    activity_type,
    date_completed,
    time_spent,

);

