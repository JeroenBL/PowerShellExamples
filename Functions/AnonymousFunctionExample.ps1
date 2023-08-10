$anonymousFunction = {
    param($First,$Last)
    return "Hello $First $Last from a AnonymousFunction"
}

$anonymousFunction.Invoke('Jeroen', 'BL')
