from app import app

client = app.test_client()


def test_probe():
    response = client.get("/probe")
    assert response.status_code == 200
