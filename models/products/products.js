const { DataTypes } = require('sequelize')
const db = require('../../config/connection')

const products = db.define('fact_products', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    available: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    product_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    merchant_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    staff_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    user_id: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    created_at: {
        type: DataTypes.DATE
    },
    updated_at: {
        type: DataTypes.DATE
    }
}, {
    createdAt: false,
    updatedAt: false,
    freezeTableName: true
});
module.exports = products;