const mysql = require('mysql2')


//Creamos la conexion a la base de datos
const conexion = mysql.createConnection({
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
})

conexion.connect((error)=>{
    if(error){
        console.log('Error de conexion: ' + error)
        return
    }
    console.log('CONEXION EXITOSA A BASE DE DATOS')
})

module.exports = conexion