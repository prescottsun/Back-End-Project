const express = require("express");
const router = express.Router();

router.get("/", async (req, res, next) => {
    res.send(200);
});

module.exports = router;
