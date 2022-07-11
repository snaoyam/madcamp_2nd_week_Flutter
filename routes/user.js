const express = require("express");
const User = require("../models/users.models");
const config=require("../config");
const jwt = require("jsonwebtoken");
const middleware=require('../middleware');
const router = express.Router();



router.route("/:username").get(middleware.checkToken,(req, res) => {
    User.findOne({ username: req.params.username }, (err, result) => {
        if (err) res.status(500).json({ msg: err });
        res.json({
            data: result,
            username: req.params.username, 
        });
    });

});

router.route("/login").post((req, res) => {
    console.log(req);
    User.findOne({ username: req.body.username }, (err, result) => {
        if (err) return res.status(500).json({ msg: err });
        if(result===null)
        {
            return res.status(403).json("Username is incorrect");
        }
        if(result.password===req.body.password)
        {
            //here we implement the JWT token functionality
            let token = jwt.sign({username:req.body.usernmame},config.key,{
                expiresIn:"24h" //24시간뒤 만료

            });
            res.json({
                token: token,
                msg: "success"
            });
        }
        else{
            res.status(403).json("password is incorrect");
        }

    });
});


//사용자 추가
router.route("/register").post((req, res) => {
    console.log("inside the register");
    console.log(req)
    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email,
        projects : 0,
        views : 0,
        recommends : 0
    });
    user
        .save()//mongodb 에 저장
        .then(() => {
            console.log("user registered");
            res.status(200).json("ok");
        })
        .catch((err) => {
            res.status(403).json({ msg: err });
        });

});

router.route("/update/:username").patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "password successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

router.route("/delete/:username").delete((req, res) => {
    User.findOneAndDelete({ username: req.params.username }, (err, result) => {
        if (err) return res.status(500).json({ msg: err });
        const msg = {
            msg: "user deleted",
            username: req.params.username,
        };
        return res.json(msg);
    });

});


//////0710 update project count increase
router.route("/projects/:username").patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { projects: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "projects successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});


//////////////////////views increase
router.route("/views/:username").patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { views: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "views successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

///recommedns increase
router.route("/recommends/:username").patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { recommends: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "views successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});



module.exports = router;

