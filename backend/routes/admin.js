import express from "express";

import admin from "../middlewares/admin.js";
import Product from "../models/product.js";

const adminRouter = express.Router();

// Add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, price, quantity, category, images } = req.body;
    let product = new Product({
      name,
      description,
      price,
      quantity,
      category,
      images,
    });
    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

export default adminRouter;
