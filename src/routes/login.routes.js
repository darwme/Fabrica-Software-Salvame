import {pool} from '../models/db.config.js';
import { Router } from 'express';
import {searchUser} from '../controllers/login.controller.js'
const router = Router();

router.post('/login', searchUser);

export default router

