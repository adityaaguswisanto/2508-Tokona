var express = require('express');
var router = express.Router();

let authentification = require('../../middlewares/authentification');
let productsController = require('../../controllers/products/products');

router.get('/products', authentification.checking(), productsController.get);
router.put('/products/available/:id', authentification.checking(), productsController.update);

module.exports = router