const { verifyToken } = require('./jwt');

function verify(...allowedRoles) {
    return (req, res, next) => {
        const authHeader = req.headers.authorization;
        if (!authHeader) return res.status(401).send({ error: 'Not logged in' });

        const token = authHeader.split(' ')[1];
        try {
            const user = verifyToken(token);
            if (allowedRoles.length > 0 && !allowedRoles.includes(user.role)) {
                return res.status(403).send({ error: 'No access' });
            }
            req.user = user;
            next();
        } catch (err) {
            return res.status(401).send({ error: 'Invalid session' });
        }
    };
}

module.exports = verify;
