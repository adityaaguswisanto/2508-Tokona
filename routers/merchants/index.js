var express = require('express');
var router = express.Router();

let authentification = require('../../middlewares/authentification');
let merchantsController = require('../../controllers/merchants/merchants');

router.get('/merchants', authentification.checking(), merchantsController.get);

module.exports = router