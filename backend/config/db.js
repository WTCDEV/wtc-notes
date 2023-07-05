require('dotenv').config();
const mysql = require("mysql");

const db = mysql.createConnection({
  host: process.env.MYSQL_HOST,
  user: process.env.MYSQL_USERNAME,
  password: process.env.MYSQL_PASSWORD,
  database: process.env.MYSQL_DB,
  port: process.env.MYSQL_PORT,
});

db.connect((error) => {
  if (error) {
    console.error(error);
    return;
  }
  console.log("connect db");
});

module.exports = db;
