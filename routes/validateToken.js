const jwt = require('jsonwebtoken')
const UserModel = require("../models/users.models")

const validateToken = (req, res, next) => {
  try {
    const token = req.headers['token']
    if (!token) throw new Error('token not found')
    jwt.verify(token, process.env.jwtsecret, (err, decoded) => {
      if (err) throw new Error('token invalid')
      res["session"] = decoded
      if (decoded.exp * 1000 - Date.now() < 1000 * 60 * 60 * 24 * 30) {
        UserModel.findOne({ _id: decoded.id }, (err, user) => {
          if (err) throw new Error('user not found')
          else {
            user.generateToken((err, token) => {
              if (err) throw new Error('error while generating token')
              else {
                res.setheader("token", token)
                return next()
              }
            })
          }
        })
      }
      else
        return next()
    })
  }
  catch (err) {
    return res.clearCookie("auth").status(401).send({
      'success': false,
      'msg': 'Not authorized'
    })
  }
}

module.exports = validateToken