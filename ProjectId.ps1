# Define your Rally API key and base URL  
$apiKey = Write-Output "Enter Api Key"  
$baseUrl = "https://rally1.rallydev.com/slm/webservice/v2.0"  
  
# Construct the endpoint URL for querying all projects  
$projectEndpoint = "$baseUrl/project?fetch=ObjectID,Name,Owner,State"  
  
# Set up the headers  
$headers = @{  
    "zsessionid" = $apiKey  
    "Content-Type" = "application/json"  
}  
  
# Function to query all projects with pagination  
function Get-AllProjects {  
    param (  
        [string]$uri,  
        [hashtable]$headers  
    )  
  
    $projects = @()  
    $startIndex = 1  
    $pageSize = 100 # Adjust the page size as needed  
  
    do {  
        # Construct the paginated endpoint URL  
        $paginatedEndpoint = "$uri&start=$startIndex&pagesize=$pageSize"  
  
        try {  
            $response = Invoke-RestMethod -Uri $paginatedEndpoint -Headers $headers -Method Get  
            $projects += $response.QueryResult.Results  
            $startIndex += $pageSize  
        } catch {  
            Write-Error "Failed to query projects: $_"  
            break  
        }  
    } while ($response.QueryResult.TotalResultCount -gt $projects.Count)  
  
    return $projects  
}  
  
# Query all projects  
$allProjects = Get-AllProjects -uri $projectEndpoint -headers $headers  
  
# Output the projects  
if ($allProjects.Count -eq 0) {  
    Write-Output "No projects found."  
} else {  
    Write-Output "Found $($allProjects.Count) projects:"  
    foreach ($project in $allProjects) {  
        Write-Output "Project Name: $($project.Name), Project ID: $($project.ObjectID), Owner: $($project.Owner._refObjectName), State: $($project.State)"  
    }  
}  
