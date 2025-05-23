from fastapi import FastAPI
from pydantic import BaseModel
import re

app = FastAPI()

# База знаний с ключевыми словами и ответами
KNOWLEDGE_BASE = [
    {
        "keywords": ["фицт", "физтех", "факультет информационных технологий"],
        "questions": ["какие экзамены", "что сдавать", "вступительные испытания"],
        "answer": "Для поступления на ФИЦТ нужно сдать: математика (профиль), русский язык, физика или информатика (на выбор)."
    },
    {
        "keywords": ["документ", "справк", "заявлен"],
        "questions": ["какие документы", "что нужно предоставить", "список документов"],
        "answer": "Нужны: паспорт, аттестат, результаты ЕГЭ, 2 фото 3x4, медицинская справка 086/у."
    },
    {
        "keywords": ["проходной балл", "конкурс", "балл"],
        "questions": ["проходной балл", "минимальный балл", "конкурс"],
        "answer": "Проходной балл на ФИЦТ в 2024 году: бюджет - 245, контракт - 190."
    },
    {
        "keywords": ["срок подачи", "когда подавать", "дата"],
        "questions": ["до какого числа подавать документы", "сроки подачи заявлений"],
        "answer": "Документы на бюджет можно подать с 20 июня по 25 июля."
    },
    {
        "keywords": ["общежитие", "жилье", "проживание"],
        "questions": ["предоставляется ли общежитие", "есть ли жилье для иногородних"],
        "answer": "Иногородним студентам предоставляется общежитие в 10 минутах от кампуса."
    }
]

class ChatRequest(BaseModel):
    message: str

def find_answer(user_message):
    user_message = user_message.lower()

    for item in KNOWLEDGE_BASE:
        if any(keyword in user_message for keyword in item["keywords"]):
            if any(question in user_message for question in item["questions"]):
                return item["answer"]
            return f"Уточните вопрос про {item['keywords'][0]}. Например: '{item['questions'][0]}'"

    return "Я могу помочь с вопросами о поступлении. Спросите о факультетах, экзаменах или документах."

@app.post("/chat")
async def chat_response(request: ChatRequest):
    return {"response": find_answer(request.message)}

@app.get("/health")
async def health_check():
    return {"status": "ok"}