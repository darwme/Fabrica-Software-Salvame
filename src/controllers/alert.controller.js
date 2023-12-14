import { pool } from '../models/db.config.js';

export const getAlerts = async (req, res) => {
    try {
        const [results] = await pool.query('CALL GetNormalAlerts()');
        res.json(results);
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al obtener las alertas');
    }
};


