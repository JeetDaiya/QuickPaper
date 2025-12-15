import {fileURLToPath} from "url";
import fs from "fs";
import path from "path";

export async function fetchPdf(pdfName){
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    const pdfPath = path.join(__dirname, `../samplePdfs/${pdfName}`);
    const fileBuffer = fs.readFileSync(pdfPath);
    return fileBuffer.toString('base64');

}