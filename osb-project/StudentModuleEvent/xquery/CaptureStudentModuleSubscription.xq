(:: pragma  parameter="$body" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:CaptureStudentModuleSubscription" location="../../ServiceRepository/Student/StudentModuleEvent/xsd/StudentModuleEvent.1.0.xsd" ::)

declare namespace ns0 = "http://open.ac.uk/Student/StudentModuleEvent";
declare namespace xf = "http://tempuri.org/StudentModuleEvent/xquery/CaptureStudentModuleSubscription/";

declare function xf:CaptureStudentModuleSubscription($body as element(*))
    as element(ns0:CaptureStudentModuleSubscription) {
        <ns0:CaptureStudentModuleSubscription>
            { $body }
        </ns0:CaptureStudentModuleSubscription>
};

declare variable $body as element(*) external;

xf:CaptureStudentModuleSubscription($body)
