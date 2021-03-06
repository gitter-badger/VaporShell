function Add-VSOpsWorksLayerAutoScalingThresholds {
    <#
    .SYNOPSIS
        Adds an AWS::OpsWorks::Layer.AutoScalingThresholds resource property to the template

    .DESCRIPTION
        Adds an AWS::OpsWorks::Layer.AutoScalingThresholds resource property to the template

    .LINK
        http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html

    .PARAMETER CpuThreshold
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-cputhreshold    
		PrimitiveType: Double    
		Required: False    
		UpdateType: Mutable    

    .PARAMETER IgnoreMetricsTime
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-ignoremetricstime    
		PrimitiveType: Integer    
		Required: False    
		UpdateType: Mutable    

    .PARAMETER InstanceCount
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-instancecount    
		PrimitiveType: Integer    
		Required: False    
		UpdateType: Mutable    

    .PARAMETER LoadThreshold
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-loadthreshold    
		PrimitiveType: Double    
		Required: False    
		UpdateType: Mutable    

    .PARAMETER MemoryThreshold
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-memorythreshold    
		PrimitiveType: Double    
		Required: False    
		UpdateType: Mutable    

    .PARAMETER ThresholdsWaitTime
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-opsworks-layer-loadbasedautoscaling-autoscalingthresholds.html#cfn-opsworks-layer-loadbasedautoscaling-autoscalingthresholds-thresholdwaittime    
		PrimitiveType: Integer    
		Required: False    
		UpdateType: Mutable    

    .FUNCTIONALITY
        Vaporshell
    #>
    [OutputType('Vaporshell.Resource.OpsWorks.Layer.AutoScalingThresholds')]
    [cmdletbinding()]
    Param
    (
        [parameter(Mandatory = $false)]
        [System.Double]
        $CpuThreshold,
        [parameter(Mandatory = $false)]
        [Int]
        $IgnoreMetricsTime,
        [parameter(Mandatory = $false)]
        [Int]
        $InstanceCount,
        [parameter(Mandatory = $false)]
        [System.Double]
        $LoadThreshold,
        [parameter(Mandatory = $false)]
        [System.Double]
        $MemoryThreshold,
        [parameter(Mandatory = $false)]
        [Int]
        $ThresholdsWaitTime
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
        $obj | Add-ObjectDetail -TypeName 'Vaporshell.Resource.OpsWorks.Layer.AutoScalingThresholds'
    }
}
