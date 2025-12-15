import express from 'express';
import { generateQuestions } from '../controllers/generateQuestion.controller.js';

const router = express.Router();

router.post('/generate-questions', generateQuestions);

export default router;