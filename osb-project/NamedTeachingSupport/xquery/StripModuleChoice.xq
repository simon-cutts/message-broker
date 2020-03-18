(:: pragma bea:global-element-parameter parameter="$studentModuleChoice" element="ns0:StudentModuleChoice" location="../../ServiceRepository/Student/CaptureStudentModuleChoice/xsd/CaptureStudentModuleChoice.1.0.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns0 = "http://open.ac.uk/soa/Student/CaptureStudentModuleChoice";
declare namespace xf = "http://tempuri.org/NamedTeachingSupport/xquery/StripModuleChoice/";

declare function xf:StripModuleChoice($studentModuleChoice as element(ns0:StudentModuleChoice))
    as element(*) {
        $studentModuleChoice/*
};

declare variable $studentModuleChoice as element(ns0:StudentModuleChoice) external;

xf:StripModuleChoice($studentModuleChoice)
