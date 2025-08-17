const repositories = require('../../repositories/promos/promos');
const validations = require('../../helpers/validations');

class Promos {
   
    static async get(req, res) {
        try {
            const { search, merchant_id, page = 1, limit = 10 } = req.query;
            const user = req.user.data;

            if (user.role !== 2) {
                return res.status(400).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(400).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }

            const data = await repositories.get(search, merchant_id, user.id, Number(page), Number(limit));

            const cleanedData = data.map(item => {
                const { product } = item; 

                return {
                    id: item.id,
                    code: product?.code || null,
                    photo: product?.photo || null,
                    name: product?.name || null,
                    description: product?.description || null,
                    price: item.price,
                    discount: item.discount,
                    available: item.available,
                    endDate: item.end_date,
                    merchantId: item.merchant_id,
                    createdAt: item.created_at,
                    updatedAt: item.updated_at
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

    static async create(req, res) {
        try {
            const { price, discount, end_date, product_id, merchant_id } = req.body;
            await validations.string(price, res, "Price");
            await validations.string(discount, res, "Discount");
            await validations.string(end_date, res, "End Date");
            await validations.string(product_id, res, "Product Id");
            await validations.string(merchant_id, res, "Merchant Id");

            let user = req.user.data;
            if (user.role !== 2) {
                return res.status(400).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(400).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }

            await repositories.create(price, discount, end_date, product_id, merchant_id, user.id);
            res.status(201).json({
                message: "Success"
            });
        } catch {
            res.status(500).json({
                message: "Internal Server Error!"
            });
        }
    }
}
module.exports = Promos;