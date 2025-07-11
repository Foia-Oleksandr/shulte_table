function session = getSession(id)
arguments
    id (1,1) uint64
end

sessionQueryTemplate = "SELECT id, beginAt, finishAt, complexity FROM session WHERE id = %d;";
sessionQuery = sprintf(sessionQueryTemplate, id);
sessionResult = database.fetchData(sessionQuery);

taskDurationsQueryTemplate = "SELECT elapsed_minutes, task_duration, mistakes FROM result WHERE session_id = %d ORDER BY id ASC;";
taskDurationsQuery = sprintf(taskDurationsQueryTemplate, id);
results = database.fetchData(taskDurationsQuery);

if isempty(results)
    taskDurations = model.TaskDuration.empty;
else
    for k = height(results):-1:1
        taskDurations(k) = model.TaskDuration( ...
            results{k,'elapsed_minutes'}, ...
            results{k, 'task_duration'}, ...
            results{k, 'mistakes'});
    end
end

session = model.Session( ...
            sessionResult.id, ...
            datetime(sessionResult.beginAt, 'ConvertFrom', 'posixtime'), ...
            datetime(sessionResult.finishAt, 'ConvertFrom', 'posixtime'), ...
            sessionResult.complexity, ...
            taskDurations);

mustBeA(session, "model.Session");
end
