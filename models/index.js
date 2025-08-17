const users = require('./users/users');
const ms_merchants = require('./merchants/ms_merchants');
const merchants = require('./merchants/merchants');
const ms_products = require('./products/ms_products');
const products = require('./products/products');
const promos = require('./promos/promos');
const attendances = require('./attendances/attendances');

attendances.belongsTo(users, {
  foreignKey: 'user_id',
  as: 'user'
});

merchants.belongsTo(ms_merchants, {
  foreignKey: 'merchant_id',
  as: 'merchant'
});

products.belongsTo(ms_products, {
  foreignKey: 'product_id',
  as: 'product'
});

promos.belongsTo(ms_products, {
  foreignKey: 'product_id',
  as: 'product'
});

module.exports = {
  users,
  ms_merchants,
  merchants,
  ms_products,
  products,
  promos,
  attendances,
};
