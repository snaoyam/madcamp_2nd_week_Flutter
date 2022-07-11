const express = require('express');
const User = require('../models/users.models');
const router = express.Router();


router.post('/user/login', (req, res) => {
    User.findOne({ $or: [{ username: req.body.username }, { email: req.body.username }] }, (err, user) => {
        if (err || !user) {
            if (err) console.error(err)
            res.status(403).send({
                'success': false,
                'msg': 'Login failed1'
            })
        }
        else {
            user.comparePassword(req.body.password, (err, isMatch) => {
                if (err || !isMatch) {
                    if (err) console.error(err)
                    res.status(403).json({
                        'success': false,
                        'msg': 'Login failed2'
                    })
                }
                else {
                    user.generateToken((err, token) => {
                        if (err) {
                            res.status(403).json({
                                'success': false,
                                'msg': 'Login failed3'
                            })
                        }
                        else {
                            res.status(200).send({ 'success': true, "token": token })
                        }
                    })
                }
            })
        }
    })
});

//사용자 추가
router.post('/user/register', (req, res) => {
    new User({
        username: req.body.username,
        name: req.body.name,
        password: req.body.password,
        email: req.body.email,
        year: req.body.year,
        class: req.body.class,
    })
    .save((err, user) => {
        if (err) {
            console.error(err)
            res.status(403).send({
                'success': false,
                'msg': 'Register failed'
            })
        }
        else {
            user.generateToken((err, token) => {
                if (err) {
                    console.error(err)
                    res.status(403).json({
                        'success': false,
                        'msg': 'Please Login again'
                    })
                }
                else {
                    res.status(200).send({ 'success': true, "token": token })
                }
            })
        }
    })
})

router.route('/user/update/:username').patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: 'password successfully updated',
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

router.route('/user/delete/:username').delete((req, res) => {
    User.findOneAndDelete({ username: req.params.username }, (err, result) => {
        if (err) return res.status(500).json({ msg: err });
        const msg = {
            msg: 'user deleted',
            username: req.params.username,
        };
        return res.json(msg);
    });

});


//////0710 update project count increase
router.route('/projects/:username').patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { projects: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: 'projects successfully updated',
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});


//////////////////////views increase
router.route('/views/:username').patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { views: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: 'views successfully updated',
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

///recommedns increase
router.route('/recommends/:username').patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $inc: { recommends: 1 } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: 'views successfully updated',
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});



module.exports = router

