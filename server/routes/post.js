const express = require("express");
const auth = require("../middlewares/auth");
const Post = require("../models/post");
const postRouter = express.Router();

postRouter.post("/posts/add", auth, async (req, res) => {
  try {
    const { createdAt, title, image, description } = req.body;
    let post = new Post({
      uid: req.user,
      title,
      image,
      description,
      createdAt,
    });
    post = await post.save();
    res.json(post);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

postRouter.get("/posts", async (req, res) => {
  try {
    const post = await Post.find().sort({ createdAt: -1 });
    res.json(post);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = postRouter;