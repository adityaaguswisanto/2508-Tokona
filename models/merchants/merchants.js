const { DataTypes } = require('sequelize')
const db = require('../../config/connection')

const merchants = db.define('fact_merchants', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    merchant_id: {
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
module.exports = merchants;