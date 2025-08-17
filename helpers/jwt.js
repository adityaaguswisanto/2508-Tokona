let jwt = require('jsonwebtoken');
let key = process.env.KEY;
let key_mobile = process.env.KEY_MOBILE;

class Jwt{
    static generate(data){
        if(data){
            let token =  jwt.sign(data, key_mobile);
            return token
        }else{
           return {
                pesan: "data tidak ada"
            }
        }
       
    }

    static verify(token){
        return new Promise( (approve, reject)=>{
            if(token){
                try{
                    var decoded = jwt.verify(token, key_mobile);
                    approve(decoded);
                }catch(err){
                    reject(err)
                }
            }else{
                reject({
                    pesan: "token belum dikirim"
                });
            }
        })
    }
}
module.exports  = Jwt;