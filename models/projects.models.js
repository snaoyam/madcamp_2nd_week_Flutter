const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Project = Schema({
    title:{
        type : String,
        required: true,
        unique: true
    },
    description:{
        type: String,
        required: true
    },
    githuburl:{
        type: String,
        required: true
    },
    img:{
        type: String,
        default:""
    },
},
{
    timestamp: true,
});

module.exports = mongoose.model("Project", Project);