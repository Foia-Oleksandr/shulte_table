function result = fetchData(query)
    conn = sqlite(model.Config.databaseFilename, "connect");
    result = fetch(conn, query);
    close(conn);
end
