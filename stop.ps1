#!/usr/bin/env pwsh
param()

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$EnvFile = Join-Path (Split-Path $PSScriptRoot -Parent) "rocket-alpha" ".env"

Write-Host "[rocket-gw] Stopping gateway..." -ForegroundColor Yellow
docker compose -p "rocket-gw" --env-file "$EnvFile" -f (Join-Path $PSScriptRoot "docker-compose.yml") down --remove-orphans
if ($LASTEXITCODE -ne 0) { throw "Failed to stop rocket-gw" }
Write-Host "[rocket-gw] Stopped." -ForegroundColor Green
