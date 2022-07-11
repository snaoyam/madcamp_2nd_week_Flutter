const { Schema, model } = require("mongoose")
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')


const UserSchema = Schema({
    username: {
        type : String,
        required: true,
        unique: true,
    },
    name: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
    },
    year: {
        type: String,
        required: true,
    },
    class: {
        type: String,
        required: true,
    },
    posts:{
        type: [Schema.ObjectId],
        default: []
    },
})

UserSchema.pre('save', async function (next) {
    const user = this
    if (user.isModified('password')) {
        const salt = await bcrypt.genSalt(10)
        user.password = await bcrypt.hash(user.password, salt)
    }
    return next()
})

UserSchema.methods.comparePassword = function (passwd, callback) {
    console.log(passwd, this.password)
    bcrypt.compare(passwd, this.password, (err, match) => {
        console.log(err)
        if (err) {
            console.error(err)
            return callback(err, null)
        }
        callback(null, match)
    })
}

UserSchema.methods.generateToken = function (callback) {
    const user = this
    const token = jwt.sign({ id: user._id.toHexString(), studentid: user.studentid, name: encodeURIComponent(user.name) }, process.env.jwtsecret, { expiresIn: '365d' })
    user.token = token
    user.save((err) => {
        if (err) {
            console.error(err)
            callback(err, null)
        }
        else callback(null, token)
    })
}


module.exports = model("User", UserSchema);