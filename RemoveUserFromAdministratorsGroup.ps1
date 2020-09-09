#requires -Version 2.0
<# 
    .SYNOPSIS   
        remove account to local administrator group

    .DESCRIPTION 
        remove account to local administrator group on remote machine

    .NOTES
            Author: Amit Dodake

    .PARAMETER Servers
        Required - Server name(s) . 

    .EXAMPLE   
        .\RemoveUserFromAdministratorsGroup.ps1 -UserName "myaccount" -Servers "server1","server2"
	
#>
#region Parameters
[CmdletBinding()] # Advanced functions can accept common parameters (-Debug, -Verbose, etc.)
param(
    [string[]]$Servers <#= ("localhost") #>,
    [string]$UserName = 'myaccount'
)
#endregion

#region Script Block
Process
{
    foreach ($ComputerName in $Servers)
    {
	    #Default set of domain
	    $DomainName = 'domain'
      
        try
		{
			$AdminGroup = [ADSI]"WinNT://$ComputerName/Administrators,group"
			$User = [ADSI]"WinNT://$DomainName/$UserName,user"
			$AdminGroup.Remove($User.Path)
			 write-Host "Successfully Removed - $UserName from $ComputerName "
		}
		catch
		{
			write-Host -backgroundcolor Red -ForeGroundColor Yellow "Error occurred while running the admin script " 
		}
    }
}
#endregion
