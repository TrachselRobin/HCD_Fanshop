/*
  AUTHOR:               Robin Trachsel
  DATE:                 20.05.2025
  DESCRIPTION:          Endpoints for Testing
  VERSION:              1.0
*/

const express = require('express');
const connection = require('./createSqlConnection');
const router = express.Router();

router.get('/database', (req, res) => {
    const sql = 'SELECT * FROM user WHERE id = ?';
    const values = [req.user.id]; // aus verify-Middleware

    connection.query(sql, values, (err, results) => {
        if (err) {
            return res.status(500).send({ error: 'Datenbankfehler' });
        }
        res.status(200).send({ data: results });
    });
});

module.exports = router;
