import { fetchPdf } from "../services/fetchPdf.service.js";
import { generateQuestionsService } from "../services/generateQuestions.service.js";
import { generatePrompt } from "../utils/generatePrompt.js";
import fs from 'fs';

export async function generateQuestions(req, res) {
    const { topic, chapter} = req.body;
    console.log('Received Request');
    
    try{
        const fileName = `${topic}_${chapter}.pdf`;
        const pdfData = await fetchPdf(fileName);
        const prompt = generatePrompt(topic, chapter);
        const response = await generateQuestionsService(prompt, pdfData);
        // const jsonFile = fs.readFileSync('tempData.json', 'utf-8');
        // const jsonData = JSON.parse(jsonFile);
        console.log('Questions Generated Successfully');
        res.status(200).json({
            success: true,
            data: response
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            success: false,
            status : error.status || 500,
            message: error.message || "Internal Server Error"
        });
    }
}