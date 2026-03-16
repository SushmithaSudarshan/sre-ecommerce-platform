from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

users = [
    {"user_id": 1, "name": "Sushmitha", "email": "sushmitha@email.com"},
    {"user_id": 2, "name": "Priya", "email": "priya@email.com"},
]

@app.route('/users', methods=['GET'])
def get_users():
    return jsonify(users)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5003)