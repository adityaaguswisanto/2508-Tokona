require('dotenv').config()

const express = require('express')
const cors = require('cors')
const morgan = require('morgan')
const moment = require('moment');
morgan.token('date', function() {
  var p = moment().format()
  return(p);
});

const routers = require('./routers')
const db = require('./config/connection')

const app = express()
const port = process.env.PORT_EXPRESS || 5044

// app.use(morgan('dev'))
app.use(morgan(':remote-user [:date[web]] - :method :url :status :res[content-length] - :response-time ms'));
app.use(cors())
app.use(express.json({limit: '500mb'}));//
app.use(express.urlencoded({limit: '500mb', extended: true}));

// Test endpoint
app.get('/test', (req, res) => {
  res.json({ status: 'success', message: 'API is working' });
})

app.use('/',routers)

app.use((req,res,next)=>{
    res.status(404).json({status:'404 Path not Found'})
})


app.listen(port, '0.0.0.0', async ()=>{
    console.log(`Active in port ${port}`)
    try {
        await db.authenticate();
        console.log("✅️ Database OK");
    } catch (error) {
        console.error("❌ Database Error",error);
    }
})