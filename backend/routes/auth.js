import bcryptjs from "bcryptjs";
import express from "express";

import User from "../models/user.js";

const authRouter = express.Router();

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = bcryptjs.hash(password, 8);

    let user = new User({ name, email, password: hashedPassword });
    user = await user.save();
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

export default authRouter;
