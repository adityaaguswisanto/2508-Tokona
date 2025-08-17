const { DataTypes } = require('sequelize')
const db = require('../../config/connection')

const users = db.define('dimension_users', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    nik: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    username: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },
    password: {
        type: DataTypes.STRING,
        allowNull: false
    },
    position: {
        type: DataTypes.STRING
    },
    role: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    photo: {
        type: DataTypes.STRING
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
module.exports = users;