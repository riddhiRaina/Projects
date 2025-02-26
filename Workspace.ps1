# Define your Rally API key and base URL  
$apiKey = Write-Output "Enter Api Key"  
$baseUrl = "https://rally1.rallydev.com/slm/webservice/v2.0"  
  
# Construct the endpoint URL for querying all workspaces  
$workspaceEndpoint = "$baseUrl/subscription?fetch=Workspaces"  
  
# Set up the headers  
$headers = @{  
    "zsessionid" = $apiKey  
    "Content-Type" = "application/json"  
}  
  
# Make the GET request to query the workspaces  
try {  
    $workspaceResponse = Invoke-RestMethod -Uri $workspaceEndpoint -Headers $headers -Method Get  
    $workspaces = $workspaceResponse.Subscription.Workspaces  
    Write-Output "Found $($workspaces.Count) workspaces:"  
    foreach ($workspace in $workspaces) {  
        $workspaceDetails = Invoke-RestMethod -Uri $workspace._ref -Headers $headers -Method Get  
        Write-Output "Workspace Name: $($workspaceDetails.Workspace.Name), Workspace ID: $($workspaceDetails.Workspace.ObjectID)"  
    }  
} catch {  
    Write-Error "Failed to query workspaces: $_"  
}  
