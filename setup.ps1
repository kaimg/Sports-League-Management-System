# Sports League Management System - Windows setup script
param(
    [switch]$Fresh
)

$ErrorActionPreference = "Stop"
$ProjectRoot = $PSScriptRoot
Set-Location $ProjectRoot

# Docker writes informational warnings to stderr; PowerShell must not treat them as fatal errors.
function Invoke-Native {
    param(
        [string]$FilePath,
        [string[]]$ArgumentList,
        [switch]$Quiet
    )

    $previousErrorAction = $ErrorActionPreference
    $ErrorActionPreference = "Continue"

    try {
        if ($Quiet) {
            & $FilePath @ArgumentList 2>&1 | Out-Null
        } else {
            & $FilePath @ArgumentList 2>&1 | ForEach-Object {
                if ($_ -is [System.Management.Automation.ErrorRecord]) {
                    Write-Host $_.ToString()
                } else {
                    Write-Host $_
                }
            }
        }
        return $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $previousErrorAction
    }
}

function Test-DockerRunning {
    return (Invoke-Native -FilePath "docker" -ArgumentList @("info") -Quiet) -eq 0
}

function Invoke-Compose {
    param([string[]]$ComposeArgs)

    $exitCode = Invoke-Native -FilePath "docker" -ArgumentList (@("compose") + $ComposeArgs)
    if ($exitCode -ne 0) {
        $exitCode = Invoke-Native -FilePath "docker-compose" -ArgumentList $ComposeArgs
    }
    if ($exitCode -ne 0) {
        throw "Docker Compose failed (exit code $exitCode)."
    }
}

function Wait-DatabaseReady {
    Write-Host "Waiting for PostgreSQL..."
    for ($attempt = 0; $attempt -lt 60; $attempt++) {
        $exitCode = Invoke-Native -FilePath "docker" -ArgumentList @(
            "compose", "exec", "-T", "db",
            "sh", "-c", 'pg_isready -U "$POSTGRES_USER" -d "$POSTGRES_DB"'
        ) -Quiet

        if ($exitCode -eq 0) {
            return
        }

        Start-Sleep -Seconds 2
    }

    throw "PostgreSQL did not become ready in time. Check logs with: docker compose logs db"
}

function Initialize-Database {
    Write-Host "Initializing database schema..."
    $exitCode = Invoke-Native -FilePath "docker" -ArgumentList @(
        "compose", "run", "--rm", "web", "python", "scripts/wait_for_db.py"
    )
    if ($exitCode -ne 0) {
        throw "Could not connect to the database from the web container."
    }

    $exitCode = Invoke-Native -FilePath "docker" -ArgumentList @(
        "compose", "run", "--rm", "web", "python", "scripts/ensure_db.py"
    )
    if ($exitCode -ne 0) {
        throw "Database initialization failed."
    }
}

if (-not (Test-Path ".env")) {
    Write-Host "Creating .env from .env.example..."
    Copy-Item ".env.example" ".env"
    Write-Host ""
    Write-Host "Edit .env and set your values (especially FOOTBALL_DATA_API_KEY), then run setup.ps1 again."
    exit 1
}

if (-not (Test-DockerRunning)) {
    Write-Host "Docker is not running. Start Docker Desktop and try again."
    exit 1
}

if ($Fresh) {
    Write-Host "Removing existing containers and database volume..."
    Invoke-Compose @("down", "-v")
}

Write-Host "Building and starting containers..."
Invoke-Compose @("up", "--build", "-d")

Wait-DatabaseReady

try {
    Initialize-Database
} catch {
    Write-Host ""
    Write-Host $_.Exception.Message
    Write-Host ""
    Write-Host "If the database was partially created, reset and retry:"
    Write-Host "  .\setup.ps1 -Fresh"
    exit 1
}

Write-Host "Starting web application..."
Invoke-Compose @("up", "-d", "web")

Write-Host ""
Write-Host "Setup complete. Application: http://localhost:5000"
Write-Host "View logs: docker compose logs -f web"
