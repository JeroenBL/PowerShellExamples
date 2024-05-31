function Hello {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory)]
    [string]
    $First,

    [Parameter(Mandatory)]
    [string]
    $Last
  )

  Write-Verbose "Hello $First $Last from an AdvancedFunction"
}

Hello 'Jeroen' 'BL' -Verbose
