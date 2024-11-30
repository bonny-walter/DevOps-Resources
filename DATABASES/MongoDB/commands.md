Basic Database Operations
### Show all databases 
        show dbs

### Switch to a database 
        use <database_name>

### Create a database or collection
MongoDB creates them automatically when you insert a document.

### Show all collections in the current database

        show collections

### Drop a database

        db.dropDatabase()

                                              Collection Operations

### Insert a document

        db.<collection_name>.insert({ key: "value" })

### Find all documents in a collection

        db.<collection_name>.find()

### Find documents with a filter

        db.<collection_name>.find({ key: "value" })

### Count documents in a collection

        db.<collection_name>.countDocuments()

### Update a document

        db.<collection_name>.updateOne({ key: "value" }, { $set: { newKey: "newValue" } })

### Delete a document

        db.<collection_name>.deleteOne({ key: "value" })

### Drop a collection

        db.<collection_name>.drop()

                                                    Indexing

### Create an index

        db.<collection_name>.createIndex({ key: 1 }) // 1 for ascending, -1 for descending

### View indexes

        db.<collection_name>.getIndexes()

### Drop an index

        db.<collection_name>.dropIndex("index_name")

                                                  Admin Operations

### Check server status

        db.serverStatus()

### View current operations

        db.currentOp()

### Kill a specific operation

        db.killOp(<operation_id>)

### Create a user

        db.createUser({
            user: "username",
            pwd: "password",
            roles: [{ role: "readWrite", db: "database_name" }]
        })

### List users

        db.getUsers()
show
### Drop a user

        db.dropUser("username")

                                               Backup and Restore

### export data from a collection

        mongodump --db <database_name> --collection <collection_name> --out <path>

### Import data to a collection

        mongorestore --db <database_name> <path>

                                                Performance Monitoring

### Enable profiling

        db.setProfilingLevel(2)

### View profiling information

        db.system.profile.find()

                                               Connection Management

### Connect to MongoDB with authentication

        mongo -u <username> -p <password> --authenticationDatabase <auth_db>

### Connect to a specific host and port

        mongo --host <host> --port <port>

