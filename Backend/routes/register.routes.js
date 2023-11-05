import { Router } from "express";
import {saveUser} from '../controllers/register.controller.js';
const router = Router();

router.post('/register',saveUser);

export default router;