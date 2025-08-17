const { Sequelize } = require('sequelize');

const sequelize = new Sequelize({
    pool: {
        max: 1000,
        min: 0,
        idle: 200000,
        acquire: 1000000,
    },
    database:process.env.DB_NAME,
    username:process.env.DB_USER,
    password:process.env.DB_PASS,
    host:process.env.DB_HOST,
    port:process.env.DB_PORT,
    dialect:'postgres',
    ssl: true,
    logging:false
})

module.exports = sequelize