const express = require("express");
const cors = require("cors");
const app = express();
const port = 3000;
const routes = require("@routes/routes");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use(routes);

app.listen(port, () => {
  console.log(`running on port : ${port}`);
});
