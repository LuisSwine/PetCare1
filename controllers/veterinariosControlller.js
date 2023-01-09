const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')

exports.selectAllVets = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM veterinario_view002', (error, fila)=>{
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
exports.cambiarClinica = async(req, res, next)=>{
    try {
        veterinario = req.query.veterinario
        clinica = req.query.clinica

        conexion.query('UPDATE cat003_veterinario SET id_clinica = ? WHERE id_usuario = ?', [clinica, veterinario], (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(`/micuentavet?usuario=${veterinario}`)
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
        let veterinario = req.query.usuario
        conexion.query('SELECT * FROM veterinario_view002 WHERE id_usuario = ?', [veterinario], (error, fila)=>{
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
exports.selectVeterinariosConsulta = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM veterinario_view002', (error, fila)=>{
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
exports.selectVeterinariosOwner = async(req, res, next)=>{
    try {
        let owner = req.query.usuario
        conexion.query('SELECT DISTINCT id_veterinario, cedula_veterinario, veterinario_nombre, veterinario_apellido, veterinario_celular, veterinario_correo, id_clinica, clinica FROM consultas_view001 WHERE id_owner = ?', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return error
    }
}
exports.selectVeterinariosOwnerAdmin = async(req, res, next)=>{
    try {
        let owner = req.query.petowner
        conexion.query('SELECT DISTINCT id_veterinario, cedula_veterinario, veterinario_nombre, veterinario_apellido, veterinario_celular, veterinario_correo, id_clinica, clinica FROM consultas_view001 WHERE id_owner = ?', [owner], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return error
    }
}
exports.selectVeterinariosPet = async(req, res, next)=>{
    try {
        let mascota = req.query.mascota
        conexion.query('SELECT DISTINCT id_veterinario, cedula_veterinario, veterinario_nombre, veterinario_apellido, veterinario_celular, veterinario_correo, id_clinica, clinica FROM consultas_view001 WHERE id_mascota = ?', [mascota], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinarios = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return error
    }
}
exports.pacientesVeterinario = async(req, res, next)=>{
    try {
        let veterinario = req.query.usuario
        //obtenemos el id de veterinario
        conexion.query('SELECT id FROM cat003_veterinario WHERE id_usuario = ?', [veterinario], (error, fila)=>{
            if(error){
                throw error
            }else{
                veterinario = fila[0].id
                conexion.query('SELECT DISTINCT id_mascota, mascota, mascota_tipo, mascota_especie, mascota_sexo, id_owner FROM consultas_view001 WHERE id_veterinario = ?', [veterinario], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        req.pacientes = fila2
                        return next()
                    }
                })
            }
        })
        
    } catch (error) {
        console.log(error)
        throw error
    }
}
exports.selecrVeterinario = async(req, res, next)=>{
    try {
        let veterinario = req.query.veterinario
        conexion.query('SELECT * FROM veterinario_view002 WHERE id = ?', [veterinario], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinario = fila[0]
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.comentariosVeterinario = async(req, res, next)=>{
    try {
        let veterinario = req.query.veterinario

        conexion.query('SELECT * FROM comentarios_view001 WHERE id_veterinario = ?', [veterinario], (error, fila)=>{
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
exports.selectConsultas = async(req, res, next)=>{
    try {
        let veterinario = req.query.usuario
        //obtenemos el id de veterinario
        conexion.query('SELECT id FROM cat003_veterinario WHERE id_usuario = ?', [veterinario], (error, fila)=>{
            if(error){
                throw error
            }else{
                veterinario = fila[0].id
                conexion.query('SELECT * FROM consultas_view001 WHERE id_veterinario = ? ORDER BY dia DESC', [veterinario], (error2, fila2)=>{
                    if(error2){
                        throw error2
                    }else{
                        req.consultas = fila2
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