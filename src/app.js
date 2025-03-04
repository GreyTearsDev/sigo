import dotenv from "dotenv";
dotenv.config();
import morgan from "morgan";
morgan("dev");
import express from "express";
import http from "http";

const app = express();

app.get("/", (req, res, next) => {
  return res.json({ name: "Tirso" });
});

const port = process.env.PORT || 5000;
const server = http.createServer(app);
app.set("port", port);
server.listen(port);
