const express = require("express"),
    bcrypt = require("bcryptjs"),
    router = express.Router();

const UserModel = require("../models/userModel");


router.get("/login", async(req, res, next) => {
    res.render("template", {
        locals: {
            title: "Login",
            isLoggedIn: req.session.is_logged_in
        },
        partials: {
            partial: "partial-login"
        }
    });
});

router.get("/signup", async (req, res, next) => {
    res.render("template", {
        locals: {
            title: "Sign Up",
            isLoggedIn: req.session.is_logged_in
        },
        partials: {
            partial: "partial-signup"
        }
    });
});

router.get("/logout", (req, res, next) => {
    req.session.destroy();
    res.status(200).redirect("/users/login")
});


router.post("/signup", async (req, res, next) => {
    const { first_name, last_name, email_address } = req.body;
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(req.body.password, salt);
    const user = new UserModel(first_name, last_name, email_address, hash);
    const newUser = await user.save();
    console.log("Was user added?", newUser.id);
    if (newUser) {
        res.status(200).redirect("/users/login");
    } else {
        res.status(500);
    }
});

router.post("/login", async(req, res, next) => {
    const {
        email_address,
        password
    } = req.body;
    const user = new UserModel(null, null, email_address, password);
    const response = await user.login();
    if (!!response.isValid) {
        const {
            id,
            first_name,
            last_name
        } = response;
        req.session.is_logged_in = true;
        req.session.first_name = first_name;
        req.session.last_name = last_name;
        req.session.user_id = id;
        res.status(200).redirect("/");
    } else {
        res.sendStatus(401);
    }
});



router.get("/profile", async (req, res, next) => {
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


router.post("/profile", async (req, res, next) => {
    const { about } = req.body;
    const user = new UserModel(null, null, null, null, about);
    const response = await user.updateDescription();
    if (response) {
        // const { id, first_name, last_name, email_address, password } = response;
        // req.session.is_logged_in = true;
        // req.session.first_name = first_name;
        // req.session.last_name = last_name;
        // req.session.user_id = id;
        // req.session.email_address = email_address;
        // req.session.password = password;
        res.status(200).redirect("/users/profile");
    } else {
        res.sendStatus(401);
    }
});



module.exports = router;
