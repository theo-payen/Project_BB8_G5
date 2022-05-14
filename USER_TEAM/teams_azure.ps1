# prérequis
function prerequis {
    Install-Module MicrosoftTeams
    Install-Module MSOnline
    
    # install Azure AD
    Install-Module AzureAD -Force
    Import-Module AzureAD
}

function connection {
    Connect-MicrosoftTeams 
    Connect-AzureAD
}
function main {
    prerequis
    connection
    Get-AzureADUser | ForEach-Object {
        $UserPrincipalName = $($_.UserPrincipalName)
        $Department = $($_.Department)
        
        if ($Department -ne $null){
            write-Host "$UserPrincipalName $Department"
            $team = Get-Team -DisplayName $Department 
            write-Host "Ajoute l'utilisateur $UserPrincipalName"
            Add-TeamUser -GroupId $team.GroupId -User $UserPrincipalName
        }
    }    
}

main


#   t.payen@g5esgi.onmicrosoft.com
#   Azerty@77