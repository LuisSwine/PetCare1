const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')
const { on } = require('events')

exports.sugerirClinica = async(req, res, next)=>{
    try {
        let clinica = {
            nombre: req.body.nombre,
            enlace_web: req.body.pagina,
            visita_domicilio: req.body.domicilio,
            telefono: req.body.telefono,
            hora_entrada: req.body.hora_in,
            hora_salida: req.body.hora_out,
            is_checked: false
        }
        if(clinica.visita_domicilio){
            clinica.visita_domicilio = 1
        }else{
            clinica.visita_domicilio = 0
        }
        let direccion = {
            id_clinica: null, 
            calle: req.body.calle,
            colonia: req.body.colonia,
            exterior: req.body.exterior,
            interior: req.body.interior,
            municipio: req.body.municipio,
            estado: req.body.estado,
            codigo_postal: req.body.codigo_postal
        }
        let sugerencia = {
            id_usuario: req.body.usuario,
            id_clinica: null
        }

          //Primero registramos la clinica
        conexion.query('INSERT INTO cat004_clinica SET ?', clinica, (error, fila)=>{
            if(error){
                throw error
            }else{
                conexion.query('SELECT id FROM cat004_clinica ORDER BY id DESC LIMIT 1', (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        direccion.id_clinica = fila2[0].id
                        sugerencia.id_clinica = fila2[0].id
                        //Ahora registramos la direccion asociada
                        conexion.query('INSERT INTO cat005_direcciones SET ?', direccion, (error3, fila3)=>{
                            if(error3){
                                throw error3
                            }else{
                                //Registramos la sugerencia
                                conexion.query('INSERT INTO op002_sugerencia SET ?', sugerencia, (error4, fila4)=>{
                                    if(error4){
                                        throw error4
                                    }else{
                                        res.render('login', {
                                            alert: true,
                                            alertTitle: 'EXITO',
                                            alertMessage: 'Se ha hecho la sugerencia con éxito, será evaluada, y cuando sea aceptada aparecera en la plataforma',
                                            alertIcon: 'success',
                                            showConfirmButton: true,
                                            timer: 8000,
                                            ruta: 'clinicas'
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
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectSugerencias = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM sugerencias_view001', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.sugerencias = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.descartarSugerencia = async(req, res, next)=>{
    try {
        let id_clinica = req.query.clinica
        let id_sugerencia = req.query.sugerencia

        //Primero eliminamos la direccion
        conexion.query('DELETE FROM cat005_direcciones WHERE id_clinica = ?', [id_clinica], (error, fila)=>{
            if(error){
                throw error
            }else{
                conexion.query('DELETE FROM op002_sugerencia WHERE id = ?', [id_sugerencia], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        conexion.query('DELETE FROM cat004_clinica WHERE id = ?', [id_clinica], (error3, fila3)=>{
                            if(error3){
                                throw error3
                            }else{
                                res.redirect('/sugerencias')
                                return next()
                            }
                        })
                    }
                })
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.aceptarSugerencia = async(req, res, next)=>{
    try {
        let id_clinica = req.query.clinica
        let id_sugerencia = req.query.sugerencia

        conexion.query('DELETE FROM op002_sugerencia WHERE id = ?', [id_sugerencia], (error, fila)=>{
            if(error){
                throw error
            }else{
                //Modificamos el estatus de la clinica
                conexion.query('UPDATE cat004_clinica SET is_checked = 1 WHERE id = ?', [id_clinica], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        res.redirect('/sugerencias')
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
exports.selectClinicas = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM clinicas_view001', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.clinicas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectClinica = async(req, res, next)=>{
    try {
        let clinica = req.query.clinica
        conexion.query('SELECT * FROM clinicas_view001 WHERE id = ?', [clinica], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.clinica = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.seleccionarVeterinarios = async(req, res, next)=>{
    try {
        let clinica = req.query.clinica
        conexion.query('SELECT * FROM veterinario_view002 WHERE id_clinica = ?', [clinica], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.seleccionarClinicaVeterinario = async(req, res, next)=>{
    try {
        let veterinario = req.query.veterinario
        conexion.query('SELECT id_clinica FROM cat003_veterinario WHERE id = ?', [veterinario], (error, fila)=>{
            if(error){
                throw error
            }else{
                let id_clinica = fila[0].id_clinica
                conexion.query('SELECT * FROM clinicas_view001 WHERE id = ?', [id_clinica], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        req.clinica = fila2
                        return next()
                    }
                })
            }
        })
    } catch (error) {
        console.log(error)
        return next
    }
}