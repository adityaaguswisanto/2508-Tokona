const { Op } = require('sequelize');

const { ms_products, promos } = require('../../models/index'); 

class Promos {

    static async get(search, merchant_id, staff_id, page = 1, limit = 10) {
        try {
            const offset = (page - 1) * limit;
            const allData = await promos.findAll({
                where: {
                    staff_id,
                    ...(merchant_id && { merchant_id })
                },
                include: [
                    {
                        model: ms_products,
                        as: 'product',
                        attributes: [
                            'id', 'code', 'photo', 'name', 'description', 'price', 'created_at', 'updated_at'
                        ],
                        ...(search ? {
                            where: {
                                [Op.or]: [
                                    { code: { [Op.iLike]: `%${search}%` } },
                                    { name: { [Op.iLike]: `%${search}%` } }
                                ]
                            }
                        } : {})
                    }
                ],
                order: [['product_id', 'ASC'], ['created_at', 'DESC']],
            });

            const now = new Date();

            // Filter promo yang belum expired berdasarkan jam 23:59:59
            const validData = allData.filter(item => {
                if (!item.end_date) return false;

                const endDate = new Date(item.end_date);
                endDate.setHours(23, 59, 59, 999); // promo berlaku sampai akhir hari

                return endDate >= now;
            });

            // Ambil promo terbaru per product
            const latestDataMap = validData.reduce((acc, item) => {
                if (!acc[item.product_id]) {
                    acc[item.product_id] = item;
                }
                return acc;
            }, {});

            const latestDataArray = Object.values(latestDataMap);

            // Pagination
            const pagedData = latestDataArray.slice(offset, offset + limit);

            return pagedData;
        } catch (error) {
            console.error(error);
            throw error;
        }
    }


    static async create(price, discount, end_date, product_id, merchant_id, staff_id) {
        return new Promise(async (resolve, reject) => {
            try {
                await promos.create({
                    price, 
                    discount, 
                    end_date, 
                    product_id, 
                    merchant_id,
                    staff_id,
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

}
module.exports = Promos;