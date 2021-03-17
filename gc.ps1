<# There will be a little note to adapt the code #>

    <# DoNotModify #> 
                    function Get-All-Size
                        {
                        param([string]$pth)
                        "{0:n2}" -f ((gci -path $pth -recurse | measure-object -property length -sum).sum /1mb) + " Mb"
                        }

    <# Modify #>        $servers = @('192.168.0.7','OrAnotherServer','etc')
    <# Interactive #>   #$srv = Read-Host "`r`nExample : '1.1.1.1','2.2.2.2' `r`n[Servers] : "; $servers = -join('(',$srv,')')
    
    <# Comment #> # "\\$server\$folder" is "\\192.168.0.7\C$\folder"
    
    <# Modify #>        $folder = "C$\folder"
    <# Interactive #>   #$folder = Read-Host "`r`n[Target] : " 

    <# DoNotModify #>       foreach ($server in $servers)
                                {
    
                                    $target = "\\$server\$folder"

                                    <# Get target size #>
                                    $size = Get-All-Size $target -ErrorAction silentlycontinue
                                    Write-Host "`r`n                         > [$server] Target size is about $size." -foreground yellow
                                    Write-Host
                                    
                                    <# Del target #>
                                    $target = "\\$server\$folder\*"
                                    Remove-Item $target -Recurse -Force -ErrorAction silentlycontinue
                                    Write-Host "`r`n                         > [$server] Target has been deleted." -foreground red
                                    
                                    <# Get target info, left size #>
                                    $AreYouStillThere = Test-Path -Path $target
                                    if (!($AreYouStillThere)) {
                                            Write-Host "`r`n                         > [$server] Success !"  -foreground green
                                    
                                    } else { 
                                    
                                    $target = "\\$server\$folder"
                                    $size = Get-All-Size $target -ErrorAction silentlycontinue
                                    Write-Host "`r`n                         > [$server] $target is not empty, size is about $size."  -foreground yellow
                                    Write-Host "Keep in mind that it could be a false negative result because a process might be running.`r`n"
                                    
                                    }

                                } Write-Host
