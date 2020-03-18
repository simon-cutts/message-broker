(:: pragma bea:global-element-parameter parameter="$getStudentSSTAllocationResponse" element="ns0:GetStudentSSTAllocationResponse" location="../../ServiceRepository/Student/SST/xsd/SST.0.2.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$getProductDataResponse" element="ns3:GetProductDataResponse" location="../../ServiceRepository/Product/GetProductData/xsd/GetProductData.0.1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:GetStudentProductSSTAllocationResponse" location="../../ServiceRepository/Student/GetStudentProductSSTAllocation/xsd/GetStudentProductSSTAllocation.0.1.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/faults";
declare namespace ns1 = "http://open.ac.uk/Student/GetStudentProductSSTAllocation";
declare namespace ns4 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns3 = "http://open.ac.uk/Product/GetProductData";
declare namespace ns0 = "http://open.ac.uk/Student/SST";
declare namespace xf = "http://tempuri.org/GetStudentProductSSTAllocation/xquery/GetStudentProductSStAllocationResponse/";

declare function xf:GetStudentProductSStAllocationResponse($getStudentSSTAllocationResponse as element(ns0:GetStudentSSTAllocationResponse)?,
    $getProductDataResponse as element(ns3:GetProductDataResponse)?,
    $id as xs:string)
    as element(ns1:GetStudentProductSSTAllocationResponse) {
        <ns1:GetStudentProductSSTAllocationResponse>
            <ns1:ResponseHeader>
                <ns4:id>{ $id }</ns4:id>
            </ns1:ResponseHeader>
            {
                let $Student := $getStudentSSTAllocationResponse/ns0:Student
                return
                    <ns1:Student>
                        <ns1:personalId>{ data($Student/ns0:personalId) }</ns1:personalId>
                        {
                            for $Allocation in $Student/ns0:Allocation
                            return
                                <ns1:Allocation>
                                    <ns1:studentSstStartDate>{ data($Allocation/ns0:studentSstStartDate) }</ns1:studentSstStartDate>
                                    {
                                        for $studentSstEndDate in $Allocation/ns0:studentSstEndDate
                                        return
                                            <ns1:studentSstEndDate>{ data($studentSstEndDate) }</ns1:studentSstEndDate>
                                    }
                                    <ns1:studentSstSupportType>{ data($Allocation/ns0:studentSstSupportType) }</ns1:studentSstSupportType>
                                    {
                                        let $result :=
                                            for $Product in $getProductDataResponse/ns3:Product
                                            where data($Allocation/ns0:Product/ns0:productId) = data($Product/ns3:productId)
                                            return
                                                <ns1:Product>
                                                    <ns1:productId>{ data($Product/ns3:productId) }</ns1:productId>
                                                    <ns1:productType>{ data($Product/ns3:productType) }</ns1:productType>
                                                    <ns1:productCode>{ data($Product/ns3:productCode) }</ns1:productCode>
                                                    <ns1:productTitle>{ data($Product/ns3:productTitle) }</ns1:productTitle>
                                                </ns1:Product>
                                        return
                                            $result[1]
                                    }
                                    {
                                        let $StudentSupportTeam := $Allocation/ns0:StudentSupportTeam
                                        return
                                            <ns1:StudentSupportTeam>
                                                <ns1:sstId>{ data($StudentSupportTeam/ns0:sstId) }</ns1:sstId>
                                                <ns1:sstName>{ data($StudentSupportTeam/ns0:sstName) }</ns1:sstName>
                                                <ns1:sstCau>{ data($StudentSupportTeam/ns0:sstCau) }</ns1:sstCau>
                                                <ns1:sstRegionCode>{ data($StudentSupportTeam/ns0:sstRegionCode) }</ns1:sstRegionCode>
                                                <ns1:subjectAreaCode>{ data($StudentSupportTeam/ns0:subjectAreaCode) }</ns1:subjectAreaCode>
                                                <ns1:sstStatus>{ data($StudentSupportTeam/ns0:sstStatus) }</ns1:sstStatus>
                                            </ns1:StudentSupportTeam>
                                    }
                                </ns1:Allocation>
                        }
                    </ns1:Student>
            }
        </ns1:GetStudentProductSSTAllocationResponse>
};

declare variable $getStudentSSTAllocationResponse as element(ns0:GetStudentSSTAllocationResponse)? external;
declare variable $getProductDataResponse as element(ns3:GetProductDataResponse)? external;
declare variable $id as xs:string external;

xf:GetStudentProductSStAllocationResponse($getStudentSSTAllocationResponse,
    $getProductDataResponse,
    $id)
