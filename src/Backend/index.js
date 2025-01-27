const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config();

const app = express();
const PORT = process.env.BACKEND_PORT || 3000;

const whitelist = [
  'http://localhost', 
  process.env.PUBLISHED_URL
]

const corsOptions = {
  origin: function (origin, callback) {
    if (whitelist.indexOf(origin) !== -1 || !origin) {
      callback(null, true)
    } else {
      callback(new Error('Not allowed by CORS'))
    }
  },
  optionsSuccessStatus: 200,
  methods: 'GET, POST, DELETE',
  allowedHeaders: 'Content-Type',
  credentials: true,
  preflightContinue: false
}

app.use(cors(corsOptions));

app.get('/', async (req, res) => {
  const sql = 'SELECT * FROM test;';

  const result = await sqlQuery(sql)

  res.send(result)
});

app.listen(PORT, () => {
  console.log(`Backend running at http://localhost:${PORT}`);
});

async function sqlQuery(sql) {
  return new Promise((resolve, reject) => {
    const connection = mysql.createConnection({
      host: process.env.MYSQL_HOST || "localhost",
      user: "root",
      database: process.env.MYSQL_DATABASE || "mydb",
      password: process.env.MYSQL_PASSWORD || "test"
    });

    connection.connect((err) => {
      if (err) {
        reject(err);
        return;
      }

      connection.query(sql, (error, results, fields) => {
        if (error) {
          reject(error);
        } else {
          resolve(results);
        }
        connection.end();
      });
    });
  });
}