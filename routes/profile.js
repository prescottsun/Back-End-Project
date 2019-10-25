const express = require("express"),
    router = express.Router();

const UserModel = require("../models/userModel");


router.get("/", async (req, res, next) => {
    res.render("template", {
        locals: {
            title: "Profile",
            isLoggedIn: req.session.is_logged_in
        },
        partials: {
            partial: "partial-profile"
        }
    });
});


router.post("/", async (req, res, next) => {
    const { about } = req.body;
    const user = new UserModel(null, null, null, null, about);
    const response = await user.updateDescription();
    if (response) {
        res.status(200).redirect("/profile");
    } else {
        res.sendStatus(401);
    }
});



module.exports = router;
