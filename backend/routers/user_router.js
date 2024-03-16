import express from "express";

import auth from "../middlewares/auth.js";

import Product from "../models/product.js";
import User from "../models/user.js";

const userRouter = express.Router();

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let updateCartItem = user.cart.find((cartItem) =>
          cartItem.product._id.equals(product._id)
        );
        updateCartItem.quantity++;
      } else {
        user.cart.push({ product, quantity: 1 });
      }

      user = await user.save();
      res.json(user);
    }
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export default userRouter;
