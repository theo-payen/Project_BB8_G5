# prérequis
function prerequis {
    
    Install-Module -Name Microsoft.Online.SharePoint.PowerShell
    
    # install Azure AD
    Install-Module AzureAD -Force
    Import-Module AzureAD
}

function connection {
    Connect-SPOService –url https://g5esgi.sharepoint.com
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
            Get-SPOSite
            write-Host "Ajoute l'utilisateur $UserPrincipalName"

        }
    }    
}

main


#   t.payen@g5esgi.onmicrosoft.com
#   Azerty@77