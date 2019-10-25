const express = require("express");
const router = express.Router();

const ResourceModel = require('../models/resourceModel');
const ReviewModel = require('../models/reviewModel');

router.get('/', async (req, res, next) => {
    const resourceData = await ResourceModel.getResources();
    res.render("template", {
        locals: {
            title: "Resources Page",
            resourceData: resourceData
            ,isLoggedIn: req.session.is_logged_in
        },
        partials: {
            partial: "partial-resources"
        } 
    });
});

router.get('/:resource_id', async (req, res, next) => {
    const { resource_id } = req.params;
    const theResource = await ResourceModel.getResourceByID(resource_id);
    const theResourceReviews = await ReviewModel.getReviewsByResourceID(resource_id);

    res.render('template', {
        locals: {
            title: 'Reviews for this resource',
            resourceData: theResource,
            resourceReviews: theResourceReviews,
            isLoggedIn: req.session.is_logged_in
        },
        partials: {
            partial: 'partial-resource-review'
        }
    });
});
module.exports = router;