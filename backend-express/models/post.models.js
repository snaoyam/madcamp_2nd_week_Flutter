const { Schema, model } = require("mongoose")

const Post = Schema({
    title:{
        type : String,
        default: '',
    },
    githuburl:{
        type: String,
        required: true,
    },
    description: {
        type: String,
        default: '',
    },
    image:{
        type: [String],
        default: [],
    },
    like:{
        type: [Schema.ObjectId],
        default: [],
    },
    viewCount:{
        type: Number,
        default: 0,
    },
    author: {
        type: Schema.ObjectId,
        required: true,
    },
    created_at: {
        type: Number,
    }
}, { timestamps: true });

Post.pre('save', async function (next) {
    const post = this
    this.created_at = Date.now()
    return next()
})

module.exports = model("Post", Post);