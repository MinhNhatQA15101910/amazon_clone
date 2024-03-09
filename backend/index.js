import env from "dotenv";
import express from "express";
import mongoose from "mongoose";

import authRouter from "./routes/auth.js";

const app = express();
env.config();

app.use(authRouter);

mongoose
  .connect(process.env.DB)
  .then(() => {
    console.log("Connecting Successful.");
  })
  .catch((err) => {
    console.log(err);
  });

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`Server running on http://localhost:${process.env.PORT}`);
});
