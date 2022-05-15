# prérequis
function prerequis {
    # installe les modules requis pour la bon fonctionnement du script
    Install-Module MicrosoftTeams -Force
    Install-Module MSOnline -Force
    
    # install Azure AD
    Install-Module AzureAD -Force
    Import-Module AzureAD -Force
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
        # récupère le departement de l'utilisateur
        $Department = $($_.Department)
        # récupère l'equipe teams avec le meme nom de departement
        if (Get-team -DisplayName $Department -eq $null){
            write-host "crée l'equipe $Department"
            new-Team -DisplayName $Department
        }
    }   
}

main