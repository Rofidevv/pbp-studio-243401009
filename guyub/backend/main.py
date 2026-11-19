# Backend Guyub, studio Pertemuan 7: 2 endpoint, GET dan POST.
# Data disimpan di list Python, jadi hilang setiap server dimatikan. Kedepan bisa menggantinya dengan basis data.
from datetime import datetime

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from pydantic import BaseModel, Field

app = FastAPI(title="Guyub")

# CORS = Cross-Origin Resource Sharing. Agar aplikasi Flutter bisa mengakses server FastAPI.
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:62698",
        "http://127.0.0.1:62698",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ItemBaru(BaseModel):
    # Bentuk data yang dikirim aplikasi. Isian yang salah jenis atau kosong dijawab 422 oleh FastAPI.
    judul: str = Field(min_length=1)
    jenis: str = "story"
    poin: int = Field(ge=1) # ge=1 berarti "greater than or equal to 1"
    status: str = "To Do"
    penanggung_jawab: str | None = None


daftar_item = [
    {"id": 1, "kode": "GYB-001", "judul": "Halaman menu roti", "jenis": "story", "poin": 5,
     "status": "Done", "penanggung_jawab": "Sekar", "dibuat_pada": "2026-10-22T08:00:00"},
    {"id": 2, "kode": "GYB-002", "judul": "Form pesanan", "jenis": "story", "poin": 5,
     "status": "Review", "penanggung_jawab": "Bayu", "dibuat_pada": "2026-10-22T08:05:00"},
]


# Endpoint 1: GET | mengambil data, tidak mengubah apa pun.
@app.get("/item")
def ambil_semua_item():
    return daftar_item


# Endpoint 3: POST | mengirim data baru. 201 berarti "sudah dibuat"; bawaan FastAPI 200.
@app.post("/item", status_code=201)
def tambah_item(baru: ItemBaru):
    nomor = len(daftar_item) + 1
    item = {"id": nomor, "kode": f"GYB-{nomor:03d}", **baru.model_dump(),
            "dibuat_pada": datetime.now().isoformat(timespec="seconds")}
    daftar_item.append(item)
    return item
