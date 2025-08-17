const repositories = require('../../repositories/users/users');
const validations = require('../../helpers/validations');
const bcrypt = require('../../helpers/bcrypt');
const jwt = require('../../helpers/jwt');

class User {
    static async register(req, res) {
        try {
            const { nik, name, username, password, position, role } = req.body;
            await validations.string(nik, res, "Nik");
            await validations.string(name, res, "Name");
            await validations.string(username, res, "Username");
            await validations.string(password, res, "Password");
            await validations.string(position, res, "Position");
            await validations.string(role, res, "Role");

            const existingUser = await repositories.findByUsername(username);
            if (existingUser) {
                return res.status(400).json({
                    message: "Username sudah digunakan, silakan gunakan username lain"
                });
            }

            let passwordEncrypt = await bcrypt.generate(password);
            await repositories.create(nik, name, username, passwordEncrypt, position, role);
            res.status(201).json({
                message: "Success"
            });
        } catch {
            res.status(500).json({
                message: "Internal Server Error!"
            });
        }
    }

    static async login(req, res) {
        try {
            const { username, password } = req.body;
            await validations.string(username, res, "Username");
            await validations.string(password, res, "Password");
            const user = await repositories.findByUsername(username);
            if (!user) {
                return res.status(404).json({
                    message: "User tidak ditemukan!"
                });
            }

            const match = await bcrypt.compare(password, user.password);
            if (!match) {
                return res.status(401).json({
                    message: "Password salah!"
                });
            }

            let data = {
                id: user.id,
                nik: user.nik,
                name: user.name,
                username: user.username,
                position: user.position,
                role: user.role,
                photo: user.photo,
                createdAt: user.created_at,
                updatedAt: user.updated_at,
            }

            const token = jwt.generate({data});

            return res.status(200).json({
                message: "Success",
                data: {
                    id: user.id,
                    nik: user.nik,
                    name: user.name,
                    username: user.username,
                    position: user.position,
                    role: user.role,
                    photo: user.photo,
                    token: token,
                    createdAt: user.created_at,
                    updatedAt: user.updated_at,
                }
            });

        } catch {
            res.status(500).json({
                message: 'Internal Server Error!'
            });
        }
    }

    static async user(req, res) {
        try {
            const authHeader = req.headers['authorization'];
            if (!authHeader) {
                return res.status(401).json({ 
                    message: 'Token tidak ditemukan'
                });
            }

            const token = authHeader.split(' ')[1];
            if (!token) {
                return res.status(401).json({
                    message: 'Token tidak ditemukan'
                });
            }

            const decoded = await jwt.verify(token);

            const findByUsername = decoded.data.username;

            const user = await repositories.findByUsername(findByUsername);

            if (!user) {
                return res.status(404).json({ 
                    message: 'User tidak ditemukan'
                });
            }

            res.status(200).json({
                message: 'Success',
                data: {
                    id: user.id,
                    nik: user.nik,
                    name: user.name,
                    username: user.username,
                    position: user.position,
                    role: user.role,
                    photo: user.photo || null,
                    createdAt: user.created_at,
                    updatedAt: user.updated_at,
                }
            });

        } catch (err) {
            console.error(err);
            res.status(401).json({ 
                message: 'Token tidak valid'
            });
        }
    }
}
module.exports = User;