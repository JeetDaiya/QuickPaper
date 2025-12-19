import cloudinary from 'cloudinary';
import config from '../config/cloudinary_config.js';



export async function fetchPdf(pdfName){
    // fetchs pdf from cloudinary storage and returns base64 data
    try {
        const pdfUrl = cloudinary.v2.url(pdfName, {resource_type: 'image' , format : 'pdf'});
        const response = await fetch(pdfUrl);
        if(!response.ok){
            throw new Error(`Failed to fetch PDF: ${response.statusText}`);
        }
        const arrayBuffer = await response.arrayBuffer();
        const base64String = Buffer.from(arrayBuffer).toString('base64');
        
        return base64String;

    } catch (error) {
        console.error('Error fetching PDF:', error);
        throw error;
    }
}

