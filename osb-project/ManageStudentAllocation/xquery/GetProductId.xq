(:: pragma bea:local-element-parameter parameter="$requestHeader" type="ns1:ManageStudentAllocationToSSTRequest/ns1:RequestHeader" location="../../ServiceRepository/Composed/Student/ManageStudentAllocations/xsd/ManageStudentSSTAllocation.0.6.xsd" ::)
(:: pragma bea:global-element-return element="ns3:GetProductIdRequest" location="../../ServiceRepository/Product/getProductId/xsd/GetProductId.0.3.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/Student/ManageStudentSSTAllocation";
declare namespace ns3 = "http://open.ac.uk/Product/GetProductId";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageSttAllocation/xquery/GetProductId/";


(: Create a GetProductId message
   
   Author: Simon Cutts :)
   
declare function xf:GetProductId($requestHeader as element(),
    $productType as xs:string,
    $productCode as xs:string)
    as element(ns3:GetProductIdRequest) {
        <ns3:GetProductIdRequest>
            <ns3:RequestHeader>
                <ns0:id>{ data($requestHeader/ns0:id) }</ns0:id>
                {
                    for $source in $requestHeader/ns0:source
                    return
                        <ns0:source>{ data($source) }</ns0:source>
                }
                <ns0:user>
                    {
                        for $credentials in $requestHeader/ns0:user/ns2:credentials
                        return
                            <ns2:credentials>{ data($credentials) }</ns2:credentials>
                    }
                    {
                        for $userID in $requestHeader/ns0:user/ns2:userID
                        return
                            <ns2:userID>{ data($userID) }</ns2:userID>
                    }
                </ns0:user>
            </ns3:RequestHeader>
            <ns3:RequestDetails>
                <ns3:productType>
                    {
                        if ($productType = 'QUALIFICATION') then
                            'RegisterableQualification'
                        else 
                            'Module'
                    }
				</ns3:productType>
                <ns3:productCode>{ fn-bea:trim-right($productCode) }</ns3:productCode>
            </ns3:RequestDetails>
        </ns3:GetProductIdRequest>
};

declare variable $requestHeader as element() external;
declare variable $productType as xs:string external;
declare variable $productCode as xs:string external;

xf:GetProductId($requestHeader,
    $productType,
    $productCode)