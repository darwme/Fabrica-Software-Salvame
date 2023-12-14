import morgan from 'morgan';
import express from 'express';
import register from './routes/register.routes.js';
import login from './routes/login.routes.js';
import alertsRoutes from './routes/api/index.routes.js';
import path from 'path';

import { engine } from 'express-handlebars';
import session from 'express-session';

// Ajustando __filename para Windows
import url from 'url';

// Obtener la ruta actual del archivo del módulo ES
const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
app.use(morgan('combined'));
app.use(express.json());

// Configuración de handlebars (ajusta según tus necesidades)
app.engine('html', engine());
app.set('view engine', 'html');

// Configuración de la carpeta estática
app.use(express.static(path.join(__dirname, '../public')));

// Ruta principal para mostrar index.html
app.get('/', (req, res) => {
    // Usa path.resolve para asegurarte de que tienes una ruta absoluta
    const indexPath = path.resolve(__dirname, '../public', 'index.html');
    res.sendFile(indexPath);
});

// Ruta para mostrar la página de login, cambiar
app.get('/login', (req, res) => {
    res.render('login');
});

// Ruta para acceder a mis-alertas.html en la carpeta estática
app.get('/:id/', (req, res) => {
    // Asegúrate de que la ruta al archivo es absoluta
    const filePath = path.join(__dirname, '../public', 'Sections', 'user', 'index.html');
    res.sendFile(filePath);
});


// Ruta para acceder a mis-alertas.html en la carpeta estática
app.get('/:id/mis-alertas', (req, res) => {
    // Asegúrate de que la ruta al archivo es absoluta
    const filePath = path.join(__dirname, '../public', 'Sections', 'user', 'mis-alertas.html');
    res.sendFile(filePath);
});

app.use('/api', alertsRoutes);
app.use(register);
app.use(login);

app.use(express.urlencoded({ extended: true }));

app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));

app.listen(3000, () => {
    console.log('App listening on port 3000!');
});
