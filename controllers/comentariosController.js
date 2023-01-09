const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')
const { on } = require('events')

exports.addComentario = async(req, res, next)=>{
    try {
        let comentario = {
            id_usuario: req.body.id_usuario,
            id_veterinario: req.body.id_veterinario,
            valoracion: req.body.puntuacion,
            titulo: req.body.titulo,
            mensaje: req.body.comentario
        }
        conexion.query('INSERT INTO op003_comentario SET ?', comentario, (error, fila)=>{
            if(error){
                throw error
            }else{
                conexion.query('SELECT promedio, id_clinica FROM veterinario_view003 WHERE id_veterinario = ?', [comentario.id_veterinario], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        let valoracion = fila2[0].promedio
                        let clinica = fila2[0].id_clinica
                        conexion.query('UPDATE cat003_veterinario SET valoracion = ? WHERE id = ?', [valoracion, comentario.id_veterinario], (error3, fila3)=>{
                            if(error3){
                                throw error3
                            }else{
                                conexion.query('SELECT AVG(valoracion) as prom FROM veterinario_view002 WHERE id_clinica = ?', [clinica], (error4, fila4)=>{
                                    if(error4){
                                        throw error4
                                    }else{
                                        let clinica_valoracion = fila4[0].prom
                                        conexion.query('UPDATE cat004_clinica SET valoracion = ? WHERE id = ?', [clinica_valoracion, clinica], (error5, fila5)=>{
                                            if(error5){
                                                throw error5
                                            }else{
                                                res.render('login', {
                                                    alert: true,
                                                    alertTitle: 'EXITO',
                                                    alertMessage: 'Tu comentario se ha registrado, gracias por tu colaboracion',
                                                    alertIcon: 'success',
                                                    showConfirmButton: true,
                                                    timer: 8000,
                                                    ruta: 'veterinarios'
                                                })
                                                return next()
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    } catch (error) {
        console.log(error)
        return next
    }
}
exports.selectComentarios = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM comentarios_view001 ORDER BY id DESC LIMIT 10', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.comentarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectComentariosAdmin = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM comentarios_view001 ORDER BY id DESC', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.comentarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.deleteComentario = async(req, res, next)=>{
    try {
        let comentario = req.query.comentario

        conexion.query('SELECT * FROM op003_comentario WHERE id = ?', [comentario], (error, fila)=>{
            if(error){
                throw error
            }else{
                let veterinario = fila[0].id_veterinario
                conexion.query('DELETE FROM op003_comentario WHERE id = ?', [comentario], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        conexion.query('SELECT promedio, id_clinica FROM veterinario_view003 WHERE id_veterinario = ?', [veterinario], (error3, fila3)=>{
                            if(error3){
                                throw error3
                            }else{
                                let valoracion = fila3[0].promedio
                                let clinica = fila3[0].id_clinica
                                conexion.query('UPDATE cat003_veterinario SET valoracion = ? WHERE id = ?', [valoracion, veterinario], (error4, fila4)=>{
                                    if(error4){
                                        throw error4
                                    }else{
                                        conexion.query('SELECT AVG(valoracion) as prom FROM veterinario_view002 WHERE id_clinica = ?', [clinica], (error5, fila5)=>{
                                            if(error5){
                                                throw error5
                                            }else{
                                                let clinica_valoracion = fila5[0].prom
                                                conexion.query('UPDATE cat004_clinica SET valoracion = ? WHERE id = ?', [clinica_valoracion, clinica], (error6, fila6)=>{
                                                    if(error6){
                                                        throw error6
                                                    }else{
                                                        res.render('login', {
                                                            alert: true,
                                                            alertTitle: 'EXITO',
                                                            alertMessage: 'El comentario se ha eliminado con exito',
                                                            alertIcon: 'success',
                                                            showConfirmButton: true,
                                                            timer: 8000,
                                                            ruta: 'admincomentarios'
                                                        })
                                                        return next()
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    } catch (error) {
        console.log(error)
        return next
    }
}