# Define your Rally API key and base URL  
$apiKey =  "_eZjrvcShSPOu0lQ5q92OhTU5v7YRzkSMpXcIoDAU6Vw" 
$baseUrl = "https://rally1.rallydev.com/slm/webservice/v2.0"  
  
# Define the formatted ID of the defect you want to query  
$formattedId = "DE276025"  # Replace with your actual formatted defect ID  
  
# Construct the endpoint URL for querying the defect by formatted ID  
$endpoint = "$baseUrl/defect?query=(FormattedID%20=%20`"$formattedId`")&fetch=ObjectID"  
  
# Set up the headers  
$headers = @{  
    "zsessionid" = $apiKey  
    "Content-Type" = "application/json"  
}  
  
# Make the GET request to query the defect  
try {  
    $response = Invoke-RestMethod -Uri $endpoint -Headers $headers -Method Get  
    if ($response.QueryResult.Results.Count -eq 0) {  
        Write-Output "No defect found with the formatted ID $formattedId."  
    } else {  
        $objectId = $response.QueryResult.Results[0].ObjectID  
        Write-Output "Defect Object ID: $objectId"  
    }  
} catch {  
    Write-Error "Failed to query defect: $_"  
} 