const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')
const { on } = require('events')

exports.agendarCita = async(req, res, next)=>{
    try {
        let consulta = {
            id_veterinario: req.body.veterinario,
            id_mascota: req.body.mascota,
            dia: req.body.fecha,
            hora: req.body.hora,
            tipo_consulta: req.body.tipo, 
            descripcion: req.body.descripcion
        }
        let clinica = req.body.clinica
        let id_usuario = req.body.id_usuario

        //Consultamos los horarios de la clinica
        conexion.query('SELECT hora_entrada, hora_salida FROM cat004_clinica WHERE id = ?', [clinica], (error, fila)=>{
            if(error){
                throw error
            }else{
                hora_in = fila[0].hora_entrada
                hora_out = fila[0].hora_salida

                //Validamos que el horario elegido este dentro de los horarios de la clinica
                if(consulta.hora < hora_in || consulta.hora > hora_out){
                    let ruta = `agendarcita?usuario=${id_usuario}`
                    res.render('login', {
                        alert: true,
                        alertTitle: 'ERROR',
                        alertMessage: 'Hora seleccionada fuera del horario de servicio de la clinica',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: 8000,
                        ruta: ruta 
                    })
                    return next()
                }else{
                    //Validamos que el horario este disponible
                    conexion.query('SELECT id FROM op001_consultas WHERE id_veterinario = ? AND dia = ? AND hora = ?', [consulta.id_veterinario, consulta.dia, consulta.hora], (error2, fila2)=>{
                        if(error2){
                            throw error2
                        }else{
                            if(fila2.length === 0){
                                //Ahora si agendamos la consulta
                                conexion.query('INSERT INTO op001_consultas SET ?', consulta, (error3, fila3)=>{
                                    if(error3){
                                        throw error3
                                    }else{
                                        res.render('login', {
                                            alert: true,
                                            alertTitle: 'CITA GENERADA CON EXITO',
                                            alertMessage: 'Tu cita se ha registrado con exito, puedes consultarla en tu cuenta',
                                            alertIcon: 'success',
                                            showConfirmButton: true,
                                            timer: 8000,
                                            ruta: 'dashboard' 
                                        })
                                        return next()
                                    }
                                })
                            }else{
                                let ruta = `agendarcita?usuario=${id_usuario}`
                                res.render('login', {
                                    alert: true,
                                    alertTitle: 'ERROR',
                                    alertMessage: 'Hora seleccionada no disponible, por favor considere 30 minutos mas o menos tarde',
                                    alertIcon: 'error',
                                    showConfirmButton: true,
                                    timer: 8000,
                                    ruta: ruta 
                                })
                                return next()
                            }

                        }
                    })
                }
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectTiposConsultas = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM cat011_tipo_consulta', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.tipos_consultas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectConsultasOwner = async(req, res, next)=>{
    try {
        let owner = req.query.usuario
        conexion.query('SELECT * FROM consultas_view001 WHERE id_owner = ? ORDER BY dia DESC', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.consultas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectConsultasOwnerAdmin = async(req, res, next)=>{
    try {
        let owner = req.query.petowner
        conexion.query('SELECT * FROM consultas_view001 WHERE id_owner = ? ORDER BY dia DESC', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.consultas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectConsultasProximasOwner = async(req, res, next)=>{
    try {
        let owner = req.query.usuario
        let today = new Date()
        conexion.query('SELECT * FROM consultas_view001 WHERE id_owner = ? AND dia > ? ORDER BY dia DESC', [owner, today], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.consultasproximas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectConsultasProximasOwnerAdmin = async(req, res, next)=>{
    try {
        let owner = req.query.petowner
        let today = new Date()
        conexion.query('SELECT * FROM consultas_view001 WHERE id_owner = ? AND dia > ? ORDER BY dia DESC', [owner, today], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.consultasproximas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectConsultasProximasPet = async(req, res, next)=>{
    try {
        let mascota = req.query.mascota
        let today = new Date()
        conexion.query('SELECT * FROM consultas_view001 WHERE id_mascota = ? AND dia > ? ORDER BY dia DESC', [mascota, today], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.consultasproximas = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.reagendarCita = async(req, res, next)=>{
    try {
        let id_usuario = req.query.usuario
        let clinica = req.query.clinica
        let veterinario = req.query.veterinario
        let consulta = req.query.consulta
        let dia = req.query.dia
        let hora = req.query.hora

        conexion.query('SELECT hora_entrada, hora_salida FROM cat004_clinica WHERE id = ?', [clinica], (error, fila)=>{
            if(error){
                throw error
            }else{
                hora_in = fila[0].hora_entrada
                hora_out = fila[0].hora_salida

                //Validamos que el horario elegido este dentro de los horarios de la clinica
                if(hora < hora_in || hora > hora_out){
                    let ruta = `micuentapo?usuario=${id_usuario}`
                    res.render('login', {
                        alert: true,
                        alertTitle: 'ERROR',
                        alertMessage: 'Hora seleccionada fuera del horario de servicio de la clinica',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: 8000,
                        ruta: ruta 
                    })
                    return next()
                }else{
                    //Validamos que el horario este disponible
                    conexion.query('SELECT id FROM op001_consultas WHERE id_veterinario = ? AND dia = ? AND hora = ?', [veterinario, dia, hora], (error2, fila2)=>{
                        if(error2){
                            throw error2
                        }else{
                            if(fila2.length === 0){
                                conexion.query('UPDATE op001_consultas SET dia = ?, hora = ? WHERE id = ?', [dia, hora, consulta], (error, fila)=>{
                                    if(error){
                                        throw error
                                    }else{
                                        let ruta = `micuentapo?usuario=${id_usuario}`
                                            res.render('login', {
                                                alert: true,
                                                alertTitle: 'EXITO',
                                                alertMessage: 'Cita reagendada con exito',
                                                alertIcon: 'success',
                                                showConfirmButton: true,
                                                timer: 8000,
                                                ruta: ruta 
                                            })
                                            return next()
                                    }
                                })
                            }else{
                                let ruta = `micuentapo?usuario=${id_usuario}`
                                res.render('login', {
                                    alert: true,
                                    alertTitle: 'ERROR',
                                    alertMessage: 'Hora seleccionada no disponible, por favor considere 30 minutos mas o menos tarde',
                                    alertIcon: 'error',
                                    showConfirmButton: true,
                                    timer: 8000,
                                    ruta: ruta 
                                })
                                return next()
                            }

                        }
                    })
                }
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.cancelarCita = async(req, res, next)=>{
    try {
        let consulta = req.query.cita
        let usuario = req.query.usuario

        conexion.query('DELETE FROM op001_consultas WHERE id = ?', [consulta], (error, fila)=>{
            if(error){
                throw error
            }else{
                let ruta = `micuentapo?usuario=${usuario}`
                res.render('login', {
                    alert: true,
                    alertTitle: 'EXITO',
                    alertMessage: 'Cita cancelada con exito',
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
exports.cancelarCitaVet = async(req, res, next)=>{
    try {
        let consulta = req.query.cita
        let usuario = req.query.usuario

        conexion.query('DELETE FROM op001_consultas WHERE id = ?', [consulta], (error, fila)=>{
            if(error){
                throw error
            }else{
                let ruta = `micuentavet?usuario=${usuario}`
                res.render('login', {
                    alert: true,
                    alertTitle: 'EXITO',
                    alertMessage: 'Cita cancelada con exito',
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