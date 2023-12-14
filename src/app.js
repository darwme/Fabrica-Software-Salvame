import morgan from 'morgan';
import express from 'express';
import register from './routes/register.routes.js';
import login from './routes/login.routes.js';
import alertsRoutes from './routes/api/index.routes.js';

import { engine } from 'express-handlebars';
import session from 'express-session';

const app = express();
app.use(express.static('public'));
app.use(morgan('combined'));
app.use(express.json());

app.get('/', async (req, res) => {
    res.sendStatus(200);
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
