function Convert-SpecToFunction {
    Param
    (
      [parameter(Mandatory=$true,Position=0)]
      [Object]
      $Resource,
      [parameter(Mandatory=$true,Position=1)]
      [ValidateSet("Resource","Property")]
      [String]
      $ResourceType
    )
    $ModPath = $Script:VaporshellPath
    $folder = "$($ModPath)\Public"
    $Name = $Resource.Name
    $Link = $Resource.Value.Documentation
    $Properties = $Resource.Value.Properties.PSObject.Properties
    $ShortName = $Name.Replace("AWS::","")
    $BaseTypeName = "Vaporshell.Resource." + ($ShortName -replace "\..*").Replace("::",".")
    $TypeName = "Vaporshell.Resource." + $ShortName.Replace("::",".")
    switch ($ResourceType) {
        Resource {
            $Dir = "$folder\Resource Types"
            $FunctionName = "New-VS" + ($ShortName -replace "\..*").Replace("::","")
            $Synopsis = "Adds an $Name resource to the template"
        }
        Property {
            $Dir = "$folder\Resource Property Types"
            $FunctionName = "Add-VS" + $ShortName.Replace("::","").Replace(".","")
            $Synopsis = "Adds an $Name resource property to the template"
        }
    }
    $PS1Path = "$Dir\$FunctionName.ps1"
$scriptContents = @()
$scriptContents += @"
function $FunctionName {
    <#
    .SYNOPSIS
        $Synopsis

    .DESCRIPTION
        $Synopsis

    .LINK
        $Link

"@ 
if ($ResourceType -ne "Property") {
    $scriptContents += @"
    .PARAMETER LogicalId
        The logical ID must be alphanumeric (A-Za-z0-9) and unique within the template. Use the logical name to reference the resource in other parts of the template. For example, if you want to map an Amazon Elastic Block Store volume to an Amazon EC2 instance, you reference the logical IDs to associate the block stores with the instance.`n
"@
}

foreach ($Prop in $Properties) {
$scriptContents +=@"
    .PARAMETER $($Prop.Name)
"@
$pList = $Prop.value.psobject.properties
foreach ($p in $pList) {
    $scriptContents += "`t`t$($p.Name): $($p.Value)    "
}
$scriptContents += ""
}

if ($Name -eq "AWS::AutoScaling::AutoScalingGroup" -or $Name -eq "AWS::EC2::Instance" -or $Name -eq "AWS::CloudFormation::WaitCondition") {
    $scriptContents += @"
    .PARAMETER CreationPolicy
        Use the CreationPolicy attribute when you want to wait on resource configuration actions before stack creation proceeds. For example, if you install and configure software applications on an EC2 instance, you might want those applications to be running before proceeding. In such cases, you can add a CreationPolicy attribute to the instance, and then send a success signal to the instance after the applications are installed and configured.

        You must use the "Add-CreationPolicy" function here.`n
"@
}

if ($ResourceType -ne "Property") {
    $scriptContents += @"    
    .PARAMETER DeletionPolicy
        With the DeletionPolicy attribute you can preserve or (in some cases) backup a resource when its stack is deleted. You specify a DeletionPolicy attribute for each resource that you want to control. If a resource has no DeletionPolicy attribute, AWS CloudFormation deletes the resource by default.

        To keep a resource when its stack is deleted, specify Retain for that resource. You can use retain for any resource. For example, you can retain a nested stack, S3 bucket, or EC2 instance so that you can continue to use or modify those resources after you delete their stacks.

        You must use one of the following options: "Delete","Retain","Snapshot"


    .PARAMETER DependsOn
        With the DependsOn attribute you can specify that the creation of a specific resource follows another. When you add a DependsOn attribute to a resource, that resource is created only after the creation of the resource specified in the DependsOn attribute.

        This parameter takes a string or list of strings representing Logical IDs of resources that must be created prior to this resource being created.


    .PARAMETER Metadata
        The Metadata attribute enables you to associate structured data with a resource. By adding a Metadata attribute to a resource, you can add data in JSON or YAML to the resource declaration. In addition, you can use intrinsic functions (such as GetAtt and Ref), parameters, and pseudo parameters within the Metadata attribute to add those interpreted values.

        You must use a PSCustomObject containing key/value pairs here. This will be returned when describing the resource using AWS CLI.


    .PARAMETER UpdatePolicy
        Use the UpdatePolicy attribute to specify how AWS CloudFormation handles updates to the AWS::AutoScaling::AutoScalingGroup resource. AWS CloudFormation invokes one of three update policies depending on the type of change you make or whether a scheduled action is associated with the Auto Scaling group.

        You must use the "Add-UpdatePolicy" function here.
    

    .PARAMETER Condition
        Logical ID of the condition that this resource needs to be true in order for this resource to be provisioned.`n
"@
}
$scriptContents += @"
    .FUNCTIONALITY
        Vaporshell
    #>
    [OutputType('$TypeName')]
    [cmdletbinding()]
"@
if ($passProps = $Properties.Name | Where-Object {$_ -like "*Password*" -or $_ -like "*Credential*"}) {
    foreach ($passProp in $passProps) {
        $scriptContents += @"
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword","$passProp")]
"@
    }
    $scriptContents += @"
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPasswordParams","")]
"@
}
$scriptContents += @"
    Param
    (
"@
if ($ResourceType -ne "Property") {
        $scriptContents += @"
        [parameter(Mandatory = `$true,Position = 0)]
        [ValidateScript( {
                if (`$_ -match "^[a-zA-Z0-9]*$") {
                    `$true
                }
                else {
                    throw 'The logical ID must be alphanumeric (a-z, A-Z, 0-9) and unique within the template.'
                }
            })]
        [System.String]
        `$LogicalId,
"@
}
$PCount = 0
$Properties | ForEach-Object {$PCount++}
$i = 0
foreach ($Prop in $Properties) {
    $i++
    if ($ResourceType -ne "Property"){
        $ParamName = "$($Prop.Name),"
    }
    elseif ($i -lt [int]$PCount) {
        $ParamName = "$($Prop.Name),"
    }
    else {
        $ParamName = "$($Prop.Name)"
    }
    if ($Prop.Value.Required -eq "True"){
        $Mandatory = '$true'
    }
    else {
        $Mandatory = '$false'
    }
    if ($Prop.Value.ItemType) {
        if ($Prop.Value.ItemType -eq "Tag") {
            $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [ValidateScript( {
                `$allowedTypes = "Vaporshell.Resource.Tag","System.Management.Automation.PSCustomObject"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$$ParamName
"@
        }
        else {
            $ValTypeName = "$($BaseTypeName).$($Prop.Value.ItemType)"
            $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [ValidateScript( {
                `$allowedTypes = "$ValTypeName"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$$ParamName
"@
        }
    }
    elseif ($Prop.Name -eq "UserData") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [ValidateScript( {
                `$allowedTypes = "Vaporshell.Function.Base64","Vaporshell.Resource.UserData"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$$ParamName
"@
        }
    elseif ($Prop.Value.Type -eq "Map") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [System.Collections.Hashtable]
        `$$ParamName
"@
    }
    elseif ($Prop.Value.PrimitiveType -eq "Integer" -or $Prop.Value.PrimitiveType -eq "Number") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [Int]
        `$$ParamName
"@
    }
    elseif ($Prop.Value.PrimitiveType -eq "Double") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [System.Double]
        `$$ParamName
"@
    }
    elseif ($Prop.Value.PrimitiveType -eq "Boolean") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [System.Boolean]
        `$$ParamName
"@
    }
    elseif ($Prop.Value.PrimitiveType -eq "String") {
        if ($ParamName -eq "LoggingLevel") {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [ValidateSet("OFF","ERROR","INFO")]
        `$$ParamName
"@
        }
        else {
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        [ValidateScript( {
                `$allowedTypes = "System.String","Vaporshell.Function"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$$ParamName
"@
        }
    }
    else{
        $scriptContents += @"
        [parameter(Mandatory = $Mandatory)]
        `$$ParamName
"@
    }
}

if ($ResourceType -ne "Property") {
    if ($Name -eq "AWS::AutoScaling::AutoScalingGroup" -or $Name -eq "AWS::EC2::Instance" -or $Name -eq "AWS::CloudFormation::WaitCondition") {
        $scriptContents += @"
        [parameter(Mandatory = `$false)]
        [ValidateScript( {
                `$allowedTypes = "Vaporshell.Resource.CreationPolicy"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$CreationPolicy,
"@
    }
    $scriptContents += @"
        [ValidateSet("Delete","Retain","Snapshot")]
        [System.String]
        `$DeletionPolicy,
        [parameter(Mandatory = `$false)]
        [System.String[]]
        `$DependsOn,
        [parameter(Mandatory = `$false)]
        [ValidateScript( {
                `$allowedTypes = "System.Management.Automation.PSCustomObject"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "The UpdatePolicy parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$Metadata,
        [parameter(Mandatory = `$false)]
        [ValidateScript( {
                `$allowedTypes = "Vaporshell.Resource.UpdatePolicy"
                if ([string]`$(`$_.PSTypeNames) -match "(`$((`$allowedTypes|ForEach-Object{[RegEx]::Escape(`$_)}) -join '|'))") {
                    `$true
                }
                else {
                    throw "This parameter only accepts the following types: `$(`$allowedTypes -join ", "). The current types of the value are: `$(`$_.PSTypeNames -join ", ")."
                }
            })]
        `$UpdatePolicy,
        [parameter(Mandatory = `$false)]
        `$Condition
    )
    Begin {
        `$ResourceParams = @{
            LogicalId = `$LogicalId
            Type = "$Name"
        }
    }
    Process {
        foreach (`$key in `$PSBoundParameters.Keys) {
            switch (`$key) {
                'LogicalId' {}
"@
    if ($Name -eq "AWS::AutoScaling::AutoScalingGroup" -or $Name -eq "AWS::EC2::Instance" -or $Name -eq "AWS::CloudFormation::WaitCondition") {
        $scriptContents += @"
                'CreationPolicy' {
                    `$ResourceParams.Add("CreationPolicy",`$CreationPolicy)
                }
"@
    }
        $scriptContents += @"
                'DeletionPolicy' {
                    `$ResourceParams.Add("DeletionPolicy",`$DeletionPolicy)
                }
                'DependsOn' {
                    `$ResourceParams.Add("DependsOn",`$DependsOn)
                }
                'Metadata' {
                    `$ResourceParams.Add("Metadata",`$Metadata)
                }
                'UpdatePolicy' {
                    `$ResourceParams.Add("UpdatePolicy",`$UpdatePolicy)
                }
                'Condition' {
                    `$ResourceParams.Add("Condition",`$Condition)
                }
"@
    foreach ($Prop in $Properties | Where-Object {$_.Value.Type -eq "List"}) {
        $scriptContents += @"
                '$($Prop.Name)' {
                    if (!(`$ResourceParams["Properties"])) {
                        `$ResourceParams.Add("Properties",([PSCustomObject]@{}))
                    }
                    `$ResourceParams["Properties"] | Add-Member -MemberType NoteProperty -Name $($Prop.Name) -Value @(`$$($Prop.Name))
                }
"@
    }
        $scriptContents += @"
                Default {
                    if (!(`$ResourceParams["Properties"])) {
                        `$ResourceParams.Add("Properties",([PSCustomObject]@{}))
                    }
                    `$ResourceParams["Properties"] | Add-Member -MemberType NoteProperty -Name `$key -Value `$PSBoundParameters.`$key
                }
            }
        }
    }
    End {
        `$obj = New-VaporResource @ResourceParams
        `$obj | Add-ObjectDetail -TypeName '$TypeName'
        Write-Verbose "Resulting JSON from `$(`$MyInvocation.MyCommand): ``n``n`$(@{`$obj.LogicalId = `$obj.Props} | ConvertTo-Json -Depth 5)``n"
    }
}
"@
}
else {
$scriptContents += @"
    )
    Begin {
        `$obj = [PSCustomObject]@{}
    }
    Process {
        foreach (`$key in `$PSBoundParameters.Keys) {
            `$obj | Add-Member -MemberType NoteProperty -Name `$key -Value `$PSBoundParameters.`$key
        }
    }
    End {
        `$obj | Add-ObjectDetail -TypeName '$TypeName'
    }
}
"@
}
Set-Content -Value $scriptContents -Path $PS1Path -Encoding UTF8 -Force
}