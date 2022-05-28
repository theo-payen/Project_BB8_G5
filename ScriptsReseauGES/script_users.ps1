# *** Scripts création utilisateurs ***

# Import du fichier CSV
$CSVpath = "C:\ScriptsReseauGES\users_ges.csv"
$CSVdata = Import-CSV -Path $CSVpath -Delimiter ";" -Encoding Default

# Boucle Foreach pour parcourir le fichier CSV
Foreach($User in $CSVdata){

    $UserFirstname = $User.Firstname
    $UserLastname = $User.Lastname
    $UserDisplay = $UserLastname + ", " + $UserFirstname 
    $UserLogon = $UserFirstname.ToLower() + "." + $UserLastname.ToLower() 
    $UserPassword = $User.Password
    $UPN = "$UserLogon@reseau-ges.local"
    $UserEmail = "$UserLogon@g5esgi.onmicrosoft.com"
    $UserTitle = $User.Title
    $UserDept = $User.Department
    $UserCpny = $User.Company



    # Vérification de la présence des utilisateurs dans l'annuaire
    if (Get-ADUser -Filter {SamAccountName -eq $UserLogon})
    {
    Write-Warning "Attention, l'utilisateur $UserLogon existe déjà dans l'annuaire !"
    }
    else
    {
    New-ADUser -Name "$UserFirstname $UserLastname" `
        -GivenName $UserFirstname `
        -Surname $UserLastname `
        -DisplayName $UserDisplay `
        -SamAccountName $UserLogon `
        -UserPrincipalName $UPN `
        -EmailAddress $UserEmail `
        -Title $UserTitle `
        -Department $UserDept `
        -Company $UserCpny `
        -Path "OU=Users,OU=France,OU=ReseauGES,DC=reseau-ges,DC=local" `
        -AccountPassword(ConvertTo-SecureString $UserPassword -AsPlainText -Force) `
        -ChangePasswordAtLogon $false `
        -Enabled $true

    Write-Output "Création de l'utilisateur : $UserLogon !"
    }

}