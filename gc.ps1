<# There will be a little note to adapt the code #>

    <# DoNotModify #> 
                    function Get-All-Size
                        {
                        param([string]$pth)
                        "{0:n2}" -f ((gci -path $pth -recurse | measure-object -property length -sum).sum /1mb) + " Mb"
                        }

    <# Modify #>    $servers = @('192.168.0.7','OrAnotherServer','etc')
    
    <# Comment #> # $target = "\\$server\$folder"   
    
    <# Modify #>    $folder = "C$\folder"

    <# DoNotModify #>       foreach ($server in $servers)
                                {
    
                                    $target = "\\$server\$folder"

                                    #
                                    $size = Get-All-Size $target -ErrorAction silentlycontinue
                                    Write-Host "`r`n                         > [$server] Target size is about $size." -foreground yellow
                                    Write-Host
                                    
                                    #
                                    $target = "\\$server\$folder\*"
                                    Remove-Item $target -Recurse -Force -ErrorAction silentlycontinue
                                    Write-Host "`r`n                         > [$server] Target has been deleted." -foreground red
                                    
                                    # 
                                    $AreYouStillThere = Test-Path -Path $target
                                    if (!($AreYouStillThere)) {
                                            Write-Host "`r`n                         > [$server] Success !"  -foreground green
                                    
                                    } else { 
                                    
                                    Write-Host "`r`n                         > [$server] $target is not empty !"  -foreground yellow
                                    Write-Host "Keep in mind that it could be a false negative result, because a process might be using a file.`r`n"
                                    
                                    }

                                } Write-Host
