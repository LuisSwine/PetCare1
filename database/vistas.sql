CREATE VIEW consultas_view001 AS SELECT
op001_consultas.id as id,
op001_consultas.id_veterinario as id_veterinario,
cat003_veterinario.cedula as cedula_veterinario,
cat001_usuarios.nombre as veterinario_nombre,
cat001_usuarios.apellido as veterinario_apellido,
cat001_usuarios.celular as veterinario_celular,
cat001_usuarios.correo as veterinario_correo,
cat003_veterinario.id_clinica as id_clinica,
cat004_clinica.nombre as clinica,
cat004_clinica.telefono as clinica_telefono,
cat005_direcciones.calle as clinica_calle,
cat005_direcciones.interior as clinica_interior,
cat005_direcciones.exterior as clinica_exterior,
cat005_direcciones.colonia as clinica_colonia,
cat005_direcciones.municipio as clinica_municipio,
cat005_direcciones.estado as clinica_estado,
cat005_direcciones.codigo_postal as clinica_cp,
op001_consultas.id_mascota as id_mascota,
cat010_mascota.nombre as mascota,
cat010_mascota.id_owner as id_owner,
cat010_mascota.especie as mascota_especie,
cat010_mascota.sexo as mascota_sexo,
op001_consultas.dia as dia,
op001_consultas.hora as hora,
op001_consultas.tipo_consulta as tipo_consulta,
cat011_tipo_consulta.tipo as tipo,
op001_consultas.descripcion as descripcion
FROM op001_consultas
INNER JOIN cat003_veterinario ON op001_consultas.id_veterinario = cat003_veterinario.id
INNER JOIN cat001_usuarios ON cat003_veterinario.id_usuario = cat001_usuarios.id
INNER JOIN cat004_clinica ON cat003_veterinario.id_clinica = cat004_clinica.id
INNER JOIN cat005_direcciones ON cat004_clinica.id = cat005_direcciones.id_clinica
INNER JOIN cat010_mascota ON op001_consultas.id_mascota = cat010_mascota.id
INNER JOIN cat011_tipo_consulta ON op001_consultas.tipo_consulta = cat011_tipo_consulta.id;