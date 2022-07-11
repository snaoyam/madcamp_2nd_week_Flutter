const express = require("express");
const mongoose = require("mongoose");
const app = express();
require("dotenv").config()
const cors = require('cors');
const validateToken = require("./routes/validateToken")

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
authRouter.use(validateToken)
app.use('/api/', authRouter)


app.route("/").get((req, res) => res.json("server running"));

app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}.`)
})
