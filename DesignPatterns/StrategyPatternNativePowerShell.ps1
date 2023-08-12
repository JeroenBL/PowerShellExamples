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

New-Duck -Type 'Wild Duck' -FlyBehavior ${function:FlyingNormalBehavior} -QuackBehavior ${function:QuackingLoudBehavior} -Fly -Quack
New-Duck -Type 'Mountain Duck' -FlyBehavior ${function:FlyingHighBehavior} -QuackBehavior ${function:QuackingLoudBehavior} -Fly -Quack
New-Duck -Type 'Rubber Duck' -QuackBehavior ${function:SqueakBehavior} -Quack

# Output:
# Wild Duck
# Flying normal
# Quacking loud
# Mountain Duck
# Flying high
# Quacking loud
# Rubber Duck
# Squeak
