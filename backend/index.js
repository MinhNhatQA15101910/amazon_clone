import express from "express";
import env from "dotenv";

const app = express();
env.config();

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`Server running on http://localhost:${process.env.PORT}`);
});
