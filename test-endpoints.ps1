# Test Application Endpoints
$AppGwIP = "135.220.213.50"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Testing Application Gateway Endpoints" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Test Frontend Root
Write-Host "1. Testing Frontend (/)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$AppGwIP/" -TimeoutSec 10 -UseBasicParsing
    Write-Host "   ✅ Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "   Content Length: $($response.Content.Length) bytes"
} catch {
    Write-Host "   ❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test Frontend Health
Write-Host "2. Testing Frontend Health (/health)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$AppGwIP/health" -TimeoutSec 10 -UseBasicParsing
    Write-Host "   ✅ Status: $($response.StatusCode) - $($response.Content)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test Backend API
Write-Host "3. Testing Backend API (/api/)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$AppGwIP/api/" -TimeoutSec 10 -UseBasicParsing
    Write-Host "   ✅ Status: $($response.StatusCode)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""

# Test Backend Health
Write-Host "4. Testing Backend Health (/actuator/health)..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://$AppGwIP/actuator/health" -TimeoutSec 10 -UseBasicParsing
    Write-Host "   ✅ Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "   Response: $($response.Content)" -ForegroundColor Green
} catch {
    Write-Host "   ❌ Error: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
