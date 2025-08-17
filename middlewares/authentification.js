let jwt = require('../helpers/jwt');

class Authentification {
    static checking() {
        return async (req, res, next) => {
            const authHeader = req.headers['authorization'];
            if (!authHeader) return res.status(401).json({ message: "Anda Belum Login | ceklogin" });
            const token = authHeader.split(' ')[1];
            if (!token) return res.status(401).json({ message: "Token tidak ditemukan | ceklogin" });
            try {
                let hasil = await jwt.verify(token);
                req.user = hasil;
                next();
            } catch (err) {
                res.status(401).json({ message: "Token salah atau expired | ceklogin" });
            }
        };
    }
}

module.exports = Authentification;
