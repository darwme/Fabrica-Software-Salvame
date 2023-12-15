import express from 'express';
import { getInformes } from '../controllers/informes.controller.js';

const informesRouter = express.Router();

informesRouter.get('/', getInformes);

export default informesRouter;
