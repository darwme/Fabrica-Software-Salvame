// En informes.controller.js

import pool from '../models/db.config.js';

const getInformes = async (req, res) => {
  try {
    const nombreCientifico = req.query.nombreCientifico || null;
    const nombreComun = req.query.nombreComun || null;
    const departamento = req.query.departamento || null;
    const provincia = req.query.provincia || null;

    const connection = await pool.getConnection();

    try {
      const [results] = await connection.query('CALL VisualizarInforme(?, ?, ?, ?)', [nombreCientifico, nombreComun, departamento, provincia]);
      res.status(200).json(results[0]);
    } finally {
      connection.release();
    }
  } catch (error) {
    console.error(error);
    res.status(500).send(error);
  }
};

export { getInformes };
