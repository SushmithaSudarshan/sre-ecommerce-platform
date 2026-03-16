from flask import Flask, jsonify
from prometheus_flask_exporter import PrometheusMetrics

app = Flask(__name__)
metrics = PrometheusMetrics(app)

products = [
    {"id": 1, "name": "Laptop", "price": 50000, "stock": 10},
    {"id": 2, "name": "Phone", "price": 20000, "stock": 25},
    {"id": 3, "name": "Headphones", "price": 5000, "stock": 50},
]

@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)