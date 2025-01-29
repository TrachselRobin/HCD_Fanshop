const mysql = require('mysql2');

const connection = mysql.createConnection({
        host: process.env.MYSQL_HOST || "localhost",
        user: "root",
        database: process.env.MYSQL_DATABASE || "mydb",
        password: process.env.MYSQL_PASSWORD || "test"
    });

module.exports = connection;