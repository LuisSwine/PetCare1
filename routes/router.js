//Llamamos tambien al modulo de express
const express = require('express')

const router = express.Router()
const { authorized } = require('../database/db')

const usuariosController = require('../controllers/usuariosController')
const mascotasController = require('../controllers/mascotasController')
const veterinariosController = require('../controllers/veterinariosControlller')
const clinicasController = require('../controllers/clinicasController')
const consultasController =  require('../controllers/consultasController')
const comentariosController = require('../controllers/comentariosController')

router.get('/', (req, res)=>{
    res.render('index')
})
router.get('/login', (req, res)=>{
    res.render('login', {alert: false})
})
router.post('/login', usuariosController.login)
router.get('/signup', (req, res)=>{
    res.render('signup', {alert: false})
})
router.post('/signup', usuariosController.registrarUsuario)

router.get('/dashboard', usuariosController.isAuthenticated, comentariosController.selectComentarios, clinicasController.selectClinicas, (req, res)=>{
    res.render('main', {usuario: req.user, comentarios: req.comentarios, clinicas: req.clinicas})
})

router.get('/micuentapo', usuariosController.isAuthenticated, mascotasController.selectMascotas, consultasController.selectConsultasOwner, consultasController.selectConsultasProximasOwner, veterinariosController.selectVeterinariosOwner, (req, res)=>{
    res.render('micuentapo', {usuario: req.user, mascotas: req.mascotas, consultas: req.consultas, consultasproximas: req.consultasproximas, veterinarios: req.veterinarios})
})
router.get('/micuentavet', usuariosController.isAuthenticated, usuariosController.selectInfoVet, clinicasController.selectClinicas, veterinariosController.selectClinica, veterinariosController.pacientesVeterinario, veterinariosController.selectConsultas, (req, res)=>{
    res.render('micuentavet', {usuario: req.user, veterinario: req.veterinario, clinicas: req.clinicas, clinica: req.clinica, pacientes: req.pacientes, consultas: req.consultas})
})
router.get('/perfilpo', usuariosController.isAuthenticated, usuariosController.selectInfoPetOwner, mascotasController.selectMascotasAdmin, consultasController.selectConsultasOwnerAdmin, consultasController.selectConsultasProximasOwnerAdmin, veterinariosController.selectVeterinariosOwnerAdmin, (req, res)=>{
    res.render('perfilpetowner', {usuario: req.user, petownerinfo: req.petownerinfo, mascotas: req.mascotas, consultas: req.consultas, consultasproximas: req.consultasproximas, veterinarios: req.veterinarios})
})
router.get('/cambiarclinica', veterinariosController.cambiarClinica)
router.get('/actualizarNombreApellidoUsuario', usuariosController.editNombreApellido)
router.get('/cambiarCorreoUsuario', usuariosController.editCorreo)
router.get('/cambiarCelularUsuario', usuariosController.editCelular)
router.get('/cambiarcontrausuario', usuariosController.cambiarContra)
router.get('/definirCedulaVet', usuariosController.definirCedula)
router.get('/mismascotas', usuariosController.isAuthenticated, mascotasController.selectMascotas, (req, res)=>{
    res.render('mismascotas', {usuario: req.user, mascotas: req.mascotas})
})
router.get('/nuevamascota', usuariosController.isAuthenticated, mascotasController.selectTiposMascota, mascotasController.selectEspeciesMascota, (req, res)=>{
    res.render('agregarmascota', {usuario: req.user, alert: false, tipos_mascota: req.tipos_mascota, especies: req.especies})
})
router.post('/nuevamascota', mascotasController.nuevaMascota)
router.get('/perfilmascota', usuariosController.isAuthenticated, mascotasController.selectMascota, consultasController.selectConsultasProximasPet, veterinariosController.selectVeterinariosPet, (req, res)=>{
    res.render('perfilmascota', {usuario: req.user, mascota: req.mascota, consultasproximas: req.consultasproximas, veterinarios: req.veterinarios})
})
router.get('/actualizarNombreMascota', mascotasController.editNombreMascota)
router.get('/deletemascota', mascotasController.deleteMascota)
router.get('/veterinarios', usuariosController.isAuthenticated, veterinariosController.selectAllVets, (req, res)=>{
    res.render('veterinarios', {usuario: req.user, veterinarios: req.veterinarios})
})
router.get('/perfilveterinario', usuariosController.isAuthenticated, veterinariosController.selecrVeterinario, clinicasController.seleccionarClinicaVeterinario, veterinariosController.comentariosVeterinario, (req, res)=>{
    res.render('perfilveterinario', {usuario: req.user, veterinario: req.veterinario, clinica: req.clinica, comentarios: req.comentarios})
})
router.get('/clinicas', usuariosController.isAuthenticated, clinicasController.selectClinicas, (req, res)=>{
    res.render('clinicas', {usuario: req.user, clinicas: req.clinicas})
})
router.get('/perfilclinica', usuariosController.isAuthenticated, clinicasController.selectClinica, clinicasController.seleccionarVeterinarios, (req, res)=>{
    res.render('perfilClinica', {usuario: req.user, clinica: req.clinica, veterinarios: req.veterinarios})
})
router.get('/sugerirclinica', usuariosController.isAuthenticated, (req, res)=>{
    res.render('sugerirclinica', {usuario: req.user})
})
router.post('/sugerirclinica', clinicasController.sugerirClinica)
router.get('/petowners', usuariosController.isAuthenticated, usuariosController.selectPetOwners, (req, res)=>{
    res.render('petowners', {usuario: req.user, petowners: req.petowners})
})
router.get('/adminveterinarios', usuariosController.isAuthenticated, veterinariosController.selectAllVets, (req, res)=>{
    res.render('vetadmin', {usuario: req.user, veterinarios: req.veterinarios})
})
router.get('/sugerencias', usuariosController.isAuthenticated, clinicasController.selectSugerencias, (req, res)=>{
    res.render('sugerencias', {usuario: req.user, sugerencias: req.sugerencias})
})
router.get('/aceptarsugerencia', clinicasController.aceptarSugerencia)
router.get('/descartarsugerencia', clinicasController.descartarSugerencia)
router.get('/agendarcita', usuariosController.isAuthenticated, mascotasController.selectMascotas, veterinariosController.selectVeterinariosConsulta, consultasController.selectTiposConsultas, (req, res)=>{
    res.render('agendarcita', {usuario: req.user, mascotas: req.mascotas, veterinarios: req.veterinarios, tipos: req.tipos_consultas, clinica: req.query.clinica, veterinario_s: req.query.veterinario})
})
router.post('/agendarcita', consultasController.agendarCita)
router.get('/reagendarcita', consultasController.reagendarCita)
router.get('/cancelarcita', consultasController.cancelarCita)
router.get('/cancelarcitavet', consultasController.cancelarCitaVet)
router.get('/addcomment', usuariosController.isAuthenticated, veterinariosController.selecrVeterinario, (req, res)=>{
    res.render('formcomentario', {usuario: req.user, veterinario: req.veterinario})
})
router.post('/addcomment', comentariosController.addComentario)
router.get('/admincomentarios', usuariosController.isAuthenticated, comentariosController.selectComentariosAdmin, (req, res)=>{
    res.render('admincomentarios', {usuario: req.user, comentarios: req.comentarios})
})
router.get('/deletecomentario', comentariosController.deleteComentario)
router.get('/logout', usuariosController.logout)

module.exports = router