import bcryptjs from "bcryptjs";
import express from "express";
import jwt from "jsonwebtoken";

import User from "../models/user.js";
import auth from "../middlewares/auth.js";

const authRouter = express.Router();

// Sign Up Route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);
    console.log(hashedPassword);

    let user = new User({ name, email, password: hashedPassword });
    user = await user.save();
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Sign In Route
authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password!" });
    }

    const token = jwt.sign({ id: user._id }, process.env.PASSWORD_KEY);
    res.json({ token, ...user._doc });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Validate Token
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");

    if (!token) {
      return res.json(false);
    }

    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) {
      return res.json(false);
    }

    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }

    return res.json(true);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get User Data
authRouter.get("/user", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

export default authRouter;
