# StrategyPattern.
# Defines a family of algorithms encapsulating each one and making each interchangable.
# Changes behavior of a function without modifying or extending it.

function FlyingHighBehavior {
    Write-Host 'Flying high'
}

function FlyingNormalBehavior {
    Write-Host 'Flying normal'
}

function QuackingLoudBehavior {
    Write-Host 'Quacking loud'
}

function SqueakBehavior {
    Write-Host 'Squeak'
}

function New-Duck {
    param (
        [Parameter(Mandatory)]
        [string]
        $Type,

        [Parameter()]
        [scriptblock]
        $FlyBehavior,

        [Parameter()]
        [scriptblock]
        $QuackBehavior,

        [Parameter()]
        [switch]
        $Fly,

        [Parameter()]
        [switch]
        $Quack
    )
    Write-Host $Type
    if ($Fly){  
        Write-Host "$($FlyBehavior.Invoke())"
    }

    if ($Quack) {
        Write-Host "$($QuackBehavior.Invoke())" 
    }
}

splatNewWildDuckParams = @{
    Type = 'Wild Duck' 
    FlyBehavior = ${function:FlyingNormalBehavior}
    QuackBehavior = ${function:QuackingLoudBehavior}
}
New-Duck @splatNewWildDuckParams -Fly -Quack

$splatNewMountainDuckParams = @{
    Type = 'Mountain Duck' 
    FlyBehavior = ${function:FlyingNormalBehavior}
    QuackBehavior = ${function:QuackingLoudBehavior}
}
New-Duck @splatNewMountainDuckParams -Fly -Quack

$splatNewRubberDuckParams = @{
    Type = 'Rubber Duck' 
    QuackBehavior = ${function:SqueakBehavior}
}
New-Duck @splatNewRubberDuckParams -Quack

# Output:
# Wild Duck
# Flying normal
# Quacking loud
# Mountain Duck
# Flying high
# Quacking loud
# Rubber Duck
# Squeak
