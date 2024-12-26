# Search \ProductDocumentation for pdf files based on a keyword
[CmdletBinding()]
param (
    [Parameter()]
    [string[]]
    $keywords

    # [Parameter()]
    # [string]
    # $ignore
)

$output = $keywords | ForEach-Object {
    $keyword = $_
    Get-ChildItem -Path G:\ReleasedDocuments\ -Recurse -Filter "*.pdf" | Where-Object { $_.Name -like "*$keyword*" }    
}

if ($output) {
    Write-Output "I will print the following files:"
    $files = $output.FullName

    $fileNames = $output.Name
    $fileNames
    
    $confirmation = Read-Host "Confirm? (Y/N)"

    if ($confirmation -eq 'Y') {
        Write-Output "Printing..." 
        $files | ForEach-Object {
            Start-Process -FilePath $_ -Verb Print
        }
    }
    else {
        Write-Host "Exiting..."
        exit
    }
}
else {
    Write-Output "No PDF files found matching the keyword."
}

# If files are found, open them with confirmation
# if ($output) {
#     $output | ForEach-Object {
#         # Prompt for confirmation before starting the process
#         $confirmation = Read-Host "Do you want to open $($_.Name)? (Y/N)"
        
#         if ($confirmation -eq 'Y') {
#             Write-Output "Opening $($_.FullName)"
#             Start-Process -FilePath $_.FullName -Verb Print
#         } else {
#             Write-Output "Skipped $($_.FullName)"
#         }
#     }
# } else {
#     Write-Output "No PDF files found matching the keyword."
# }
