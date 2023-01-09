const jwt = require('jsonwebtoken')
const bcryptjs = require('bcryptjs')
const conexion = require('../database/db')
const {promisify} = require('util')
const { query } = require('../database/db')
const { nextTick } = require('process')

//Funcion para registrar nuevo Usuario
exports.registrarUsuario = async(req, res, next)=>{
    try {
        //Recibimos los datos
        let data = {
            nombre: req.body.nombre,
            apellido: req.body.apellido,
            correo: req.body.correo,
            celular: req.body.telefono,
            pass: await bcryptjs.hash(req.body.contra, 8),
            tipo_usuario: req.body.tipo
        }

        //Validamos si ya existe un usuario con ese correo
        conexion.query("SELECT * FROM cat001_usuarios WHERE correo = ?", [data.correo], (error, fila)=>{
            if(error){
                throw error
            }else{
                if(fila.length === 0){
                    //Procedemos con la insercion
                    conexion.query('INSERT INTO cat001_usuarios SET ?', data, (error2, fila2)=>{
                        if(error2){
                            throw error2
                        }else{
                            if(data.tipo_usuario == 2){
                                conexion.query('SELECT id FROM cat001_usuarios WHERE correo = ?', [data.correo], (error2, fila2)=>{
                                    if(error2){
                                        throw error2
                                    }else{
                                        let id = fila2[0].id
                                        conexion.query('INSERT INTO cat003_veterinario SET id_usuario = ?', [id], (error3, fila3)=>{
                                            if(error3){
                                                throw error3
                                            }else{
                                                res.render('login', {
                                                    alert: true,
                                                    alertTitle: 'Registro Exitoso',
                                                    alertMessage: 'Al iniciar sesion dirigete al apartado de Mi Cuenta para ingresar tu numero de cedula profesional, es muy importante',
                                                    alertIcon: 'success',
                                                    showConfirmButton: true,
                                                    timer: 32000,
                                                    ruta: 'login' 
                                                })
                                                return next()
                                            }
                                        }) 
                                    }
                                })
                            }else{
                                res.render('login', {
                                    alert: true,
                                    alertTitle: 'Registro Exitoso',
                                    alertMessage: 'Ya puedes iniciar sesion',
                                    alertIcon: 'success',
                                    showConfirmButton: true,
                                    timer: 8000,
                                    ruta: 'login' 
                                })
                                return next()
                            }
                        }
                    })
                }else{
                    res.render('signup', {
                        alert: true,
                        alertTitle: 'ADVERTENCIA',
                        alertMessage: 'El correo ya esta registrado',
                        alertIcon: 'info',
                        showConfirmButton: true,
                        timer: 8000,
                        ruta: 'signup' 
                    })
                    return next()
                }
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.login = async(req, res, next)=>{
    try {
        let correo = req.body.usuario
        let contra = req.body.contra

        conexion.query('SELECT * FROM cat001_usuarios WHERE correo = ?', [correo], async(error, fila)=>{
            if(error){
                throw error
            }else{
                if(fila.length === 0 || !(await bcryptjs.compare(contra, fila[0].pass))){
                    res.render('login', {
                        alert: true,
                        alertTitle: 'Error al iniciar sesion',
                        alertMessage: 'El usuario no esta registrado o no esta bien escrito, o la contraseña no coincide',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: 8000,
                        ruta: 'login' 
                    })
                }else{
                    const id = fila[0].id
                    const token = jwt.sign({id: id}, process.env.JWT_SECRETO, {
                        expiresIn: process.env.JWT_TIEMPO_EXPIRA
                    })

                    const cookiesOptions = {
                        expires: new Date(Date.now() + process.env.JWT_COOKIE_EXPIRA * 24 * 60 * 60 * 1000),
                        httpOnly: true
                    }
                    res.cookie('jwt', token, cookiesOptions)

                    //Redireccionamos al dashboard
                    res.render('login', {
                        alert: true,
                        alertTitle: 'Conexion exitosa',
                        alertMessage: '¡INICIO DE SESION EXITOSO!',
                        alertIcon: 'success',
                        showConfirmButton: false,
                        timer: 800,
                        ruta: `dashboard`
                    })
                }
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.isAuthenticated = async(req, res, next) =>{
    if(req.cookies.jwt){
        try {
            const decode = await promisify(jwt.verify)(req.cookies.jwt, process.env.JWT_SECRETO)
            conexion.query('SELECT * FROM cat001_usuarios WHERE id = ?', [decode.id], (error, results)=>{
                if(!results){return next()}
                req.user = results[0]
                return next()
            })
        } catch (error) {
            console.log(error)
            return next()
        } 
    }else{
        res.redirect('/login')
    }
}
exports.editNombreApellido = async(req, res, next)=>{
    try {
        let nombre = req.query.nombre
        let apellido = req.query.apellido
        let id = req.query.id
        let tipo = req.query.tipo

        let ruta = ''
        if(tipo == 3){
            ruta = `/micuentapo?usuario=${id}`
        }else if (tipo == 2){
            ruta = `/micuentavet?usuario=${id}`
        }

        conexion.query('UPDATE cat001_usuarios SET nombre = ?, apellido = ? WHERE id = ?', [nombre, apellido, id], (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(ruta)
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.editCorreo = async(req, res, next)=>{
    try {
        let correo = req.query.correo
        let id = req.query.id
        let tipo = req.query.tipo

        let ruta = ''
        if(tipo == 3){
            ruta = `/micuentapo?usuario=${id}`
        }else if (tipo == 2){
            ruta = `/micuentavet?usuario=${id}`
        }

        conexion.query('UPDATE cat001_usuarios SET correo = ? WHERE id = ?', [correo, id], (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(ruta)
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.editCelular = async(req, res, next)=>{
    try {
        let celular = req.query.celular
        let id = req.query.id
        let tipo = req.query.tipo

        let ruta = ''
        if(tipo == 3){
            ruta = `/micuentapo?usuario=${id}`
        }else if (tipo == 2){
            ruta = `/micuentavet?usuario=${id}`
        }

        conexion.query('UPDATE cat001_usuarios SET celular = ? WHERE id = ?', [celular, id], (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(ruta)
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectInfoVet = async(req, res, next)=>{
    try {
        let usuario = req.query.usuario
        conexion.query('SELECT * FROM cat003_veterinario WHERE id_usuario = ?', [usuario], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.veterinario = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.definirCedula = async(req, res, next)=>{
    try {
        let cedula = req.query.cedula
        let usuario = req.query.id

        conexion.query('UPDATE cat003_veterinario SET cedula = ? WHERE id_usuario = ?', [cedula, usuario], (error, fila)=>{
            if(error){
                throw error
            }else{
                res.redirect(`/micuentavet?usuario=${usuario}`)
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.selectPetOwners = async(req, res, next)=>{
    try {
        conexion.query('SELECT * FROM cat001_usuarios WHERE tipo_usuario = 3', (error, fila)=>{
            if(error){
                throw error
            }else{
                req.petowners = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.cambiarContra = async(req, res, next)=>{
    try {
        let actual = req.query.actual
        let nueva = await bcryptjs.hash(req.query.nueva, 8)
        let usuario = req.query.usuario

        //primero confirmamos la contraseña actual
        conexion.query('SELECT pass FROM cat001_usuarios WHERE id = ?', [usuario], async(error, fila)=>{
            if(error){
                throw error
            }else{
                if(!(await bcryptjs.compare(actual, fila[0].pass))){
                    let ruta = `micuentapo?usuario=${usuario}`
                    res.render('login', {
                        alert: true,
                        alertTitle: 'Ha ocurrido un problema',
                        alertMessage: 'Tu contraseña no coincide con la contraseña ingresada',
                        alertIcon: 'error',
                        showConfirmButton: true,
                        timer: 8000,
                        ruta: ruta
                    })
                    return next()
                }else{
                    conexion.query('UPDATE cat001_usuarios SET pass = ? WHERE id = ?', [nueva, usuario], (error2, fila2)=>{
                        if(error2){
                            throw error2
                        }else{
                            let ruta = `micuentapo?usuario=${usuario}`
                            res.render('login', {
                                alert: true,
                                alertTitle: 'Cambio Correcto',
                                alertMessage: 'Tu contraseña se ha actualizado con exito',
                                alertIcon: 'success',
                                showConfirmButton: true,
                                timer: 8000,
                                ruta: ruta
                            })
                            return next()
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
exports.selectInfoPetOwner = async(req, res, next)=>{
    try {
        let usuario = req.query.petowner
        conexion.query('SELECT * FROM cat001_usuarios WHERE id = ?', [usuario], (error, fila)=>{
            if(error){
                throw error
            }else{
                req.petownerinfo = fila
                return next()
            }
        })
    } catch (error) {
        console.log(error)
        return next()
    }
}
exports.logout = (req, res) =>{
    res.clearCookie('jwt')
    return res.redirect('/login')
}