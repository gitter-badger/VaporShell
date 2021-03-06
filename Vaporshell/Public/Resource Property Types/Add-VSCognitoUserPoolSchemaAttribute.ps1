function Add-VSCognitoUserPoolSchemaAttribute {
    <#
    .SYNOPSIS
        Adds an AWS::Cognito::UserPool.SchemaAttribute resource property to the template

    .DESCRIPTION
        Adds an AWS::Cognito::UserPool.SchemaAttribute resource property to the template

    .LINK
        http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html

    .PARAMETER DeveloperOnlyAttribute
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-developeronlyattribute    
		PrimitiveType: Boolean    
		UpdateType: Mutable    

    .PARAMETER Mutable
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-mutable    
		PrimitiveType: Boolean    
		UpdateType: Mutable    

    .PARAMETER AttributeDataType
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-attributedatatype    
		PrimitiveType: String    
		UpdateType: Mutable    

    .PARAMETER StringAttributeConstraints
		Type: StringAttributeConstraints    
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-stringattributeconstraints    
		UpdateType: Mutable    

    .PARAMETER Required
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-required    
		PrimitiveType: Boolean    
		UpdateType: Mutable    

    .PARAMETER NumberAttributeConstraints
		Type: NumberAttributeConstraints    
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-numberattributeconstraints    
		UpdateType: Mutable    

    .PARAMETER Name
		Required: False    
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cognito-userpool-schemaattribute.html#cfn-cognito-userpool-schemaattribute-name    
		PrimitiveType: String    
		UpdateType: Mutable    

    .FUNCTIONALITY
        Vaporshell
    #>
    [OutputType('Vaporshell.Resource.Cognito.UserPool.SchemaAttribute')]
    [cmdletbinding()]
    Param
    (
        [parameter(Mandatory = $false)]
        [System.Boolean]
        $DeveloperOnlyAttribute,
        [parameter(Mandatory = $false)]
        [System.Boolean]
        $Mutable,
        [parameter(Mandatory = $false)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $AttributeDataType,
        [parameter(Mandatory = $false)]
        $StringAttributeConstraints,
        [parameter(Mandatory = $false)]
        [System.Boolean]
        $Required,
        [parameter(Mandatory = $false)]
        $NumberAttributeConstraints,
        [parameter(Mandatory = $false)]
        [ValidateScript( {
                $allowedTypes = "System.String","Vaporshell.Function"
                if ([string]$($_.PSTypeNames) -match "($(($allowedTypes|ForEach-Object{[RegEx]::Escape($_)}) -join '|'))") {
                    $true
                }
                else {
                    throw "This parameter only accepts the following types: $($allowedTypes -join ", "). The current types of the value are: $($_.PSTypeNames -join ", ")."
                }
            })]
        $Name
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
        $obj | Add-ObjectDetail -TypeName 'Vaporshell.Resource.Cognito.UserPool.SchemaAttribute'
    }
}
