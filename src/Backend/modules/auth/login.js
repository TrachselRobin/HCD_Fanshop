/*
  AUTHOR:               Robin Trachsel
  DATE:                 20.05.2025
  DESCRIPTION:          Endpoints for Authentification
  VERSION:              1.0
*/

const express = require('express');
const bcrypt = require('bcrypt');
const connection = require('../createSqlConnection');
const { signToken } = require('./jwt');

const router = express.Router();

router.post('/login', (req, res) => {
    const { email, password } = req.body;
    const sql = `SELECT user.*, role.name as role FROM user JOIN role ON user.roleID = role.ID WHERE email = ?`;

    connection.query(sql, [email], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(401).send({ error: 'Ungültige Anmeldedaten' });
        }

        const user = results[0];
        const match = await bcrypt.compare(password, user.password);
        if (!match) {
            return res.status(401).send({ error: 'Passwort falsch' });
        }

        const token = signToken(user);
        res.status(200).send({ message: 'Login erfolgreich', token: token });
    });
});

router.delete('/logout', (req, res) => {
    // Bei JWT ist Logout clientseitig – Token einfach verwerfen
    res.status(200).send({ message: 'Logout erfolgreich (Client löscht Token)' });
});

module.exports = router;
