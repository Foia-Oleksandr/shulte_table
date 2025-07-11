function storeSessionToDatabase(session)
arguments
    session (1,1) model.Session
end
conn = getConnection();

storeSessionInfo(conn, session.beginAt, session.finishAt, session.complexity);

sessionId = getSessionId(conn);

for i = 1 : length(session.taskDurations(1, :))
    storeTaskDuration(conn, sessionId, session.taskDurations(i));
end

close(conn);

end

function conn = getConnection()
conn = sqlite(model.Config.databaseFilename, "connect");
end

function storeSessionInfo(conn, startTime, finishAt, complexity)
execute(conn, sprintf( ...
    "INSERT INTO session(beginAt, finishAt, complexity) VALUES(%d, %d, %d);", ...
    uint64(round(posixtime(startTime))), ...
    uint64(round(posixtime(finishAt))), ...
    complexity));
end

function sessionId = getSessionId(conn)
sessionId = fetch(conn, 'SELECT last_insert_rowid() as ID;').("ID");
end

function storeTaskDuration(conn, sessionId, taskDuration)
arguments
    conn 
    sessionId
    taskDuration (1, :) model.TaskDuration
end
    execute(conn, sprintf( ...
        "INSERT INTO result(session_id, elapsed_minutes, task_duration, mistakes) VALUES(%d, %d, %d, %d)", ...
        sessionId, ...
        taskDuration.elapsed, ...
        taskDuration.duration, ...
        taskDuration.mistakes));
end
