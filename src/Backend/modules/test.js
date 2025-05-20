/*
  AUTHOR:               Robin Trachsel
  DATE:                 20.05.2025
  DESCRIPTION:          Endpoints for Authentification
  VERSION:              1.0
*/

const express = require('express')
const connection = require('./createSqlConnection')

const router = express.Router()

function verifyAuth(req, res, next) {
    console.log('Verifying authentication...')
}

router.get('/database', (req, res) => {
    const sql = 'SELECT * FROM user WHERE id = ?'
    const values = [req.session.userId]
    
    connection.query(sql, values, (err, results) => {
        if (err) {
            console.error('Error executing query:', err)
            return res.status(500).send({ error: 'Database error' })
        }
        res.status(200).send({ data: results })
    })
})

module.exports = [
    router,
    verifyAuth
]