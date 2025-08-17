const bcrypt = require("bcrypt");

class Bcrypt {
    static async generate(password){
        return new Promise(async (approve, reject)=>{
            try{
                let hashPassword = await bcrypt.hash(password, 12);
                approve(hashPassword)
            }catch(err){
                reject(err)
            }
            
        })
    }

    static compare(password, hash, cb){
        return new Promise(async (approve, reject)=>{
            let hasil =  bcrypt.compare(password, hash);
            approve(hasil);
        })
    }
}
module.exports= Bcrypt;