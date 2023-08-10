[Func[string,string, string]] $delegateFunction = {
    param($First,$Last)
    return "Hello $First $Last from a Delegatefunction"
}
$delegateFunction.Invoke('Jeroen', 'BL')
