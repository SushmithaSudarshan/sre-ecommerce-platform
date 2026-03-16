from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

orders = [
    {"order_id": 101, "user_id": 1, "product_id": 1, "status": "placed"},
    {"order_id": 102, "user_id": 2, "product_id": 3, "status": "delivered"},
]

@app.route('/orders', methods=['GET'])
def get_orders():
    return jsonify(orders)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)