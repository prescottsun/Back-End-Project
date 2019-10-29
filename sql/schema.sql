-- Database name: back_end_project

-- DROP TABLE users;
-- DROP TABLE reviews;
-- DROP TABLE resources;
-- DROP TABLE activity_log;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,

    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    email VARCHAR(200),
    password VARCHAR(200),
    about VARCHAR(500),

    profile_picture VARCHAR(200)
    -- status VARCHAR(200),
    -- study_points INTEGER
    -- group/friends list

);

CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    resource_id INTEGER REFERENCES resources(id),

    stars DECIMAL CHECK (stars >= 1 and stars <=5),
    content VARCHAR(500)

);

CREATE TABLE resources (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    type VARCHAR(200),
    description VARCHAR(500),
    url VARCHAR(200)    

);

CREATE TABLE activity_log (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    resource_id INTEGER REFERENCES resources(id),

    activity_name VARCHAR(200),
    activity_description VARCHAR(500),
    date_completed DATE DEFAULT NOW(),
    hours_spent DECIMAL DEFAULT 0
);


-- Inserts for created 3 users, 7 resources, 10 reviews, 10 activities
INSERT INTO users (first_name, last_name, email, password, about)
    VALUES ('test', 'test', 'test@gmail.com', 'test', 'test')
    ;

INSERT INTO resources (title, type, description, url)
    VALUES ('Build A Restful Api With Node.js Express & MongoDB', 'Video tutorial', 'A video tutorial on RESTful Node APIs', 'https://www.youtube.com/watch?v=vjf774RKrLc')
    ,('Topics of Javascript/ES6-8', 'Video tutorials', 'Youtube tutorials by The Coding Train on different Javascript topcs', 'https://www.youtube.com/playlist?list=PLRqwX-V7Uu6YgpA3Oht-7B4NBQwFVe3pr')
    ,( 'Node JS Tutorial for Beginners', 'Video tutorials', 'Youtube tutorials by The Net Ninja on using Node.js', 'https://www.youtube.com/playlist?list=PL4cUxeGkcC9gcy9lrvMJ75z9maRw4byYp')
    ,('Hashing in Action: Understanding bcrypt', 'Article', 'Blog article going in-depth on the usage of bcrypt', 'https://auth0.com/blog/hashing-in-action-understanding-bcrypt/')
    ,("You Don't Know JS" , 'Book series', 'Book series by Kyle Simpson on Javascript', 'https://github.com/getify/You-Dont-Know-JS')
    ,( 'Designing a RESTful API with Node and Postgres', 'Article', 'Blog tutorial on using Node and PSQL to create a RESTful API', 'https://mherman.org/blog/designing-a-restful-api-with-node-and-postgres/#postgres-setup')
    ,( 'Crash Course Computer Science', 'Video series', 'Animated Youtube series covering various topics on the history and theory of computer science', 'https://www.youtube.com/playlist?list=PL8dPuuaLjXtNlUrzyH5r6jN9ulIgZBpdo')
    ;

INSERT INTO reviews (user_id, resource_id, stars, content)
    VALUES (1, 1, 5, 'This helped me learn a lot')
    ,(1, 2, 4, 'This was very interesting')
    ,(1, 4, 2, 'I did not find this that helpful')
    ,(2, 3, 5, 'This helped clarify the topic for me')
    ,(2, 2, 4, 'This is worth checkout out')
    ,(1, 6, 1, 'I could not understand this')
    ,(3, 7, 5, 'The material was very engaging')
    ,(3, 5, 3, 'This was ok')
    ,(2, 6, 4, 'Great')
    ,(3, 2, 5, 'Fantastic. 5 stars')
    ;

INSERT INTO activity_log (user_id, resource_id, activity_name, activity_description, date_completed, hours_spent)
    VALUES (1, 1, 'Watched a video tutorial', 'Watched a video tutorial on creating an API with the NEP stack', '10/23/2019', 2)
    ,(1, 2, 'Watched video tutorials', 'Watched video tutorials on different topics of Javascript', '10/25/2019', 3)
    ,(1, 4, 'Read an article', 'Read an article on bcrypt', '10/26/2019', 1)
    ,(2, 3, 'Watched video tutorials', 'Watched a Youtube series on using Node.js', '10/20/2019', 4)
    ,(2, 2, 'Read an article', 'Read a blog article on how to use bcrypt', '10/27/2019', 1)
    ,(1, 6, 'Read blog article', 'Read an article on designing RESTful APIs with Node and PSQL', '10/18/2019', 2)
    ,(3, 7, 'Watched video series', 'Watched videos from a Youtube series covering fundamental concepts of computer science', '10/22/2019', 3)
    ,(3, 5, 'Read book series', 'Read from a few chapters from a book series on Javascript', '10/16/2019', 2)
    ,(2, 6, 'Read article', 'Read an online article on Node and Postgres', '10/19/2019', 1)
    ,(3, 2, 'Watched Youtube series', 'Watched Youtube tutorials from The Coding Train on various topics relating to Javascript', '10/15/2019', 5)
    ;
