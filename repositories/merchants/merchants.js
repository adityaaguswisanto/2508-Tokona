const { Op } = require('sequelize');

const { ms_merchants, merchants } = require('../../models/index'); 

class Merchants {

    static async get(search, user_id, page = 0, limit = 10) {
        return new Promise(async (resolve, reject) => {
            try {
                const offset = (page - 1) * limit; 
                await merchants.findAll({ 
                    where: {
                        user_id
                    },
                    include: [
                        { model: ms_merchants, as: 'merchant', attributes: ['id', 'code', 'name', 'address', 'created_at', 'updated_at'], where: search ? {
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

}
module.exports = Merchants;