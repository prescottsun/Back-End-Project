const express = require("express");
const router = express.Router();

const UserModel = require("../models/userModel");
const ActivityModel = require('../models/activityModel');
const ResourceModel = require('../models/resourceModel');

router.get("/", async (req, res, next) => {
    const userData = await UserModel.getInfo(req.session.user_id);
    const resourceData = await ResourceModel.getResources();
    const recentActivity = await ActivityModel.getRecentActivity();
    res.render("template", {
        locals: {
            title: "Profile",
            isLoggedIn: req.session.is_logged_in,
            userData: userData,
            recentActivity: recentActivity
        },
        partials: {
            partial: "partial-profile"
            
        }
    });
});

router.post("/", async (req, res, next) => {
    const { user_id, about } = req.body;
    const user = new UserModel(user_id, null, null, null, null, about);
    const response = await user.updateDescription(about, user_id);
    if (response) {
        res.status(200).redirect("/profile");
    } else {
        res.sendStatus(401);
    }
});


module.exports = router;
