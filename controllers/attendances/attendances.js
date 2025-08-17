const repositories = require('../../repositories/attendances/attendances');
const validations = require('../../helpers/validations');

class Attendance {
    static async create(req, res) {
        try {
            const { longitude, latitude, status, reason } = req.body;
            let user = req.user.data;
            // jika role nya adalah 1 yaitu admin, tidak bisa di create
            if (user.role !== 2) {
                return res.status(403).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(401).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }
            await validations.string(longitude, res, "Longitude");
            await validations.string(latitude, res, "Latitude");
            await validations.string(status, res, "Status");
            await repositories.create(longitude, latitude, status, reason, user.id);
            res.status(200).json({
                message: `Anda berhasil ${status === 1 ? "Checkin" : "Checkout"}`
            });
        } catch {
            res.status(500).json({
                message: "Internal Server Error!"
            });
        }
    }

    static async get(req, res) {
        try {
            let user = req.user.data;
            // jika role nya adalah 1 yaitu admin, tidak bisa di create
            if (user.role !== 2) {
                return res.status(403).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(401).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }
            const data = await repositories.get(user.id);

            if (!data) {
                return res.status(200).json({
                    message: "Success",
                    data: null
                });
            }

            res.status(200).json({
                message: "Success",
                data: {
                    id: data.id,
                    longitude: data.longitude,
                    latitude: data.latitude,
                    status: data.status,
                    reason: data.reason,
                    createdAt: data.created_at,
                    updatedAt: data.updated_at
                }, 
            });
        } catch {
            res.status(500).json({
                message: "Internal Server Error!"
            });
        }
    }
}
module.exports = Attendance;