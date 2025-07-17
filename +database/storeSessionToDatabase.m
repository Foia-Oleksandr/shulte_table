function storeSessionToDatabase(session)
arguments
    session (1,1) model.Session
end
conn = getConnection();

storeSessionInfo(conn, session.beginAt, session.finishAt, session.complexity, session.view);

sessionId = getSessionId(conn);

for k = 1 : numel(session.orderProperties)
    storeOrderProperties(conn, sessionId, session.orderProperties(k));
end

for k = 1 : length(session.taskDurations(1, :))
    storeTaskDuration(conn, sessionId, session.taskDurations(k));
end

close(conn);

end

function conn = getConnection()
conn = sqlite(model.Config.databaseFilename, "connect");
end

function storeSessionInfo(conn, startTime, finishAt, complexity, view)
execute(conn, sprintf( ...
    "INSERT INTO session(begin_at, finish_at, complexity, view) VALUES(%d, %d, %d, '%s');", ...
    uint64(round(posixtime(startTime))), ...
    uint64(round(posixtime(finishAt))), ...
    complexity, ...
    view));
end

function sessionId = getSessionId(conn)
sessionId = fetch(conn, 'SELECT last_insert_rowid() as ID;').("ID");
end

function storeOrderProperties(conn, sessionId, orderProperty)
arguments
    conn 
    sessionId
    orderProperty (1, 1) model.ShulteTableOrder
end
    execute(conn, sprintf( ...
        "INSERT INTO property(session_id, value) VALUES(%d, '%s')", ...
        sessionId, ...
        orderProperty));
end

function storeTaskDuration(conn, sessionId, taskDuration)
arguments
    conn 
    sessionId
    taskDuration (1, 1) model.TaskDuration
end
    execute(conn, sprintf( ...
        "INSERT INTO result(session_id, elapsed_minutes, task_duration, mistakes) VALUES(%d, %d, %d, %d)", ...
        sessionId, ...
        taskDuration.elapsed, ...
        taskDuration.duration, ...
        taskDuration.mistakes));
end
