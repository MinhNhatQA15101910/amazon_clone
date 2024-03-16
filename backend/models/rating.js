import mongoose from "mongoose";

const ratingSchema = mongoose.Schema({
  userId: {
    type: String,
    required: true,
    trim: true,
  },
  rating: {
    type: Number,
    required: true,
  },
});

export default ratingSchema;
