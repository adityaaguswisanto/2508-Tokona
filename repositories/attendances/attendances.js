const { Op } = require('sequelize');
const attendances = require('../../models/attendances/attendances');

class Attendances {

    //untuk absen karyawan, jika 1 check in jika 2 check out
    static async create(longitude, latitude, status, reason, user_id) {
        return new Promise(async (resolve, reject) => {
            try {
                await attendances.create({
                    longitude, 
                    latitude,
                    status,
                    reason,
                    user_id,
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

    /* untuk check absensi terakhir apakah check in atau check out,
    jika null maka sudah ganti hari */
    static async get(user_id) {
        return new Promise(async (resolve, reject) => {
            try {
                const startOfDay = new Date();
                startOfDay.setHours(0, 0, 0, 0);

                const endOfDay = new Date();
                endOfDay.setHours(23, 59, 59, 999);

                await attendances.findOne({
                    where: {
                        user_id,
                        created_at: {
                            [Op.between]: [startOfDay, endOfDay]
                        }
                    },
                    order: [['created_at', 'DESC']],
                }).then((data) => {
                    resolve(data);
                });
            } catch (error) {
                console.error(error);
                reject(error);
            }
        });
    }

}
module.exports = Attendances;