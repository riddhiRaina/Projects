# Define your Rally API key and base URL  
$apiKey =  "_eZjrvcShSPOu0lQ5q92OhTU5v7YRzkSMpXcIoDAU6Vw"  
$baseUrl = "https://rally1.rallydev.com/slm/webservice/v2.0"  
  
# Define query filters to narrow down the results  
# For example, only open defects  
$queryFilter = "(State = `"Open`")" # Adjust the query filter as needed  
  
# Construct the endpoint URL for querying defects with filters  
$endpoint = "$baseUrl/defect?query=$queryFilter&fetch=FormattedID,Name,State"  
  
# Set up the headers  
$headers = @{  
    "zsessionid" = $apiKey  
    "Content-Type" = "application/json"  
}  
  
# Function to query defects with pagination  
function Get-AllDefects {  
    param (  
        [string]$uri,  
        [hashtable]$headers  
    )  
  
    $defects = @()  
    $startIndex = 1  
    $pageSize = 100 # Adjust the page size as needed  
  
    do {  
        # Construct the paginated endpoint URL  
        $paginatedEndpoint = "$uri&start=$startIndex&pagesize=$pageSize"  
  
        try {  
            $response = Invoke-RestMethod -Uri $paginatedEndpoint -Headers $headers -Method Get  
            $defects += $response.QueryResult.Results  
            $startIndex += $pageSize  
        } catch {  
            Write-Error "Failed to query defects: $_"  
            break  
        }  
    } while ($response.QueryResult.TotalResultCount -gt $defects.Count)  
  
    return $defects  
}  
  
# Query all defects with the specified filters  
$allDefects = Get-AllDefects -uri $endpoint -headers $headers  
  
# Output the defects  
if ($allDefects.Count -eq 0) {  
    Write-Output "No defects found."  
} else {  
    Write-Output "Found $($allDefects.Count) defects:"  
    foreach ($defect in $allDefects) {  
        Write-Output "FormattedID: $($defect.FormattedID), Name: $($defect.Name), State: $($defect.State)"  
    }  
}  
