# prérequis
function prerequis {
    #https://www.microsoft.com/fr-FR/download/details.aspx?id=35588
    Import-Module Microsoft.Online.Sharepoint.PowerShell
    # install Azure AD
    Install-Module AzureAD -Force
    Import-Module AzureAD
}

function connection {
    Connect-SPOService -url 'https://g5esgi-admin.sharepoint.com'
    Connect-AzureAD
}
function main {
    #prerequis
    #connection
    Get-SPOSite | Out-GridView
    Get-AzureADUser | ForEach-Object {
        $UserPrincipalName = $($_.UserPrincipalName)
        $Department = $($_.Department)
        
        if ($Department -ne $null){
            write-Host "$UserPrincipalName $Department"
            Add-SPOUser -Site 'https://g5esgi.sharepoint.com' -LoginName $UserPrincipalName -Group $Department
            write-Host "Ajoute l'utilisateur $UserPrincipalName"

        }
    }    
}

main


#   t.payen@g5esgi.onmicrosoft.com
#   Azerty@77