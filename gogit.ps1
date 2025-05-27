# gogit

function Show-Help {
    Write-Host "`nGOGIT - Open Git remote URLs in your browser." -ForegroundColor Cyan
    Write-Host "`nUSAGE:" -ForegroundColor Green
    Write-Host "  gogit                  " -NoNewline; Write-Host "# Opens 'origin' remote (default)" -ForegroundColor Yellow
    Write-Host "  gogit <remote-name>    " -NoNewline; Write-Host "# Opens specified remote" -ForegroundColor Yellow
    Write-Host "  gogit show             " -NoNewline; Write-Host "# Lists all available remotes" -ForegroundColor Yellow
    Write-Host "  gogit --help           " -NoNewline; Write-Host "# Displays this help message" -ForegroundColor Yellow

    Write-Host "`nEXAMPLES:" -ForegroundColor Green
    Write-Host "  gogit"
    Write-Host "  gogit upstream"
    Write-Host "  gogit dev"
    Write-Host "  gogit show"
    Write-Host "  gogit --help"

    Write-Host "`nNOTES:" -ForegroundColor Green
    Write-Host "  - gogit must be run inside a Git repository"
    Write-Host "  - gogit automatically converts SSH remote URLs (git@...) into HTTPS format"
    Write-Host ""
}

$cmd = if ($args.Length -gt 0) { $args[0] } else { "origin" }

if ($cmd -in @("--help", "-h", "/?")) {
    Show-Help
    exit 0
}

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($insideRepo -ne "true") {
    Write-Host "Not inside a Git repository." -ForegroundColor Red
    exit 1
}

$allRemotes = git remote
if (-not $allRemotes) {
    Write-Host "No remotes found in this repository." -ForegroundColor Red
    exit 1
}

if ($cmd -eq "show") {
    Write-Host "Available remotes:" -ForegroundColor Green
    foreach ($remote in $allRemotes) {
        $url = git remote get-url $remote
        Write-Host " - $remote`t($url)" -ForegroundColor Yellow
    }
    exit 0
}

if (-not ($allRemotes -contains $cmd)) {
    Write-Host "Remote '$cmd' not found." -ForegroundColor Red
    Write-Host "Available remotes: $($allRemotes -join ', ')" -ForegroundColor Yellow
    exit 1
}

$remoteUrl = git remote get-url $cmd 2>$null
if (-not $remoteUrl) {
    Write-Host "No URL found for remote '$cmd'." -ForegroundColor Red
    exit 1
}

if ($remoteUrl -match "^git@([^:]+):(.+)\.git$") {
    $domain = $matches[1]
    $path = $matches[2]
    $url = "https://$domain/$path"
} else {
    $url = $remoteUrl -replace '\.git$', ''
}

Write-Host "Opening: $url" -ForegroundColor Cyan
Start-Process $url
