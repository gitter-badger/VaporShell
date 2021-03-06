function Add-VSElasticsearchDomainSnapshotOptions {
    <#
    .SYNOPSIS
        Adds an AWS::Elasticsearch::Domain.SnapshotOptions resource property to the template

    .DESCRIPTION
        Adds an AWS::Elasticsearch::Domain.SnapshotOptions resource property to the template

    .LINK
        http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticsearch-domain-snapshotoptions.html

    .PARAMETER AutomatedSnapshotStartHour
		Documentation: http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticsearch-domain-snapshotoptions.html#cfn-elasticsearch-domain-snapshotoptions-automatedsnapshotstarthour    
		PrimitiveType: Integer    
		Required: False    
		UpdateType: Mutable    

    .FUNCTIONALITY
        Vaporshell
    #>
    [OutputType('Vaporshell.Resource.Elasticsearch.Domain.SnapshotOptions')]
    [cmdletbinding()]
    Param
    (
        [parameter(Mandatory = $false)]
        [Int]
        $AutomatedSnapshotStartHour
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
        $obj | Add-ObjectDetail -TypeName 'Vaporshell.Resource.Elasticsearch.Domain.SnapshotOptions'
    }
}
