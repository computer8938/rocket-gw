#!/usr/bin/env pwsh
param()

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$EnvFile = Join-Path (Split-Path $PSScriptRoot -Parent) "rocket-alpha" ".env"
$NetworkName = "rocket-alpha-net"

docker network inspect "$NetworkName" *> $null
if ($LASTEXITCODE -ne 0) {
    docker network create "$NetworkName" | Out-Null
}

Write-Host "[rocket-gw] Starting gateway..." -ForegroundColor Yellow
docker compose -p "rocket-gw" --env-file "$EnvFile" -f (Join-Path $PSScriptRoot "docker-compose.yml") up -d --build
if ($LASTEXITCODE -ne 0) { throw "Failed to start rocket-gw" }
Write-Host "[rocket-gw] Started - http://localhost:4760" -ForegroundColor Green
Write-Host "  Admin:    http://localhost:4760/admin/" -ForegroundColor White
Write-Host "  Customer: http://localhost:4760/" -ForegroundColor White
