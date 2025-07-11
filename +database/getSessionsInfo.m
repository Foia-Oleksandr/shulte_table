function sessions = getSessionsInfo(limit)
if nargin == 0
    limit = 500;
end

lastSessionsQuery = "SELECT id, beginAt, finishAt, complexity FROM session ORDER BY id DESC LIMIT %d;";
query = sprintf(lastSessionsQuery, limit);
results = database.fetchData(query);

if isempty(results)
    sessions = model.SessionInfo(NaN, NaT, NaT, NaN, NaN);
else
    for k = height(results):-1:1
        sessions(k) = model.SessionInfo( ...
            results{k,'id'}, ...
            datetime(results{k, 'beginAt'}, 'ConvertFrom', 'posixtime'), ...
            datetime(results{k, 'finishAt'}, 'ConvertFrom', 'posixtime'), ...
            results{k, 'complexity'});
    end
end

mustBeA(sessions, "model.SessionInfo");
end
