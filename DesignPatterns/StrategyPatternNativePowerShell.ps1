function FlyingHighBehavior {
    'high'
}

function FlyingNormalBehavior {
    'normal'
}

function QuackingLoudBehavior {
    'loud'
}

function SqueakBehavior {
    'squeak'
}

function New-Duck {
    param (
        [Parameter(Mandatory)]
        [string]
        $Name,

        [Parameter()]
        [scriptblock]
        $FlyBehavior,

        [Parameter(Mandatory)]
        [scriptblock]
        $QuackBehavior
    )
    $fly = $FlyBehavior.Invoke()
    $quack = $QuackBehavior.Invoke()
    
    Write-Host "[$Name] flying: [$fly] and quacking: [$quack]"
}

New-Duck -Name 'Wild Duck' -FlyBehavior ${function:FlyingNormalBehavior} -QuackBehavior ${function:QuackingLoudBehavior}
New-Duck -Name 'Mountain Duck' -FlyBehavior ${function:FlyingHighBehavior} -QuackBehavior ${function:QuackingLoudBehavior}
New-Duck -Name 'Rubber Duck' -FlyBehavior {'does not fly'} -QuackBehavior ${function:SqueakBehavior}

# Output:
# [Wild Duck] flying: [normal] and quacking: [loud]
# [Mountain Duck] flying: [high] and quacking: [loud]
# [Rubber Duck] flying: [does not fly] and quacking: [squeak]
