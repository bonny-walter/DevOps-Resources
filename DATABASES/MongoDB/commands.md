### Summary of Useful MongoDB CLI Commands

    show databases  : Lists all databases.

    use <database> : Switches to a specific database.

    show collections : Lists all collections in the current database.

    db.stats() : Displays general stats about the current database.

    db.<collection>.stats() : Displays stats for a specific collection.

    db.<collection>.getIndexes() : Lists all indexes for a collection.

    db.<collection>.find() : Retrieves documents from a collection.

    db.runCommand({ connectionStatus: 1 }) :Retrieves information about the current user.

    db.serverStatus() : Retrieves information about the MongoDB server.
    
    db.getName() : Returns the name of the current database.

