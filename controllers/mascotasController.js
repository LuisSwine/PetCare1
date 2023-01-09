const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')


exports.selectTiposMascota = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM cat008_tipo_mascota', (error, filas)=>{
            if(error){
                throw error
            }else{
                req.tipos_mascota = filas
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectEspeciesMascota = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM cat009_especies', (error, filas)=>{
            if(error){
                throw error
            }else{
                req.especies = filas
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.nuevaMascota = async(req, res, next)=>{
    try {
        let data = {
            id_owner: req.body.owner,
            tipo: req.body.tipo,
            especie: req.body.especie,
            nombre: req.body.nombre,
            sexo: req.body.sexo
        }
        conexion.query('INSERT INTO cat010_mascota SET ?', data, (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(`/mismascotas?usuario=${data.id_owner}`)
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectMascotas = async(req, res, next)=>{
    try {
        let owner = req.query.usuario

        conexion.query('SELECT * FROM mascotas_view001 WHERE id_owner = ?', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.mascotas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectMascotasAdmin = async(req, res, next)=>{
    try {
        let owner = req.query.petowner

        conexion.query('SELECT * FROM mascotas_view001 WHERE id_owner = ?', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.mascotas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectMascota = async(req, res, next)=>{
    try {
        let mascota = req.query.mascota
        conexion.query('SELECT * FROM mascotas_view001 WHERE id = ?', [mascota], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.mascota = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.deleteMascota = async(req, res, next)=>{
    try {
        let mascota = req.query.mascota
        let usuario = req.query.usuario
        //Primero eliminamos todas las consultas o citas que haya tenido esa mascota
        conexion.query('DELETE FROM op001_consultas WHERE id_mascota = ?', [mascota], (error, fila)=>{
            if(error){
                throw error
            }else{
                //Ahora si eliminamos a la mascota
                conexion.query('DELETE FROM cat010_mascota WHERE id = ?', [mascota], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        let ruta = `mismascotas?usuario=${usuario}`
                        res.render('login', {
                            alert: true,
                            alertTitle: 'EXITO',
                            alertMessage: 'El registro de tu amigo ha sido borrado exitosamente',
                            alertIcon: 'success',
                            showConfirmButton: true,
                            timer: 8000,
                            ruta: ruta 
                        })
                        return next()
                    }
                })
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.editNombreMascota = async(req, res, next)=>{
    try {
        let mascota = req.query.id
        let nombre = req.query.nombre
        conexion.query('UPDATE cat010_mascota SET nombre = ? WHERE id = ?', [nombre, mascota], (error, fila)=>{
            if(error){
                throw error
            }else{
                let ruta = `perfilmascota?mascota=${mascota}`
                res.render('login', {
                    alert: true,
                    alertTitle: 'EXITO',
                    alertMessage: 'El nombre de tu amigo se cambio con exito',
                    alertIcon: 'success',
                    showConfirmButton: true,
                    timer: 8000,
                    ruta: ruta 
                })
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}