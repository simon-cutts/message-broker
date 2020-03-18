(:: pragma bea:global-element-return element="ns1:GetStudentProductSSTAllocationResponse" location="../../ServiceRepository/Student/GetStudentProductSSTAllocation/xsd/GetStudentProductSSTAllocation.0.1.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns1 = "http://open.ac.uk/Student/GetStudentProductSSTAllocation";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetStudentProductSSTAllocation/xquery/GetStudentProductSStAllocationFault/";

declare function xf:GetStudentProductSStAllocationFault($id as xs:string?,
    $faultCode as xs:string?,
    $faultDetail as xs:string?)
    as element(ns1:GetStudentProductSSTAllocationResponse) {
        <ns1:GetStudentProductSSTAllocationResponse>
            <ns1:ResponseHeader>
                <ns2:id>{ $id }</ns2:id>
                <ns2:fault>
                    <ns0:faultcode>{ $faultCode }</ns0:faultcode>
                    <ns0:detail>{ $faultDetail }</ns0:detail>
                </ns2:fault>
            </ns1:ResponseHeader>
        </ns1:GetStudentProductSSTAllocationResponse>
};

declare variable $id as xs:string? external;
declare variable $faultCode as xs:string? external;
declare variable $faultDetail as xs:string? external;

xf:GetStudentProductSStAllocationFault($id,
    $faultCode,
    $faultDetail)
