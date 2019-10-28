const express = require("express"),
    router = express.Router();

const UserModel = require("../models/userModel");


router.get("/", async (req, res, next) => {
    const userData = await UserModel.getInfo(req.session.user_id);
    res.render("template", {
        locals: {
            title: "Profile",
            isLoggedIn: req.session.is_logged_in,
            userData: userData,
            // first_name: req.session.first_name,
            // last_name: req.session.last_name,
            // email_address: req.session.email_address
        },
        partials: {
            partial: "partial-profile"
            
        }
    });
});


router.post("/", async (req, res, next) => {
    const { user_id, about } = req.body;
    const user = new UserModel(user_id, null, null, null, about);
    const response = await user.updateDescription(about, user_id);
    if (response) {
        res.status(200).redirect("/profile");
    } else {
        res.sendStatus(401);
    }
});



module.exports = router;
