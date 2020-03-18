(:: pragma bea:local-element-parameter parameter="$requestHeader" type="ns3:ManageStudentSSTAllocationRequest/ns3:RequestHeader" location="../../ServiceRepository/Composed/Student/ManageStudentAllocations/xsd/ManageStudentSSTAllocation.0.6.xsd" ::)
(:: pragma bea:global-element-return element="ns0:DeAllocateStudentFromSSTRequest" location="../../ServiceRepository/Student/DeAllocateStudent/xsd/DeAllocateStudentFromSST.0.4.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns3 = "http://open.ac.uk/Student/ManageStudentSSTAllocation";
declare namespace ns0 = "http://open.ac.uk/Student/DeAllocateStudentFromSST";
declare namespace xf = "http://tempuri.org/ManageStudentAllocation/xquery/DeAllocateStudentRequest/";
(: Create a xf:DeAllocateStudentRequest
   
   Author: Simon Cutts :)
   
declare function xf:DeAllocateStudentRequest($personalId as xs:string,
    $productId as xs:string,
    $studentProductStatus as xs:string,
    $requestHeader as element())
    as element(ns0:DeAllocateStudentFromSSTRequest) {
        <ns0:DeAllocateStudentFromSSTRequest>
            {
                let $RequestHeader := $requestHeader
                return
                    <ns0:RequestHeader>
                        <ns1:id>{ data($RequestHeader/ns1:id) }</ns1:id>
                        {
                            for $source in $RequestHeader/ns1:source
                            return
                                <ns1:source>{ data($source) }</ns1:source>
                        }
                        {
                            for $user in $RequestHeader/ns1:user
                            return
                                <ns1:user>{ $user/@* , $user/node() }</ns1:user>
                        }
                    </ns0:RequestHeader>
            }
            <ns0:Student>
                <ns0:personalId>{ $personalId }</ns0:personalId>
                <ns0:DellocatedProduct>
                    <ns0:productId>{ $productId }</ns0:productId>
                    <ns0:studentProductStatus>{ $studentProductStatus }</ns0:studentProductStatus>
                </ns0:DellocatedProduct>
            </ns0:Student>
        </ns0:DeAllocateStudentFromSSTRequest>
};

declare variable $personalId as xs:string external;
declare variable $productId as xs:string external;
declare variable $studentProductStatus as xs:string external;
declare variable $requestHeader as element() external;

xf:DeAllocateStudentRequest($personalId,
    $productId,
    $studentProductStatus,
    $requestHeader)