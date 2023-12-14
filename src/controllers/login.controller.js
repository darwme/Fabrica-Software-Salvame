import { pool } from "../models/db.config.js";
import jwt from 'jsonwebtoken'

export const searchUser = async (req, res) => {
    const {correo , password} = req.body;
    console.log(correo, password);
    const [result] = await pool.query(`select * from usuario_basico where correo = '${correo}';`);
    console.log(result);
    if(result.length === 0 ){
        res.send('no se encontro al usuario');
        return;
    }
    else if (result[0]['contraseña'] !== password){
        res.send('contraseña o usuario incorrecto')
        return;
    }
    else{
        res.send('login exitoso')
       return;
    }
}