const express = require('express');
const path = require('path');
require('dotenv').config(); // Environment Variable Setting
const cookieParser = require('cookie-parser');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, './')));

require('http').createServer(app).listen(process.env.PORT, () => {
    console.log('Http Server Start, Port: ' + process.env.PORT);
})