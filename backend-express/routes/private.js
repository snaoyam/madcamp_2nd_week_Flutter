const express = require("express");
const Post = require("../models/post.models");
const router = express.Router();
const multer = require("multer");
const validateToken = require("../routes/validateToken")

router.use(validateToken)


const storage = multer.diskStorage({
    destination:(req, file, cb)=>{
        cb(null,"./uploads");
    },
    filename: (req, file, cb) => {
        cb(null, file.originalname);
    },
});

const multerFilter = (req, file, cb) => {
    if (file.mimetype == "image/jpeg" || file.mimetype == "image/png" || file.mimetype == "image/jpg") {
        cb(null, true);
    } else {
        cb(null, false);
    }
};
const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 100,
    },
    fileFilter: multerFilter,
});

router.post('/post/new', upload.array('image', 24), (req, res) => {
    new Post({
        title: req.body.title,
        githuburl: req.body.githuburl,
        description: req.body.description,
        image: req.files.map(v => v['originalname']),
        author: res.session._id,
    })
    .save((err, post) => {
        if (err) {
            console.log(err)
            res.status(403).send({
                'success': false,
                'msg': 'Post failed'
            })
        }
        else {
            res.status(200).send({'success': true, 'postId': post._id})
        }
    })
})



router.post('/post/home/', (req, res) => {
    Post.find({ created_at: { $lt: req.body.time } })
    .sort({ viewCount: -1 })
    .skip(5 * (req.body.iterate - 1)).limit(5)
    .exec((err, postList) => {
        if(err) {
            res.status(403).send({
                'success': false,
                'msg': 'get posts failed'
            })
        }
        else {
            res.status(200).send({ 'success': true, 'postList': postList.sort(() => Math.random() - 0.5)})
        }
    })
    Post.updateMany({ $inc: { viewCount: 1 } }).exec()
})



router.post('/post/like', (req, res) => {
    Post.findByIdAndUpdate(req.body.postId, { '$addToSet': { 'like': res.session._id }}, { returnOriginal: false }).exec((err, post) => {
        if(err) {
            console.log(err)
            res.status(403).send({
                'success': false,
                'msg': 'like post failed'
            })
        }
        else {
            res.status(200).send({ 'success': true, 'post': post })
        }
    })
})

router.post('/post/undolike', (req, res) => {
    Post.findByIdAndUpdate(req.body.postId, { '$pull': { 'like': res.session._id } }, { returnOriginal: false }).exec((err, post) => {
        if (err) {
            console.log(err)
            res.status(403).send({
                'success': false,
                'msg': 'undo like post failed'
            })
        }
        else {
            res.status(200).send({ 'success': true, 'post': post })
        }
    })
})



router.post('/post/top/like', (req, res) => {
    Post.find({  })
        .sort({ like: 1 })
        .skip( 15 * (req.body.iterate - 1)).limit(15)
        .exec((err, postList) => {
            if (err) {
                res.status(403).send({
                    'success': false,
                    'msg': 'get posts failed'
                })
            }
            else {
                res.status(200).send({ 'success': true, 'postList': postList.sort(() => Math.random() - 0.5) })
            }
        })
})


module.exports = router;

