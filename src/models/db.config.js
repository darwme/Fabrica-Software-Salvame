//const db =require('mysql2');
import { createPool } from 'mysql2/promise';

export const pool = createPool({
    host:'localhost',
    user: 'root',
    password: 'spideyforever',
    port: 3306,
    database: 'proyecto_salvame'
})

const result = pool.query('select * from alerta');
console.log(result);