# Run flutter analyze command and capture the output
$output = flutter analyze

# Print the output
Write-Output $output

# Check if the output contains the word "error"
if ($output -match "error") {
    Write-Host "Error(s) found in flutter analyze output"
    exit 1 # Exit with error code
} else {
    Write-Host "No errors found in flutter analyze output"
    exit 0 # Exit with success code
}