if ($args.Count -eq 0) {
    $dir = Read-Host "Enter directory path: (cur for current)"
    if($dir -match "cur") {
        $dir = (Get-Location).Path
    }
} else {
    $types = $args[1..($args.Count - 1)]
    $help = $types -contains "\?"
    if($help) {
        Write-Host "This is help mode"
        Write-Host "Press Enter to continue:"
        Read-Host
        Exit 0
    }
    $dir = $args[0]
}

    $ifExist = Test-Path $dir
        if(-not $ifExist) {
            Write-Host ""
            Write-Host "Error 1 (dir doesn't exist)"
            Write-Host "Press Enter to continue:"
            Read-Host
            Exit 1
        }

Get-ChildItem -Path $dir -Recurse | ForEach-Object {
    if ($_.PSIsContainer) {
        $count = 0
        $hidden_count = 0
        $readonly_count = 0
        $archived_count = 0
        
        Get-ChildItem $_.FullName -File -Recurse | ForEach-Object {
            $count++
            if ($_.Attributes -match "Hidden") {
                $hidden_count++
            }
            if ($_.Attributes -match "ReadOnly") {
                $readonly_count++
            }
            if ($_.Attributes -match "Archive") {
                $archived_count++
            }
        }
        
        Write-Host $_.Name
        Write-Host "Total files: $count"
        Write-Host "Hidden files: $hidden_count"
        Write-Host "Read-only files: $readonly_count"
        Write-Host "Archived files: $archived_count"
        Write-Host ""
    }
}

$count = 0
$hidden_count = 0
$readonly_count = 0
$archived_count = 0

Get-ChildItem -Path $dir -File -Recurse | ForEach-Object {
    $count++
    if ($_.Attributes -match "Hidden") {
        $hidden_count++
    }
    if ($_.Attributes -match "ReadOnly") {
        $readonly_count++
    }
    if ($_.Attributes -match "Archive") {
        $archived_count++
    }
}

Write-Host "Total files: $count"
Write-Host "Hidden files: $hidden_count"
Write-Host "Read-only files: $readonly_count"
Write-Host "Archived files: $archived_count"

Write-Host "Press Enter to continue:"
Read-Host
Exit 0