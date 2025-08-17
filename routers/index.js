const express = require('express')

const indexUsers = require('./users/index');
const indexAttendances = require('./attendances/index');
const indexMerchants = require('./merchants/index');
const indexProducts = require('./products/index');
const indexPromos = require('./promos/index');

const routeIndex = express.Router();
routeIndex.use('/v1/report', indexUsers);
routeIndex.use('/v1/report', indexAttendances);
routeIndex.use('/v1/report', indexMerchants);
routeIndex.use('/v1/report', indexProducts);
routeIndex.use('/v1/report', indexPromos);

module.exports = routeIndex