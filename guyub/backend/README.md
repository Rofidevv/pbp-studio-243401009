# Backend Guyub

Studio Pertemuan 7: dua endpoint, `GET /item` dan `POST /item`. Data disimpan di list, jadi kembali ke dua item awal setiap server dimatikan.

## Menjalankan

```bash
cd guyub/backend
python3 -m venv .venv                # Windows: python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
uvicorn main:app --reload
```

Buka `http://127.0.0.1:8000/docs`, lalu coba kedua endpoint dengan tombol **Try it out**.

## Tes

```bash
pytest -q
```

| No | Endpoint | Hasil |
|---|---|---|
| 1 | `GET /item` | Daftar item, kode 200 |
| 3 | `POST /item` | Item baru dengan `id`, `kode`, `dibuat_pada`, kode 201; 422 bila `judul` kosong atau `poin` bukan angka |
