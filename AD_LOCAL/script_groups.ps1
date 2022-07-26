# *** Script création groupes ***

# Import du fichier CSV

$CSVpath = "C:\ScriptsReseauGES\groups_ges.csv"
$CSVdata = Import-CSV -Path $CSVpath -Delimiter ";" -Encoding Default

# Boucle Foreach pour parcourir le fichier CSV

Foreach($Group in $CSVdata){
    $GroupName = $Group.Name
    $GroupPath = $Group.Path
    $GroupScope = $Group.Scope
    $GroupType = $Group.Type

    New-ADGroup -Name $GroupName `
        -Path $GroupPath `
        -GroupScope $GroupScope `
        -GroupCategory $GroupType `


    Write-Output "Création du groupe : $GroupName !"
}