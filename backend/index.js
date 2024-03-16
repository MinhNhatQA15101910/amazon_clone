import env from "dotenv";
import express from "express";
import mongoose from "mongoose";

import adminRouter from "./routers/admin_router.js";
import authRouter from "./routers/auth_router.js";
import productRouter from "./routers/product_router.js";
import userRouter from "./routers/user_router.js";

const app = express();
env.config();

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

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
