/*
  AUTHOR:               Robin Trachsel
  DATE:                 20.05.2025
  DESCRIPTION:          Endpoints for Authentification
  VERSION:              1.0
*/

const express = require('express')
const mysql = require('mysql2');

const router = express.Router()

function verifyAuth(req, res, next) {
    console.log('Verifying authentication...')
}

router.post('/login', (req, res) => {
    res.status(200).send({ message: 'Login successful' })
})

router.delete('/logout', (req, res) => {
    res.status(200).send({ message: 'Logout successful' })
})

router.get('/verify', verifyAuth, (req, res) => {
    verifyAuth(req, res, next)
    res.status(200).send({ message: 'User is authenticated' })
})

module.exports = [
    router,
    verifyAuth
]

const connection = mysql.createConnection({
    host: process.env.MYSQL_HOST || "localhost",
    user: "root",
    database: process.env.MYSQL_DATABASE || "mydb",
    password: process.env.MYSQL_PASSWORD || "test"
});