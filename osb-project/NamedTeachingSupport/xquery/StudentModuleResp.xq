(:: pragma bea:global-element-return element="ns1:StudentModuleResponse" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns1 = "http://open.ac.uk/soa/Student/CaptureStudentModuleChoice";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/NamedTeachingSupport/xquery/StudentModuleResp/";

declare function xf:StudentModuleResp($boolean as xs:boolean)
    as element(ns1:StudentModuleResponse) {
        <ns1:StudentModuleResponse>
            <ns1:ResponseHeader>
                <ns2:id>OSB</ns2:id>
            </ns1:ResponseHeader>
            <ns1:Success>{ $boolean }</ns1:Success>
        </ns1:StudentModuleResponse>
};

declare variable $boolean as xs:boolean external;

xf:StudentModuleResp($boolean)
