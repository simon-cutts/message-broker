(:: pragma  parameter="$studentModuleChoice" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:StudentModuleChoiceRequest" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/Student/StudentModuleEvent";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://open.ac.uk/soa/Student/CaptureStudentModuleChoice";
declare namespace xf = "http://tempuri.org/NamedTeachingSupport/xquery/StudentModuleChoiceRequest/";

declare function xf:StudentModuleChoiceRequest($studentModuleChoice as element(*))
    as element(ns0:StudentModuleChoiceRequest) {
        <ns0:StudentModuleChoiceRequest>
            <ns0:RequestHeader>
                <ns2:id>OSB</ns2:id>
            </ns0:RequestHeader>
            <ns0:StudentModuleChoice>
                <ns1:ModuleReservedEvent>{ $studentModuleChoice/* }</ns1:ModuleReservedEvent>
            </ns0:StudentModuleChoice>
        </ns0:StudentModuleChoiceRequest>
};

declare variable $studentModuleChoice as element(*) external;

xf:StudentModuleChoiceRequest($studentModuleChoice)
