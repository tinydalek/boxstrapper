<#
    Sets up quite a lot of what Tinydalek needs on a new laptop. There's probably a lot more, so this will grow over time.
#>

Set-ExecutionPolicy unrestricted

# chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# reload so we seee choco
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

<# 
	Need to install from Microsoft
		Office 365
		VisualStudio2017Enterprise
		Visual Paradigm
		Microsoft SQL Server
		Adobe creative cloud
		Adobe Bridge
		Cura
		Wamp
		

#>

@(
    "mysql",
	"php",
	"composer",
	"git",
    "poshgit",
    "googlechrome",
    "visualstudiocode",
    "NotepadPlusPlus",
    "pscx",
    "carbon",
    "awstools.powershell",
    "nodejs",
    "sysinternals",
    "haroopad",
    "dashlane",
    "zoom",
    "slack",
    "dotnetcore",
    "awscli",
    "vagrant",
	"nuget.commandline",
	"gimp"
) | % { cinst $_ -y }

# psreadline
Install-Package psreadline -verbose -force -skippublishercheck # why is this not properly signed?

# azureRM
Install-Module AzureRM -Force -verbose


Install-Module ACMESharp -Force -verbose 

refreshenv

# install the laraval bits

composer global require "laravel/installer"

# repo path. Why here? habit, pretty much
$repopath = "$home\source\repos"
if(-not (Test-Path $repopath ))
{
    New-Item $repopath -force -type Directory
    $o = new-object -com shell.application  
    $o.Namespace($repopath).Self.InvokeVerb("pintohome")
}

# ps help (as a job because YAWN)
Start-Job { Update-Help } # in the background


# code --list-extensions will give you a list
# vs code extensions
@(
	"felixfbecker.php-intellisense",
    "aws-scripting-guy.cform",
    "eamodio.gitlens",
    "Ionide.Ionide-fsharp",
    "ms-vscode.PowerShell",
    "ms-python.python",
    "redhat.vscode-yaml"
) | % { code --install-extension $_ }
