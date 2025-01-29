/*
  AUTHOR:  Robin Trachsel
  VERSION: 1.0
  DATE:    28.01.2025

  DESCRIPTION: Dies ist das Grundgerüst des gesamten Backends
*/

// NodeJS modules
const express = require('express');
const cors = require('cors');
require('dotenv').config();

// Specific modules
const connection = require('./modules/createSqlConnection.js');
const corsOptions = require('./modules/corsOptions.js');

const app = express();
const PORT = process.env.BACKEND_PORT || 3000;

app.use(cors(corsOptions));

app.get('/', async (req, res) => {
  const table_name = "test";
  const sql = 'CALL SelectAllFromTable(?);';

  connection.query(sql, [table_name], (error, results) => {
    if (error) {
      return res.status(500).send("Datenbankfehler")
    }
    res.json(results[0])
  });
});

app.listen(PORT, () => {
  console.log(`Backend running at http://localhost:${PORT}`);
});