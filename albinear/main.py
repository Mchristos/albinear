import pickle
from fastapi import FastAPI, UploadFile
from fastapi.responses import RedirectResponse

app = FastAPI()

@app.post("/api/upload")
async def predict(file: UploadFile):
    return {
        "filename": file.filename, 
    }

@app.get("/", include_in_schema=False)
async def docs_redirect():
    return RedirectResponse(url="/docs")
