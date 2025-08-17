const repositories = require('../../repositories/merchants/merchants');

class Merchants {
   
    static async get(req, res) {
        try {
            const { search, page, limit } = req.query;
            let user = req.user.data;
            if (user.role !== 2) {
                return res.status(400).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(400).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }
            const data = await repositories.get(search, user.id, page, limit);
            const cleanedData = data.map(item => {
                const plain = item.get({ plain: true });
                const { merchant } = plain;

                return {
                    id: merchant.id,
                    code: merchant.code,
                    name: merchant.name,
                    address: merchant.address,
                    createdAt: plain.created_at,
                    updatedAt: plain.updated_at 
                };
            });

            res.status(200).json({
                message: "Success",
                data: cleanedData
            });
        } catch (error) {
            console.error(error);
            res.status(500).json({
                message: "Internal Server Error"
            });
        }
    }
}
module.exports = Merchants;