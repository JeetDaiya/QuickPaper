import { v2 as cloudinary } from 'cloudinary'; // ✅ Use v2 explicitly
import axios from 'axios'; // ✅ Safer than native fetch for older Node versions
import 'dotenv/config';

console.log("Cloud Name:", process.env.CLOUDINARY_CLOUD_NAME);
// Configure Cloudinary
cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_SECRET, // Note: usually CLOUDINARY_API_SECRET
});

export async function fetchPdf(pdfName) {
    try {
        console.log(`Generating URL for PDF: ${pdfName}`);

        // ✅ Generate the URL
        // If your PDF was uploaded as 'raw', change resource_type to 'raw'
        const pdfUrl = cloudinary.url(pdfName, {
            resource_type: 'image', // Most PDFs are 'image' type, but check your dashboard
            format: 'pdf',
            secure: true // Ensure HTTPS
        });

        console.log(`Fetching from: ${pdfUrl}`);

        // ✅ Use Axios to fetch the file as a buffer
        const response = await axios.get(pdfUrl, {
            responseType: 'arraybuffer' // Crucial: Ask for binary data
        });

        // Convert to Base64
        const base64String = Buffer.from(response.data).toString('base64');
        return base64String;

    } catch (error) {
        // Log specific error details for debugging
        if (error.response) {
            console.error(`Cloudinary Error ${error.response.status}:`, error.response.statusText);
        } else {
            console.error('Error fetching PDF:', error.message);
        }
        throw error; // Re-throw so the route handler knows it failed
    }
}