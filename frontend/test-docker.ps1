#!/usr/bin/env pwsh

Write-Host "🧪 Testing Frontend Docker Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Build the image
Write-Host "📦 Building frontend Docker image..." -ForegroundColor Yellow
docker build -t frontend-test .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Docker build successful!" -ForegroundColor Green
} else {
    Write-Host "❌ Docker build failed!" -ForegroundColor Red
    exit 1
}

# Test with backend URL
Write-Host ""
Write-Host "🚀 Starting container with backend URL..." -ForegroundColor Yellow
docker run -d --name frontend-test-container `
    -p 8080:80 `
    -e VITE_API_BASE_URL=http://135.220.213.50 `
    frontend-test

# Wait a moment for startup
Start-Sleep -Seconds 5

Write-Host ""
Write-Host "🔍 Testing endpoints..." -ForegroundColor Yellow

# Test health endpoint
Write-Host "Testing /health endpoint:" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri http://localhost:8080/health -Method GET -TimeoutSec 10
    Write-Host "✅ Health check: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ Health check failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "Testing React app (should return HTML):" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri http://localhost:8080/ -Method HEAD -TimeoutSec 10
    Write-Host "✅ React app: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ React app failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "Testing API proxy (should proxy to backend):" -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri http://localhost:8080/api/health -Method HEAD -TimeoutSec 10
    Write-Host "✅ API proxy: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "❌ API proxy failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🧹 Cleaning up..." -ForegroundColor Yellow
docker stop frontend-test-container
docker rm frontend-test-container

Write-Host "✅ Test completed!" -ForegroundColor Green