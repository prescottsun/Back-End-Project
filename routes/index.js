const express = require("express");
const router = express.Router();

/* GET home page. */
router.get("/", async (req, res, next) => {
    res.render("template", {
        locals: {
            title: "Home Page",
            isLoggedIn: req.session.is_logged_in,
            userName: req.session.first_name
        },
        partials: {
            partial: "partial-index"
        } 
    });
});



module.exports = router;
