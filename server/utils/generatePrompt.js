export function generatePrompt(topic, chapter){
    const prompt = `
    Role:
    You are an expert academic examiner and curriculum developer for ${topic}. Your task is to analyze the provided ${chapter} and generate a diverse set of assessment questions. You have to ensure that questions cover easy to medium difficulty levels.
    
    Goal:
    Generate a list of questions based on the content provided. You must categorize each question into one of the specific types listed below and format the output as a strict JSON array. Limit the question number to 15
    
    Output Format:
    Return ONLY a JSON array of objects. Do not include markdown formatting (like \`\`\`json) or conversational text.
    
    JSON Object Schema:
    Each item in the array must follow this structure:
    {
      "id" : sequential integer starting from 1,
      "text": "The main question string",
      "marks": <integer>,
      "type": "<TYPE_ENUM>",
      "data": <Specific Object based on type>
      "answer" : "Correct answer to the question or answer outline for large questions"
    }
    
    Allowed Types and Data Schemas:
    You must select a variety of the following types. Use the exact "data" structure defined for each:
    
    1. MCQ
       - Use for: Multiple choice questions.
       - "data": { "options": ["A) Option 1", "B) Option 2", "C) Option 3", "D) Option 4"]}
    
    2. FILL_BLANK
        - Use for: Fill-in-the-blank questions.
        - "data": { "sentence": "The capital of France is _____."}
    
    2. MATCH_PAIRS
       - Use for: Matching items from two columns.
       - "data": { "pairs": [ {"left": "Item 1", "right": "Match 1"}, {"left": "Item 2", "right": "Match 2"} ] }
    
    3. COMPREHENSION
       - Use for: Questions based on a specific excerpt/passage found in the text.
       - "data": { "passage": "The specific text segment...", "questions": [ {"text": "Sub-question 1?", "marks": 1}, {"text": "Sub-question 2?", "marks": 2} ] }
    
    5. TABLE_DATA
       - Use for: Questions asking to interpret or fill a table.
       - "data": { "headers": ["Column 1", "Column 2"], "rows": [ ["Row1-Val1", "Row1-Val2"], ["Row2-Val1", "Row2-Val2"] ] }
    
    6. WRITING_PROMPT
       - Use for: Long-form creative writing, letters, or reports.
       - "data": { "hints": ["Include introduction", "Focus on X"], "word_limit": 150 }
    
    7. ERROR_CORRECTION
       - Use for: Grammar or factual error identification.
       - "data": { "sentence": "The incorrect sentence...", "error": "The specific error", "correction": "The corrected version" }
    
    8. SHORT_ANS / LONG_ANS / FILL_BLANK / TRUE_FALSE
       - Use for: Standard text-based questions.
       - "data": {} (Must be an empty object)
    
    Task Instructions:
    1. Analyze the uploaded PDF/Text.
    2. Generate at least 10 questions.
    3. Ensure a mix of at least 5 different question types from the list above.
    4. Ensure the JSON is valid and parsable.
    5. COMPREHENSION questions must be only there for English Subject.
    6. MCQ, MATCH_PAIRS and FILL_BLANKS should be of 1 mark only.
    7. SHORT_ANS should be of 2 marks.
    8. LONG_ANS should be of 4 marks.
    9. For each question ensure correct "answer" field is populated. 
    10. If answer is too long, provide an outline of the answer.
    
    Remember, your output MUST be a JSON array of question objects as per the schema above. Do NOT include any explanations or additional text.
    `;
    return prompt;
}