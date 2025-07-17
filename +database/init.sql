CREATE TABLE session (
                         id INTEGER PRIMARY KEY,
                         begin_at INTEGER NOT NULL,
                         finish_at INTEGER NOT NULL,
                         complexity INTEGER NOT NULL,
                         view TEXT NOT NULL DEFAULT 'NumericDecimal'
);

CREATE TABLE property (
    session_id INTEGER,
    value      TEXT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES session (id)
);

CREATE TABLE result (
                        id INTEGER PRIMARY KEY,
                        session_id INTEGER NOT NULL REFERENCES session(id),
                        elapsed_minutes DOUBLE NOT NULL CHECK (elapsed_minutes > 0),
                        task_duration DOUBLE NOT NULL CHECK (task_duration > 0),
                        mistakes INTEGER NOT NULL
);
