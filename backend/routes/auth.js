import express from "express";

const authRouter = express.Router();

authRouter.get("/user", (req, res) => {
  res.json({ msg: "Nhat" });
});

export default authRouter;
