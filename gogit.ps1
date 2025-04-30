param (
    [string]$open = "origin"
)

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

if (-not ($allRemotes -contains $open)) {
    Write-Host "Remote '$open' not found." -ForegroundColor Red
    Write-Host "Available remotes: $($allRemotes -join ', ')" -ForegroundColor Yellow
    exit 1
}

$remoteUrl = git remote get-url $open 2>$null
if (-not $remoteUrl) {
    Write-Host "No URL found for remote '$open'." -ForegroundColor Red
    exit 1
}

if ($remoteUrl -match "^git@([^:]+):(.+)\.git$") {
    $domain = $matches[1]
    $path = $matches[2]
    $url = "https://$domain/$path"
} else {
    $url = $remoteUrl -replace '\.git$', ''
}

$url = $url -replace '\.git$', ''
Write-Host "Opening: $url" -ForegroundColor Cyan
Start-Process $url
