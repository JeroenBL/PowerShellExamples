## Introduction
Error handling is one of the most critical aspects of building reliable and robust PowerShell connectors for HelloID, yet it's often overlooked. If you're working with REST APIs in PowerShell, error handling becomes even more important but unfortunately, it also increases complexity.

In this blog post, we'll explore the basics of error handling in PowerShell and provide some best practices for handling REST API errors. 

## Try/Catch

Your code, at some point, will likely generate errors or exceptions under a certain condition. For example, if you're working with a file and the file doesn't exist, reading the file could cause an error. In order to handle such an error, PowerShell provides a `try/catch` statement. The `try` block monitors the code you are executing. If an error occurs, the `catch` block will, quite literally, catch the error and act accordingly.

In the code example below, a try block is defined to attempt to read a folder that does not exist. If an error occurs, the catch block is triggered and outputs a message showing the error that is in `$_.Exception.Message`

```powershell
try {
    Get-Content c:\doesnotexist
} catch {
    "Error occurred: $($_.Exception.Message)"
}
```

Since the file path specified in Get-Content does not exist, an error will be thrown and caught by the catch block, which will then output the error message as specified.

> Error occurred: Cannot find path 'C:\doesnotexist' because it does not exist. 

## Handling REST API errors

### Exception types

First of all, both _Windows PowerShell_ and _PowerShell Core_ will throw different exception types. This is because they are built on different versions of _.NET_ but also, use different methods of intereacting with HTTP. _Windows PowerShell_ uses the older `System.Net.WebRequest`, whereas _PowerShell Core_ uses the newer `System.Net.HttpClient` and because of this, both will throw different exception types.

| PowerShell version | .NET version | Exception type |
| --- | --- | --- |
| Windows PowerShell | .NET Framework | `System.Net.WebException` |
| PowerShell Core | .NET Core | `Microsoft.PowerShell.Commands.HttpResponseException`

### `$_.ErrorDetails`

Error messages returned by the API can typically be found in the `$_.ErrorDetails` object. In most cases, this object contains a JSON payload that includes the error message.

> In some cases on _Windows PowerShell_ the `$_.ErrorDetails` object will be empty. To work around this issue, you will have to retrieve the error response stream.

##### ResponseStream code example

```powershell
[System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream()).ReadToEnd()
``` 

## Real scenario

Consider this code:

```powershell
try {
    $splatParams = @{
        Uri     = "https://graph.microsoft.com/v1.0/users/12345"
        Method  = 'GET'
        Verbose = $false
        Headers = @{
            Authorization  = "Bearer $accessToken"
            Accept         = 'application/json'
            'Content-Type' = 'application/json'
        }
    }
    Invoke-RestMethod @splatParams
} catch {
}
```

In this code block, we will execute the following steps:

1. Define a hashtable called `splatParams`. The keys of the hash table represent the properties of the `Invoke-RestMethod` cmdlet.

2. Retrieve a user with id `12345` that does not exists. Meaning, this request will generate an exception.

Let's look at the `catch` block for PowerShell Core.

### Best practice PowerShell Core

> When working with _PowerShell Core_, it's generally a good practice to use the `$_.ErrorDetails` object to handle errors returned from an API.

```powershell
try {
    $splatParams = @{
        Uri     = "https://graph.microsoft.com/v1.0/users/12345"
        Method  = 'GET'
        Verbose = $false
        Headers = @{
            Authorization  = "Bearer $accessToken"
            Accept         = 'application/json'
            'Content-Type' = 'application/json'
        }
    }
    Invoke-RestMethod @splatParams
} catch {
    Write-Verbose "PowerShell version: $($PSVersionTable.PSVersion)"
    Write-Verbose "Exception of type: $($_.Exception.GetType())"
    Write-Verbose ($($_.ErrorDetails.Message) | ConvertFrom-Json).Error.Message
}
```

In catch code block, we will execute the following steps:

1. When we hit the `catch` block, write a verbose message for the `$PSVersionTable.PSVersion` and `$_.Exception.GetType()`

2. Grab the error response from `$_.ErrorDetails.Message`, convert it to an object, obtain the `Error.Message` and write that to the __verbose__ stream.

![PScoreExample](https://raw.githubusercontent.com/JeroenBL/jeroenbl.github.io/main/_posts/2023-03-10-error-handling/PSCoreExample.gif)

### Best practice Windows PowerShell

> Use the [error response stream](#responsestream-code-example) to handle errors returned from an API. By using the error response stream, you can ensure that you have access to the full range of error information returned by the API.

```powershell
try {
    $splatParams = @{
        Uri     = "https://graph.microsoft.com/v1.0/users/12345"
        Method  = 'GET'
        Verbose = $false
        Headers = @{
            Authorization  = "Bearer $accessToken"
            Accept         = 'application/json'
            'Content-Type' = 'application/json'
        }
    }
    Invoke-RestMethod @splatParams
} catch {
    Write-Verbose "PowerShell version: $($PSVersionTable.PSVersion)"
    Write-Verbose "Exception of type: $($_.Exception.GetType())"
    Write-Verbose ([System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream()).ReadToEnd() | ConvertFrom-Json).Error.Message
}
```

In catch code block, we will execute the following steps:

1. When we hit the `catch` block, write a verbose message for the `$PSVersionTable.PSVersion` and `$_.Exception.GetType()`

2. Get the reponse stream using the `GetResponseStream()` method, convert it to an object, obtain the `Error.Message` and write that to the __verbose__ stream.

![WinPSExample](https://raw.githubusercontent.com/JeroenBL/jeroenbl.github.io/main/_posts/2023-03-10-error-handling/WinPSExample.gif)

## Summary

In this blog post, we explored the fundamental aspects of error handling in PowerShell when working with REST APIs. We delved into the key differences between PowerShell Core and Windows PowerShell, understanding that error handling techniques may vary slightly between these two versions. 

In the next part of this series, we will look into topics such as handling specific HTTP status codes, implementing retry mechanisms for transient errors, and working with complex error responses.

Additionally, we will explore techniques for customizing error messages to provide more meaningful feedback to end-users while ensuring technical details are available for developers during debugging and maintenance.
