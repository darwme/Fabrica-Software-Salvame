import {pool} from '../db.js';
import { Router } from 'express';
import {searchUser} from '../controllers/login.controller.js'
const router = Router();

router.post('/login', searchUser);

export default router

