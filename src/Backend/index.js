/*
  VERSION:              Robin Trachsel
  DATE:                 19.04.2023
  LEISTUNGSBEURTEILUNG: B
  DESCRIPTION:          JS-Server for Haputanforderungen and Authentifizierung
*/

require('dotenv').config()

const express = require('express')
const session = require('express-session')


const login = require('./modules/login')
const test = require('./modules/test')

const app = express()
const port = 3000

app.use(session({ secret: 'geheim', resave: false, saveUninitialized: true }))
app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.use('/tasks', login)
app.use('/test', test)

app.get('*', (req, res) => {
    res.status(404).send({ error: 'Endpoint not found' })
})

app.listen(port, () => {
    console.log(`Backend listening at http://localhost:${port}`)
})