Install-Module -Name ExchangeOnlineManagement
Connect-ExchangeOnline

foreach($user in Get-Mailbox -recipentTypeDetails UserMailbox){
    $cal = $user.alias+":\Calendar"
    Set-MailboxFolderPermission -Identity $cal -User Default -AccessRights Reviewer
}