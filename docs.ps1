# Search \ProductDocumentation for pdf files based on a keyword
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $keyword

    # [Parameter()]
    # [string]
    # $ignore
)

$output = Get-ChildItem -Path G:\ReleasedDocuments\ -Recurse -Filter "*.pdf" | Where-Object { $_.Name -like "*$keyword*" }

# If files are found, open them with confirmation
if ($output) {
    $output | ForEach-Object {
        # Prompt for confirmation before starting the process
        $confirmation = Read-Host "Do you want to open $($_.Name)? (Y/N)"
        
        if ($confirmation -eq 'Y') {
            Write-Output "Opening $($_.FullName)"
            Start-Process $_.FullName
        } else {
            Write-Output "Skipped $($_.FullName)"
        }
    }
} else {
    Write-Output "No PDF files found matching the keyword."
}
