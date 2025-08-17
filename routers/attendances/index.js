var express = require('express');
var router = express.Router();

let authentification = require('../../middlewares/authentification');
let attendancesController = require('../../controllers/attendances/attendances');

router.post('/attendances/create', authentification.checking(), attendancesController.create);
router.get('/attendances', authentification.checking(), attendancesController.get);

module.exports = router