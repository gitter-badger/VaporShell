function Add-VSKinesisFirehoseDeliveryStreamRedshiftDestinationConfiguration {
    <#
    .SYNOPSIS
        Adds an AWS::KinesisFirehose::DeliveryStream.RedshiftDestinationConfiguration resource property to the template

    .DESCRIPTION
        Adds an AWS::KinesisFirehose::DeliveryStream.RedshiftDestinationConfiguration resource property to the template

    .LINK
        http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html

    .PARAMETER CloudWatchLoggingOptions
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-cloudwatchloggingoptions    
		Required: False    
		Type: CloudWatchLoggingOptions    
		UpdateType: Mutable    

    .PARAMETER ClusterJDBCURL
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-clusterjdbcurl    
		PrimitiveType: String    
		Required: True    
		UpdateType: Mutable    

    .PARAMETER CopyCommand
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-copycommand    
		Required: True    
		Type: CopyCommand    
		UpdateType: Mutable    

    .PARAMETER Password
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-password    
		PrimitiveType: String    
		Required: True    
		UpdateType: Mutable    

    .PARAMETER RoleARN
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-rolearn    
		PrimitiveType: String    
		Required: True    
		UpdateType: Mutable    

    .PARAMETER S3Configuration
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-s3configuration    
		Required: True    
		Type: S3DestinationConfiguration    
		UpdateType: Mutable    

    .PARAMETER Username
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration.html#cfn-kinesisfirehose-kinesisdeliverystream-redshiftdestinationconfiguration-usename    
		PrimitiveType: String    
		Required: True    
		UpdateType: Mutable    

    .FUNCTIONALITY
        Vaporshell
    #>
    [OutputType('Vaporshell.Resource.KinesisFirehose.DeliveryStream.RedshiftDestinationConfiguration')]
    [cmdletbinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingPlainTextForPassword","Password")]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingUserNameAndPasswordParams","")]
    Param
    (
        [parameter(Mandatory = $false)]
        $CloudWatchLoggingOptions,
        [parameter(Mandatory = $true)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $ClusterJDBCURL,
        [parameter(Mandatory = $true)]
        $CopyCommand,
        [parameter(Mandatory = $true)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $Password,
        [parameter(Mandatory = $true)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $RoleARN,
        [parameter(Mandatory = $true)]
        $S3Configuration,
        [parameter(Mandatory = $true)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $Username
    )
    Begin {
        $obj = [PSCustomObject]@{}
    }
    Process {
        foreach ($key in $PSBoundParameters.Keys) {
            $obj | Add-Member -MemberType NoteProperty -Name $key -Value $PSBoundParameters.$key
        }
    }
    End {
        $obj | Add-ObjectDetail -TypeName 'Vaporshell.Resource.KinesisFirehose.DeliveryStream.RedshiftDestinationConfiguration'
    }
}
