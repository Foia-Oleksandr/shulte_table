CREATE TABLE session (
                         id INTEGER PRIMARY KEY,
                         beginAt INTEGER NOT NULL,
                         finishAt INTEGER NOT NULL,
                         complexity INTEGER NOT NULL,
                         mistakes INTEGER NOT NULL
);

CREATE TABLE result (
                        id INTEGER PRIMARY KEY,
                        session_id INTEGER NOT NULL REFERENCES session(id),
                        elapsed_minutes DOUBLE NOT NULL CHECK (elapsed_minutes > 0),
                        task_duration DOUBLE NOT NULL CHECK (task_duration > 0)
);


