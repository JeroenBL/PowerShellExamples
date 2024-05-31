function Hello {
  param (
    $First,
    $Last
  )

  Write-Output "Hello $First $Last from a BasicFunction"
}
Hello 'Jeroen' 'BL'
