#!/bin/bash

echo "🧪 Testing Frontend Docker Configuration"
echo "========================================"

# Build the image
echo "📦 Building frontend Docker image..."
docker build -t frontend-test .

if [ $? -eq 0 ]; then
    echo "✅ Docker build successful!"
else
    echo "❌ Docker build failed!"
    exit 1
fi

# Test with backend URL
echo ""
echo "🚀 Starting container with backend URL..."
docker run -d --name frontend-test-container \
    -p 8080:80 \
    -e VITE_API_BASE_URL=http://135.220.213.50 \
    frontend-test

# Wait a moment for startup
sleep 5

echo ""
echo "🔍 Testing endpoints..."

# Test health endpoint
echo "Testing /health endpoint:"
curl -s http://localhost:8080/health || echo "❌ Health check failed"

echo ""
echo "Testing React app (should return HTML):"
curl -s -I http://localhost:8080/ | head -2

echo ""
echo "Testing API proxy (should proxy to backend):"
curl -s -I http://localhost:8080/api/health | head -2

echo ""
echo "🧹 Cleaning up..."
docker stop frontend-test-container
docker rm frontend-test-container

echo "✅ Test completed!"