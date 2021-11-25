$result = Invoke-WebRequest -Uri $package.repo_uri -UseBasicParsing

$installerUrl32 = "https://www.driverscloud.com$(($result.Links | Where-Object { $_.href -match "DriversCloud_(\d{2,}.*)\.exe$" }).href | Sort-Object | Select-Object -Last 1)"
$version = $Matches[1] -replace '_', '.'

$installerUrl64 = "https://www.driverscloud.com$(($result.Links | Where-Object { $_.href -match "DriversCloudx64_\d{2,}.*\.exe$" }).href | Sort-Object | Select-Object -Last 1)"

if ($version -gt $package.last_checked_tag)
{
    $update_found = $true
    $jsonTag = $version
    $urls.Add($installerUrl32) | Out-Null
    $urls.Add($installerUrl64) | Out-Null
}
else
{
    $update_found = $false
}
