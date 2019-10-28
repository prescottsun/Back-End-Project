const express = require("express");
const router = express.Router();

const userClass = require("../models/userModel");
const ActivityModel = require('../models/activityModel');

/* GET home page. */
router.get("/", async (req, res, next) => {
    userData = await userClass.getInfo();
    recentActivity = await ActivityModel.getRecentActivity();
    res.render("template", {
        locals: {
            title: "Home Page",
            recentActivity: recentActivity,
            isLoggedIn: req.session.is_logged_in,
            userName: req.session.first_name
        },
        partials: {
            partial: "partial-index"
        } 
    });
});



module.exports = router;
