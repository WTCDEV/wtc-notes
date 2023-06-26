const mysql = require("mysql");

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "wtc_notes",
  port: 3306,
});

db.connect((error) => {
  if (error) {
    console.error(error);
    return;
  }
  console.log("connect db");
});

module.exports = db;
