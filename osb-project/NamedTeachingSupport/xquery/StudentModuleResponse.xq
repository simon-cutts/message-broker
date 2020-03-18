(:: pragma bea:local-element-parameter parameter="$requestHeader" type="ns1:MultipleStudentModuleRegistrationRequest/ns1:RequestHeader" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns1:StudentModuleResponse" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/soa/Student/CaptureStudentModuleChoice";
declare namespace ns4 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/NamedTeachingSupport/xquery/StudentModuleResponse/";

declare function xf:StudentModuleResponse($requestHeader as element(),
    $boolean as xs:boolean)
    as element(ns1:StudentModuleResponse) {
        <ns1:StudentModuleResponse>
            <ns1:ResponseHeader>
                <ns3:id>{ data($requestHeader/ns2:id) }</ns3:id>
            </ns1:ResponseHeader>
            <ns1:Success>{ $boolean }</ns1:Success>
        </ns1:StudentModuleResponse>
};

declare variable $requestHeader as element() external;
declare variable $boolean as xs:boolean external;

xf:StudentModuleResponse($requestHeader,
    $boolean)
