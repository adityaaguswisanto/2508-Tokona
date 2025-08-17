var express = require('express');
var router = express.Router();

let authentification = require('../../middlewares/authentification');
let promosController = require('../../controllers/promos/promos');

router.post('/promos/create', authentification.checking(), promosController.create);
router.get('/promos', authentification.checking(), promosController.get);

module.exports = router