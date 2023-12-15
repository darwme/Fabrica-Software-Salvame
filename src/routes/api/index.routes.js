import {pool} from '../../models/db.config.js';
import { Router } from 'express';
import { getAlerts } from '../../controllers/alert.controller.js';


const router = Router();

router.get('/alertas', getAlerts);

export default router;

