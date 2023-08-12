$InformationPreference = 'Continue'

function Register-Observer {
    param(
        [Parameter(Mandatory)]
        [string]
        $Name
    )
    Write-Information "Subject: [$($myWeatherStation.Name)] attached to observer: [$Name]"
    $($myWeatherStation.Observers.Add($Name))
}

function Unregister-Observer {
    param(
        [Parameter(Mandatory)]
        [string]
        $Name
    )
    Write-Information "Subject: [$($myWeatherStation.Name)] detached from observer: [$Name]"
    $($myWeatherStation.Observers.Remove($Name))
}

function Update-Observer {
    param (
        [Parameter(Mandatory)]
        [int]
        $Temperature
    )
    foreach ($observer in $myWeatherStation.Observers) {
        Write-Information "Subject: [$($myWeatherStation.Name)] notifying observer: [$observer]. Temperature is now: [$($myWeatherStation.Temperature)] degrees"
    }
}

$myWeatherStation = [PSCustomObject]@{
    Name        = 'WeatherStation'
    Temperature = 20
    Observers   = [System.Collections.Generic.List[object]]::new()
}
Register-Observer -Name 'Thermometer'
$myWeatherStation.Temperature = 30
Update-Observer -Temperature $myWeatherStation.Temperature

# Outputs:
# Subject: [WeatherStation] attached to observer: [Thermometer]
# Subject: [WeatherStation] notifying observer: [Thermometer]. Temperature is now: [30] degrees
