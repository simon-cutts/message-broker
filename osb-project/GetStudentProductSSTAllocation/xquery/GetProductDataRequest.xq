(:: pragma bea:local-element-parameter parameter="$requestHeader" type="ns2:GetStudentProductSSTAllocationRequest/ns2:RequestHeader" location="../../ServiceRepository/Student/GetStudentProductSSTAllocation/xsd/GetStudentProductSSTAllocation.0.1.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$getStudentSSTAllocationResponse" element="ns0:GetStudentSSTAllocationResponse" location="../../ServiceRepository/Student/SST/xsd/SST.0.2.xsd" ::)
(:: pragma bea:global-element-return element="ns4:GetProductDataRequest" location="../../ServiceRepository/Product/GetProductData/xsd/GetProductData.0.1.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/Student/GetStudentProductSSTAllocation";
declare namespace ns1 = "http://open.ac.uk/schema/faults";
declare namespace ns4 = "http://open.ac.uk/Product/GetProductData";
declare namespace ns3 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns0 = "http://open.ac.uk/Student/SST";
declare namespace ns5 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns6 = "http://open.ac.uk/schema/BaseType";
declare namespace xf = "http://tempuri.org/GetStudentProductSSTAllocation/xquery/GetProductDataRequest/";

declare function xf:GetProductDataRequest($requestHeader as element(),
    $getStudentSSTAllocationResponse as element(ns0:GetStudentSSTAllocationResponse))
    as element(ns4:GetProductDataRequest) {
        <ns4:GetProductDataRequest>
            {
                let $RequestHeader := $requestHeader
                return
                    <ns4:RequestHeader>
                        <ns3:id>{ data($RequestHeader/ns3:id) }</ns3:id>
                        {
                            for $source in $RequestHeader/ns3:source
                            return
                                <ns3:source>{ data($source) }</ns3:source>
                        }
                        {
                            for $user in $RequestHeader/ns3:user
                            return
                                <ns3:user>{ $user/@* , $user/node() }</ns3:user>
                        }
                    </ns4:RequestHeader>
            }
            {
                for $Allocation in $getStudentSSTAllocationResponse/ns0:Student/ns0:Allocation
                return
                    <ns4:RequestedProduct>
                        <ns4:productId>{ data($Allocation/ns0:Product/ns0:productId) }</ns4:productId>
                    </ns4:RequestedProduct>
            }
        </ns4:GetProductDataRequest>
};

declare variable $requestHeader as element() external;
declare variable $getStudentSSTAllocationResponse as element(ns0:GetStudentSSTAllocationResponse) external;

xf:GetProductDataRequest($requestHeader,
    $getStudentSSTAllocationResponse)
