const express = require("express");
const mongoose = require("mongoose");
const Port = process.env.port || 5000;
const app = express();


mongoose.connect('mongodb://localhost:27017/myapp');
// {
//     useNewUrlParser: true,
//     useCreateIndex: true,
//     useUnifiedTopology: true
// });

const connection = mongoose.connection;
connection.once("open",()=>{
    console.log("MongoDB connected");
});



//middleware
app.use(express.json())
const userRoute = require("./routes/user");
app.use("/user",userRoute);
app.route("/").get((req,res)=>res.json("your first rest api 3 "));
app.listen(Port,()=>console.log('your server is running on port '+Port));

