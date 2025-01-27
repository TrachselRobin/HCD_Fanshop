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
  const table_name = "test";
  const sql = 'CALL SelectAllFromTable(?);';

  connection().query(sql, [table_name], (error, results) => {
    if (error) {
      return res.status(500).send("Datenbankfehler")
    }
    res.json(results[0])
  });
});

app.listen(PORT, () => {
  console.log(`Backend running at http://localhost:${PORT}`);
});

function connection() {
  return mysql.createConnection({
    host: process.env.MYSQL_HOST || "localhost",
    user: "root",
    database: process.env.MYSQL_DATABASE || "mydb",
    password: process.env.MYSQL_PASSWORD || "test"
  });
}