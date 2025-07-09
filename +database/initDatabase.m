function initDatabase()
    import model.Config
    if ~exist(Config.databaseFilename, "file")
        conn = sqlite(Config.databaseFilename, "create");
        initDatabaseTables(conn);
        close(conn);
        disp("Initialized data base.")
    end
end

function initDatabaseTables(conn)
    import model.Config
    filePath = fullfile("+database", Config.databaseInitScript);
    queryScript = fileread(filePath);
    [queries, matchedFragments] = split(queryScript, ";" + newline);
    for i = 1 : length(matchedFragments)
        query = queries(i);
        execute(conn, string(query) + ";");
    end
end
