from flask import Flask

app: Flask = Flask(__name__)


@app.route("/probe")
def probe():
    return {}
