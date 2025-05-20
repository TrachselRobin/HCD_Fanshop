/*
  AUTHOR:               Robin Trachsel
  DATE:                 20.05.2025
  DESCRIPTION:          Main entry point for the backend
  VERSION:              1.0
*/

require('dotenv').config();
const express = require('express');
const cors = require('cors');

const corsOptions = require('./config/corsOptions'); // Pfad ggf. anpassen

const login = require('./modules/auth/login');
const test = require('./modules/test');
const verify = require('./modules/auth/verify');

const app = express();
const port = 3000;

app.use(cors(corsOptions));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.use('/auth', logRequest, login);
app.use('/test', logRequest, verify("Administrator", "Benutzer"), test); // Beispiel-Schutz

app.listen(port, () => {
    console.log(`Backend läuft auf http://localhost:${port}`);
});

function logRequest(req, res, next) {
    console.log(`${req.method} ${req.url}`);
    next();
}