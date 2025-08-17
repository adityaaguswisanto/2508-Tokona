const users = require('../../models/users/users');

class User {

    static async create(nik, name, username, password, position, role) {
        return new Promise(async (resolve, reject) => {
            try {
                await users.create({
                    nik,
                    name,
                    username,
                    password,
                    position,
                    role,
                    created_at: new Date(),
                    updated_at: new Date(),
                }).then((data) => {
                    resolve(data)
                });
            } catch (error) {
                console.error(error);
                reject(error)
            }
        })
    }

    static async findByUsername(username) {
        return new Promise(async (resolve, reject) => {
            try {
                await users.findOne({ 
                    where: { 
                        username
                    }
                }).then((data) => {
                    resolve(data)
                });
            } catch (error) {
                console.error(error);
                reject(error);
            }
        });
    }

    static async findById(id) {
        return new Promise(async (resolve, reject) => {
            try {
                await users.findOne({ 
                    where: { 
                        id
                    }
                }).then((data) => {
                    resolve(data)
                });
            } catch (error) {
                console.error(error);
                reject(error);
            }
        });
    }

}
module.exports = User;