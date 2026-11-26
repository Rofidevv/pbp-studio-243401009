# Backend Guyub kelas PBP 2026.1, dipanggil aplikasi Flutter mahasiswa mulai Pertemuan 7.
# Data di list Python: kembali ke lima kartu awal setiap container dinyalakan ulang.
from datetime import datetime
from typing import Literal

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field

app = FastAPI(title="Guyub")

# Flutter web berjalan di localhost dengan port acak, jadi semua asal diizinkan.
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])

BATAS_ITEM = 300


class ItemBaru(BaseModel):
    judul: str = Field(min_length=1, max_length=80)
    jenis: Literal["story", "bug"] = "story"
    poin: int = Field(ge=1, le=100)
    status: Literal["To Do", "In Progress", "Review", "Done"] = "To Do"
    penanggung_jawab: str | None = Field(default=None, max_length=50)


class ItemUbah(BaseModel):
    # Hanya dua field yang boleh diubah; field lain (judul, poin) ditolak dengan 422.
    model_config = {"extra": "forbid"}
    status: Literal["To Do", "In Progress", "Review", "Done"] | None = None
    penanggung_jawab: str | None = Field(default=None, max_length=50)


daftar_item = [
    {"id": 1, "kode": "GYB-001", "judul": "Halaman menu roti", "jenis": "story", "poin": 5,
     "status": "Done", "penanggung_jawab": "Sekar", "dibuat_pada": "2026-10-22T08:00:00"},
    {"id": 2, "kode": "GYB-002", "judul": "Form pesanan", "jenis": "story", "poin": 5,
     "status": "Review", "penanggung_jawab": "Bayu", "dibuat_pada": "2026-10-22T08:05:00"},
    {"id": 3, "kode": "GYB-003", "judul": "Tombol pesan tidak aktif di Safari", "jenis": "bug", "poin": 2,
     "status": "In Progress", "penanggung_jawab": "Dimas", "dibuat_pada": "2026-10-22T08:10:00"},
    {"id": 4, "kode": "GYB-004", "judul": "Ongkir dihitung per kecamatan", "jenis": "story", "poin": 3,
     "status": "To Do", "penanggung_jawab": "Bayu", "dibuat_pada": "2026-10-22T08:15:00"},
    {"id": 5, "kode": "GYB-005", "judul": "Foto produk lambat dimuat", "jenis": "bug", "poin": 2,
     "status": "To Do", "penanggung_jawab": None, "dibuat_pada": "2026-10-22T08:20:00"},
]


@app.get("/item")
def ambil_semua_item():
    return daftar_item


@app.get("/item/{id}")
def ambil_satu_item(id: int):
    for item in daftar_item:
        if item["id"] == id:
            return item
    raise HTTPException(status_code=404, detail="Item tidak ditemukan")


@app.post("/item", status_code=201)
def tambah_item(baru: ItemBaru):
    # Server dipakai bersama satu kelas di internet: dibatasi supaya tidak bisa diisi tanpa batas.
    if len(daftar_item) >= BATAS_ITEM:
        raise HTTPException(status_code=403, detail="Server kelas penuh, tunggu dosen mengosongkan")
    nomor = len(daftar_item) + 1
    item = {"id": nomor, "kode": f"GYB-{nomor:03d}", **baru.model_dump(),
            "dibuat_pada": datetime.now().isoformat(timespec="seconds")}
    daftar_item.append(item)
    return item


@app.patch("/item/{kode}")
def ubah_item(kode: str, ubah: ItemUbah):
    for item in daftar_item:
        if item.get("kode") == kode:
            item.update(ubah.model_dump(exclude_unset=True))
            return item
    raise HTTPException(status_code=404, detail="Item tidak ditemukan")