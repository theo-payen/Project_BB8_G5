# prérequis
function prerequis {
    # installe les modules requis pour la bon fonctionnement du script
    Install-Module MicrosoftTeams
    Install-Module MSOnline
    
    # install Azure AD
    Install-Module AzureAD -Force
    Import-Module AzureAD
}

function connection {
    # permet de se connecter à microsoft
    Connect-MicrosoftTeams 
    Connect-AzureAD
}
function main {
    # appel les fonction
    prerequis
    connection
    # récupère toute la liste des utilisateurs dans Azure AD dans un for
    Get-AzureADUser | ForEach-Object {
        # récupère le nom de l'utilisateur
        $UserPrincipalName = $($_.UserPrincipalName)
        # récupère le departement de l'utilisateur
        $Department = $($_.Department)
        # verrifie si le departement est non null
        if ($Department -ne $null){
            write-Host "$UserPrincipalName $Department"
            # récupère l'equipe teams avec le meme nom de departement
            $team = Get-Team -DisplayName $Department 
            write-Host "Ajoute l'utilisateur $UserPrincipalName"
            # puis ajoute l'utilisateur dans l'equipe
            Add-TeamUser -GroupId $team.GroupId -User $UserPrincipalName
        }
    }    
}

main


#   t.payen@g5esgi.onmicrosoft.com
#   Azerty@77
