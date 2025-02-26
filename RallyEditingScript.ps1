param (  
    [string]$apiKey,  
    [string]$objectId,  
    [string]$prLink  
)  
  
# Check if all required parameters are provided  
if (-not $apiKey -or -not $objectId -or -not $prLink) {  
    Write-Error "Please provide all required parameters: apiKey, objectId, and prLink."  
    exit 1  
}  
  
# Define the base URL for Rally's API  
$baseUrl = "https://rally1.rallydev.com/"  
  
# Construct the endpoint URL for the defect  
$endpoint = "$baseUrl/defect/$objectId"  
  
# Set up the headers  
$headers = @{  
    "zsessionid" = $apiKey  
    "Content-Type" = "application/json"  
}  
  
# Create the JSON payload to update the notes section  
$body = @{  
    "Defect" = @{  
        "Notes" = $prLink  
    }  
} | ConvertTo-Json  
  
# Make the PUT request to update the defect  
try {  
    $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Method Put -Body $body  
    Write-Output "Defect updated successfully."  
    Write-Output $response  
} catch {  
    Write-Error "Failed to update defect: $_"  
}  
Remove-Variable apiKey;
Remove-Variable objectId;
Remove-Variable prLink;