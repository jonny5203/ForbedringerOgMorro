$folder = "C:\path\to\directory"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folder
$watcher.Filter = "*.*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $false

$action = {
    $path = $Event.SourceEventArgs.FullPath
    $name = $Event.SourceEventArgs.Name
    $changeType = $Event.SourceEventArgs.ChangeType
    if ($changeType -eq "Created" -or $changeType -eq "Renamed") {
        Write-Host "The file '$name' was $changeType at '$path'"
    }
}

while ($true) {
    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Created -bor [System.IO.WatcherChangeTypes]::Renamed)
    if ($result.TimedOut -eq $false) {
        & $action
    }
}