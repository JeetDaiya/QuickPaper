import { GoogleGenAI } from "@google/genai";
import dotenv from 'dotenv';


dotenv.config();
const GEMINI_API_KEY = process.env.GEMINI_API_KEY;


const googleGenAI = new GoogleGenAI({
  apiKey: GEMINI_API_KEY,
});

export async function generateQuestionsService(prompt, pdfData) {
        console.log('Generating Questions...');     
        const response = await googleGenAI.models.generateContent({
            model: "gemini-2.5-flash",
            config : {
                temperature : 0.3,
            },
            contents: [
                {
                    text : prompt, 
                },
                {
                    inlineData : {
                        data : pdfData,
                        mimeType : "application/pdf",

                    }
                }
            ]
        })
        console.log(response.text);
        return response.text;
    
}