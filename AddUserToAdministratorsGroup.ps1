#requires -Version 2.0
<# 
    .SYNOPSIS   
        add account to local administrator group

    .DESCRIPTION 
        add account to local administrator group on remote machine

    .NOTES
            Author: Amit Dodake

    .PARAMETER Servers
        Required - Server name(s) . 

    .EXAMPLE   
        .\AddUserToAdministratorsGroup.ps1 -UserName "myaccount" -Servers "Server1", "Server2"
	
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

#Default Domain Name    
$DomainName = 'Domain'

    foreach ($ComputerName in $Servers)
    {
      try
      {
        $AdminGroup = [ADSI]"WinNT://$ComputerName/Administrators,group"
        $User = [ADSI]"WinNT://$DomainName/$UserName,user"
        $AdminGroup.Add($User.Path)
        write-Host "Successfully Added - $UserName to $ComputerName "

		  }
		  catch
		  {
			  write-Host -backgroundcolor Red -ForeGroundColor Yellow "Error occurred while running the admin script "
        write-Host $_.Exception.Message 
		  }
    }
}
#endregion
