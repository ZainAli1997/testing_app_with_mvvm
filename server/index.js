const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const http = require("http");
const authRouter = require("./routes/auth");
const postRouter = require("./routes/post");

const PORT = process.env.PORT | 3001;

const app = express();
var server = http.createServer(app);

app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(postRouter);

const DB =
  "mongodb+srv://abdulsarfraz82:sarfraz123@cluster0.fdhikxx.mongodb.net/";

mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection successful!");
  })
  .catch((err) => {
    console.log(err);
  });

server.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});