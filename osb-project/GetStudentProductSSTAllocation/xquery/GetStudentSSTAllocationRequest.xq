(:: pragma bea:global-element-parameter parameter="$getStudentProductSSTAllocationRequest" element="ns1:GetStudentProductSSTAllocationRequest" location="../../ServiceRepository/Student/GetStudentProductSSTAllocation/xsd/GetStudentProductSSTAllocation.0.1.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetStudentSSTAllocationRequest" location="../../ServiceRepository/Student/SST/xsd/SST.0.2.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/Student/GetStudentProductSSTAllocation";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://open.ac.uk/Student/SST";
declare namespace xf = "http://tempuri.org/GetStudentProductSSTAllocation/xquery/GetStudentSSTAllocationRequest/";

declare function xf:GetStudentSSTAllocationRequest($getStudentProductSSTAllocationRequest as element(ns1:GetStudentProductSSTAllocationRequest))
    as element(ns0:GetStudentSSTAllocationRequest) {
        <ns0:GetStudentSSTAllocationRequest>
            {
                let $RequestHeader := $getStudentProductSSTAllocationRequest/ns1:RequestHeader
                return
                    <ns0:RequestHeader>
                        <ns2:id>{ data($RequestHeader/ns2:id) }</ns2:id>
                        {
                            for $source in $RequestHeader/ns2:source
                            return
                                <ns2:source>{ data($source) }</ns2:source>
                        }
                        {
                            for $user in $RequestHeader/ns2:user
                            return
                                <ns2:user>{ $user/@* , $user/node() }</ns2:user>
                        }
                    </ns0:RequestHeader>
            }
            {
                let $StudentDetails := $getStudentProductSSTAllocationRequest/ns1:StudentDetails
                return
                    <ns0:StudentDetails>
                        <ns0:personalId>{ data($StudentDetails/ns1:personalId) }</ns0:personalId>
                    </ns0:StudentDetails>
            }
        </ns0:GetStudentSSTAllocationRequest>
};

declare variable $getStudentProductSSTAllocationRequest as element(ns1:GetStudentProductSSTAllocationRequest) external;

xf:GetStudentSSTAllocationRequest($getStudentProductSSTAllocationRequest)
