import { pool } from "../models/db.config.js";

export const  saveUser = async (req, res)=>{
    const {nombres,apellidos,correo, password,fecha} = req.body;
    console.log(correo, password);
    //roles
    //moderador, suscriptor, basic
    await pool.query("insert into perfil_usuario values ('basico')");
    const [id] = await pool.query("SELECT idPerfilUsuario FROM perfil_usuario ORDER BY idPerfilUsuario DESC LIMIT 1;");
    const saveIn =id[0].idPerfilUsuario;
    await pool.query(`insert into usuario_basico values (null, ${saveIn}, '${nombres}', '${apellidos}','${correo}', '${password}', '${fecha}');`)
    console.log(id[0].idPerfilUsuario);
    res.send("usuario registrado");
    //res.redirect('path'); //vista de la pagina principal
}