#.\Teams_team.ps1 -CSV "./name.csv" -Name "name"
param (
    $CSV,
    $Name
)
Connect-MicrosoftTeams
$p = New-Team -DisplayName $Name -Description $Name


Import-Csv $CSV | ForEach-Object {
    $User = $($_.User)
    write-Host $User
    Add-TeamUser -GroupId $p.GroupId -User $User
}
pause