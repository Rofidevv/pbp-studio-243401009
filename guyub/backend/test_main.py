from fastapi.testclient import TestClient

from main import app

klien = TestClient(app)


def test_get_mengembalikan_daftar():
    r = klien.get("/item")
    assert r.status_code == 200
    assert r.json()[0]["kode"] == "GYB-001"


def test_post_membuat_item_baru():
    r = klien.post("/item", json={"judul": "Tombol check-in", "poin": 3})
    assert r.status_code == 201
    assert r.json()["kode"] == "GYB-003"
    assert len(klien.get("/item").json()) == 3


def test_post_judul_kosong_ditolak():
    assert klien.post("/item", json={"judul": "", "poin": 3}).status_code == 422
