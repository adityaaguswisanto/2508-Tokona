const { DataTypes } = require('sequelize')
const db = require('../../config/connection')

const promos = db.define('fact_promos', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    price: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    discount: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    end_date: {
        type: DataTypes.DATE,
        allowNull: true
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
module.exports = promos;