PRAGMA foreign_keys = on;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id)
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    author_id INTEGER NOT NULL,

    
    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (parent_id) REFERENCES replies(id)
    FOREIGN KEY ( author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes(
    id INTEGER PRIMARY KEY,
    likes TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id)
    FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Kush', 'Patel'),
    ('Min', 'Wang'),
    ('Collin', 'Winner');

INSERT INTO 
    questions (title, body, author_id)
VALUES
    ('Question1', 'Body1', (SELECT id FROM users WHERE fname ='Kush' AND lname ='Patel')),
    ('Question2', 'Body2', (SELECT id FROM users WHERE fname = 'Min' AND lname = 'Wang')),
    ('Question3', 'Body3', (SELECT id FROM users WHERE fname = 'Collin' AND lname = 'Winner'));

INSERT INTO
    question_follows(user_id, question_id)
VALUES
    ((SELECT id FROM users WHERE fname ='Kush' AND lname ='Patel'), (SELECT id FROM questions WHERE title = 'Question1')),
    ((SELECT id FROM users WHERE fname ='Min' AND lname ='Wang'), (SELECT id FROM questions WHERE title = 'Question2')),
    ((SELECT id FROM users WHERE fname ='Collin' AND lname ='Winner'), (SELECT id FROM questions WHERE title = 'Question3'));

INSERT INTO 
    replies(body, question_id, parent_id, author_id)
VALUES
    ('Reply1',  (SELECT id FROM questions WHERE title = 'Question1'), (SELECT id FROM replies WHERE parent_id = id), (SELECT id FROM users WHERE fname ='Kush' AND lname ='Patel')),
    ('Reply2',  (SELECT id FROM questions WHERE title = 'Question2'), (SELECT id FROM replies WHERE parent_id = id), (SELECT id FROM users WHERE fname ='Min' AND lname ='Wang')),
    ('Reply3',  (SELECT id FROM questions WHERE title = 'Question3'), (SELECT id FROM replies WHERE parent_id = id), (SELECT id FROM users WHERE fname ='Collin' AND lname ='Winner'));

INSERT INTO
    question_likes(likes, author_id, question_id)
VALUES
    ('liked', (SELECT id FROM users WHERE fname ='Collin' AND lname ='Winner'), (SELECT id FROM questions WHERE title = 'Question2')),
    ('liked', (SELECT id FROM users WHERE fname ='Min' AND lname ='Wang'), (SELECT id FROM questions WHERE title = 'Question2'));

