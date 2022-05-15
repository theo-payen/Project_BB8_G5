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
    param (
        $Department,
        $url
    )
    #prerequis
    #connection
    Get-SPOSite | Out-GridView
    Get-AzureADUser | ForEach-Object {
        $UserPrincipalName = $($_.UserPrincipalName)
        $Department_USER = $($_.Department)
        
        if ($Department_USER -eq $Department){
            write-Host "$UserPrincipalName $Department_USER"
            Add-SPOUser -Site $url -LoginName $UserPrincipalName -Group $Department_USER

            write-Host "Ajoute l'utilisateur $UserPrincipalName"

        }
    }    
}

main -Department "IT" -url "https://g5esgi.sharepoint.com/sites/IT"