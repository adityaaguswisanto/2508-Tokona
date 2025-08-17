let request = require('request');
const db = require("../config/connection");
let { QueryTypes } = require('sequelize');

class Validations{
  static string(variable, res, name){
    return new Promise((resolve, reject) => {
      if(variable === "" || variable === null || variable === undefined ){
        res.status(500).json({
          message: 'Variabel '+name+' kosong !',
        });
      }else{
        resolve();
      }
    })
  }
}
module.exports  = Validations;