const express = require("express");
const router = express.Router();
const userClass = require("../models/userModel")

/* GET home page. */
router.get("/", async (req, res, next) => {
    userData = await userClass.getInfo();
    res.render("template", {
        locals: {
            title: "Home Page",
            userInfo: userData,
            isLoggedIn: req.session.is_logged_in,
            first_name: req.session.first_name
        },
        partials: {
            partial: "partial-index"
        } 
    });
});


module.exports = router;
