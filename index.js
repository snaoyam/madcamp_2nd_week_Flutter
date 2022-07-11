const express = require("express");
const mongoose = require("mongoose");
const app = express();
require("dotenv").config()
const cors = require('cors');

const User = require('./models/users.models');
const Post = require("./models/post.models");

const publicRouter = require("./routes/public")
const authRouter = require("./routes/private")

const PORT = process.env.PORT ?? 8080;
const DBHOST = process.env.DBHOST ?? 'localhost';
const DBPORT = process.env.DBPORT ?? 27017;
const DBPATH = process.env.DBPATH ?? 'database';

mongoose.connect(`mongodb://${DBHOST}:${DBPORT}/${DBPATH}`, {
    useNewUrlParser: true,
    useUnifiedTopology: true
})
.then(() => {
    console.log("MongoDB connected");
})
.catch(err => {
    console.log("DB connection failed", err);
    process.exit()
})

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

app.use('/public/', publicRouter)
app.use('/api/', authRouter)



app.get('/user/delete', (req, res) => {
    User.deleteMany({}).exec((err, o) => {
        res.status(200).send("ok")
    })
})
app.get('/post/delete', (req, res) => {
    Post.deleteMany({}).exec((err, o) => {
        res.status(200).send("ok")
    })
})

app.get('/user', (req, res) => {
    User.find({}).exec((err, obj) => {
        res.status(200).send(obj)
    })
})
app.get('/post', (req, res) => {
    Post.find({}).exec((err, obj) => {
        res.status(200).send(obj)
    })
})



app.route("/").get((req, res) => res.json("server running"));

app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}.`)
})
