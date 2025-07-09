function storeSessionToDatabase(session)
arguments
    session (1,1) model.Session
end
conn = getConnection();

storeSessionInfo(conn, session.beginAt, session.finishAt, session.complexity, session.mistakes);

sessionId = getSessionId(conn);

for i = 1 : length(session.taskDurations(1, :))
    storeTaskDuration(conn, sessionId, session.taskDurations(:, i));
end

close(conn);

end

function conn = getConnection()
conn = sqlite(model.Config.databaseFilename, "connect");
end

function storeSessionInfo(conn, startTime, finishAt, complexity, mistakes)
execute(conn, sprintf( ...
    "INSERT INTO session(startAt, finishAt, complexity, mistakes) VALUES(%d, %d, %d, %d);", ...
    uint64(round(posixtime(startTime))), ...
    uint64(round(posixtime(finishAt))), ...
    complexity, ...
    mistakes));
end

function sessionId = getSessionId(conn)
sessionId = fetch(conn, 'SELECT last_insert_rowid() as ID;').("ID");
end

function storeTaskDuration(conn, sessionId, taskDuration)
    execute(conn, sprintf( ...
        "INSERT INTO result(session_id, elapsed_minutes, task_duration) VALUES(%d, %d, %d)", ...
        sessionId, ...
        taskDuration(1), ...
        taskDuration(2)));
end
