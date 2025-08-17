var express = require('express');
var router = express.Router();

let authentification = require('../../middlewares/authentification');
let usersController = require('../../controllers/users/users');

router.post('/users/register', usersController.register);
router.post('/users/login', usersController.login);
router.get('/users', authentification.checking(), usersController.user);

module.exports = router