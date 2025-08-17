const { Op } = require('sequelize');

const { ms_products, products } = require('../../models/index'); 

class Products {

    static async get(search, merchant_id, staff_id, page = 0, limit = 10) {
        return new Promise(async (resolve, reject) => {
            try {
                const offset = (page - 1) * limit; 
                await products.findAll({ 
                    where: {
                        staff_id,
                        available: 0,
                        ...(merchant_id && { merchant_id })
                    },
                    include: [
                        { model: ms_products, as: 'product', attributes: ['id', 'code', 'photo', 'name', 'description', 'price', 'merchant_id', 'created_at', 'updated_at'], where: search ? {
                            [Op.or]: [
                                { code: { [Op.iLike]: `%${search}%` } },
                                { name: { [Op.iLike]: `%${search}%` } },
                            ]
                        } : undefined },
                    ],
                    offset: offset,
                    limit: limit,
                    order: [['created_at', 'DESC']]
                }).then((data) => {
                    resolve(data)
                });
            } catch (error) {
                console.error(error);
                reject(error)
            }
        });
    }

    static async update(id, available) {
        return new Promise(async (resolve, reject) => {
            try {
                const [updated] = await products.update(
                    { available },
                    { where: { id } }
                );

                if (updated === 0) {
                    return resolve({ 
                        message: 'Produk tidak ditemukan atau tidak ada perubahan.'
                    });
                }

                resolve({ 
                    message: 'Berhasil update status available.'
                 });
            } catch (error) {
                console.error(error);
                reject(error);
            }
        });
    }

}
module.exports = Products;