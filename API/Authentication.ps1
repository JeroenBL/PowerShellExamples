# Basic authentication (PowerShell Core)
$password = ConvertTo-SecureString 'myPassword' -AsPlainText -Force
$credentials = [pscredential]::new('myUserName', $password)
Invoke-RestMethod -Uri 'URI' -Authentication Basic -Credential $credentials -AllowUnencryptedAuthentication

# Basic authentication (Windows PowerShell)
$userName = 'myUserName'
$password = 'myPassword'
headers = @{
    'Authorization' = "Basic $([Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("${userName}:${password}")))"
}
Invoke-RestMethod -Uri 'URI' -Headers $headers

# Token based
$splatParams = @{
  Uri = 'URL/oauth/login'
  Body = @{
    username = 'myUserName'
    password = 'myPasssword'
  } | ConvertTo-Json
  ContentType = 'application/json'
}
$token = Invoke-RestMethod @splatParams

$authenticationHeaders = @{
  Authorization = "Bearer $($token.access_token)"
}
Invoke-RestMethod -Uri 'URI' -Method GET -Headers $authenticationHeaders
