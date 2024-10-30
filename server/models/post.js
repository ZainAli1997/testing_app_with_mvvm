const mongoose = require("mongoose");

const postSchema = mongoose.Schema({
    uid: {
        required: true,
        type: String,
    },
    createdAt: {
        required: true,
        type: Number,
    },
    title: {
        required: true,
        type: String,
        trim: true,
    },
    image: {
        required: true,
        type: String,
    },
    description: {
        type: String,
        trim: true,
    },
});

const Post = mongoose.model("Post", postSchema);

module.exports = Post;