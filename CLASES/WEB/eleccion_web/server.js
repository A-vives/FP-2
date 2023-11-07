const express = require('express');
const { Pool } = require('pg');

const app = express();
app.use(express.json());

// Configurar la conexión a la base de datos PostgreSQL
const pool = new Pool({
    user: 'tu_usuario',
    host: 'localhost',
    database: 'tu_base_de_datos',
    password: 'tu_contraseña',
    port: 5432,
});

// Manejar la solicitud para guardar la elección del usuario
app.post('/guardar-eleccion', async (req, res) => {
    const opcion = req.body.opcion;

    try {
        await pool.query('INSERT INTO elecciones (opcion) VALUES ($1)', [opcion]);
        res.status(200).send('Elección guardada en la base de datos.');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al guardar la elección en la base de datos.');
    }
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
    console.log('Servidor iniciado en el puerto 3000');
});
