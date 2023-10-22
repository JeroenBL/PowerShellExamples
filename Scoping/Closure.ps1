# Closures are scriptblocks with a module/SessionState attached
$scriptBlockClosure = {
    function ProcessData {
        $myVariable = 'World'
        Write-Host "Hello $myVariable"
    }
    Export-ModuleMember -Function ProcessData
}.GetNewClosure()

. $scriptBlockClosure
ipmo $scriptBlockClosure.Module -Force
ProcessData
