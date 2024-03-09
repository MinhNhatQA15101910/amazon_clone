import env from "dotenv";
import express from "express";

import authRouter from "./routes/auth.js";

const app = express();
env.config();

app.use(authRouter);

app.listen(process.env.PORT, "0.0.0.0", () => {
  console.log(`Server running on http://localhost:${process.env.PORT}`);
});
