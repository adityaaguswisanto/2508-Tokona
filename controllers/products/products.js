const repositories = require('../../repositories/products/products');

class Products {
   
    static async get(req, res) {
        try {
            const { search, merchant_id, page, limit } = req.query;
            let user = req.user.data;
            if (user.role !== 2) {
                return res.status(400).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(400).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }
            const data = await repositories.get(search, merchant_id, user.id, page, limit);
            const cleanedData = data.map(item => {
                const plain = item.get({ plain: true });
                const { product } = plain;

                return {
                    id: plain.id,
                    code: product.code,
                    photo: product.photo || null,
                    name: product.name,
                    description: product.description,
                    price: product.price,
                    available: plain.available,
                    productId: product.id,
                    merchantId: plain.merchant_id,
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

    static async update(req, res) {
        try {
            const { id } = req.params;      
            const { available } = req.body;    

            let user = req.user.data;
            if (user.role !== 2) {
                return res.status(400).json({ message: "Anda tidak memiliki izin." });
            }
            if (!user.id) {
                return res.status(400).json({ 
                    message: "Unauthorized: user_id tidak ditemukan"
                });
            }
            
            const result = await repositories.update(id, available);
            res.status(200).json(result);
        } catch (error) {
            res.status(500).json({ message: "Internal Server Error" });
        }
    }
}
module.exports = Products;