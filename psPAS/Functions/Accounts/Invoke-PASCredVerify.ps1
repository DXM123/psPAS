function Invoke-PASCredVerify {
	<#
.SYNOPSIS
Marks account for immediate verification by the CPM.

.DESCRIPTION
Flags a managed account credentials for an immediate CPM password verification.
The "Initiate CPM password management operations" permission is required.

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Invoke-PASCredVerify -AccountID 19_1

Will mark account with AccountID of 19_1 for Immediate CPM Verification

.INPUTS
SessionToken, AccountID, WebSession & BaseURI can be piped by  property name

.OUTPUTS
None

.NOTES
Can be used in versions from v9.10.

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[hashtable]$SessionToken,

		[parameter(
			ValueFromPipelinebyPropertyName = $true
		)]
		[Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PVWAAppName = "PasswordVault"
	)

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/API/Accounts/$AccountID/Verify"

		if($PSCmdlet.ShouldProcess($AccountID, "Mark for Immediate Verification")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Headers $SessionToken -WebSession $WebSession

		}

	}#process

	END {}#end

}