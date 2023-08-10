$body = @{
  UserName = 'myÜserNamé'
  FullName = 'Jöhn Doë'
} | ConvertTo-Json

$encodedBody = [System.Text.Encoding]::UTF8.GetBytes($body)
# Use $encodedBody in the -Body param of 'Invoke-RestMethod'
