const express = require("express");
const Project = require("../models/projects.models");
const middleware=require('../middleware');
const router = express.Router();
const path = require("path");

//사진 불러오기
const multer = require("multer");
const storage = multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,"./uploads");
    },
    filename: (req,file,cb) => {
        cb(null, "req.body.title" + ".jpg");//project title로 사진 구분 
    },
});

const fileFilter = (req, file, cb) => {
    if(file.mimetype == "image/jpeg" || file.mimetype == "image/png" || file.mimetype == "image/jpg"){
        cb(null, true);
    }
    else{
        cb(null, false);
    }
};
const upload = multer({
    storage:storage,
    limits:{
        fileSize: 1024 * 1024 * 6,
    },
    fileFilter: fileFilter
});

router
    .route("/add/image")
    .post(upload.single("img"),async (req,res)=>{
        await Project.findOneAndUpdate(
            {title: req.body.title},
            {
                $set:{
                    img: req.file.path,
                },
            },
            {new: true},
           

        )
        .then((err, project) => {
            if (!err){
                const response = {
                    message: "image added successfully updated",
                    data: project
                };
            
                return res.status(200).send(response);
            }
            else{
                res.status(500).send(err);
            }
            })


    });

/////////////////write new project
router.route("/write").post(upload.single("img"),(req, res) => {
    console.log("writing project");
    console.log(req)
    const project = new Project({
        title: req.body.title,
        description: req.body.description,
        githuburl : req.body.githuburl,
        img: req.file.img,
    });
    project
        .save()//mongodb 에 저장
        .then(() => {
            console.log("project written");
            res.status(200).json("ok");
        })
        .catch((err) => {
            res.status(403).json({ msg: err });
        });

});


// router.route("/write").post((req, res) => {
//     console.log("writing project");
//     console.log(req)
//     const project = new Project({
//         title: req.body.title,
//         description: req.body.description,
//         githuburl : req.body.githuburl
//     });
//     project
//         .save()//mongodb 에 저장
//         .then(() => {
//             console.log("project written");
//             res.status(200).json("ok");
//         })
//         .catch((err) => {
//             res.status(403).json({ msg: err });
//         });

// });

module.exports = router;

