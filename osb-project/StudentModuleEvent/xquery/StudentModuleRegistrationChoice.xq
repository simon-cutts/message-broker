(:: pragma bea:global-element-parameter parameter="$captureStudentModuleSubscription" element="ns1:CaptureStudentModuleSubscription" location="../../ServiceRepository/Student/StudentModuleEvent/xsd/StudentModuleEvent.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:StudentModuleChoice" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/Student/StudentModuleEvent";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://open.ac.uk/soa/Student/CaptureStudentModuleChoice";
declare namespace xf = "http://tempuri.org/StudentModuleEvent/xquery/StudentModuleRegistrationChoice2/";

declare function xf:StudentModuleRegistrationChoice2($captureStudentModuleSubscription as element(ns1:CaptureStudentModuleSubscription))
    as element(ns0:StudentModuleChoice) {
        <ns0:StudentModuleChoice>
            <ns0:StudentModuleRegistrationRequest xmlns:ns0="http://open.ac.uk/soa/Student/CaptureStudentModuleChoice" 
            	xmlns:ns3="http://open.ac.uk/schema/BaseType" xmlns:ns2="http://open.ac.uk/schema/RequestHeader">
                <ns0:RequestHeader>
                    <ns2:id>OSB</ns2:id>
                    <ns2:source>OSB</ns2:source>
                </ns0:RequestHeader>
                <ns0:StudentModule>
                    <ns0:personalId>{ data($captureStudentModuleSubscription/ns1:ModuleRegistrationEvent/ns1:personalId) }</ns0:personalId>
                    <ns0:presentationId>{ data($captureStudentModuleSubscription/ns1:ModuleRegistrationEvent/ns1:presentationId) }</ns0:presentationId>
                    <ns0:productId>{ data($captureStudentModuleSubscription/ns1:ModuleRegistrationEvent/ns1:productId) }</ns0:productId>
                </ns0:StudentModule>
            </ns0:StudentModuleRegistrationRequest>
        </ns0:StudentModuleChoice>
};

declare variable $captureStudentModuleSubscription as element(ns1:CaptureStudentModuleSubscription) external;

xf:StudentModuleRegistrationChoice2($captureStudentModuleSubscription)
