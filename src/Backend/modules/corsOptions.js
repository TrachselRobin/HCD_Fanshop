const whitelist = require('../data/urlWhitelist.json'); // Whitelist importieren

const corsOptions = {
    optionsSuccessStatus: 200,
    methods: 'GET, POST, DELETE',
    allowedHeaders: 'Content-Type',
    credentials: true,
    preflightContinue: false,
    origin: function (origin, callback) {
        if (whitelist.includes(origin) || !origin) {
            callback(null, true);
        } else {
            callback(new Error('Not allowed by CORS'));
        }
    }
};

module.exports = corsOptions;
