const jwt = require('jsonwebtoken');

const secret = process.env.JWT_SECRET || 'supergeheim';

function signToken(user) {
    return jwt.sign({ id: user.ID, role: user.role }, secret, { expiresIn: '2h' });
}

function verifyToken(token) {
    return jwt.verify(token, secret);
}

module.exports = { signToken, verifyToken };
