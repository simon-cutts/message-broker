(:: pragma bea:global-element-return element="ns0:SOAPFaultMessage" location="../../ServiceRepository/common/xsd/SOAPFault.1.1.xsd" ::)

declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetCRMActivityList/xquery/GetCRMActivityListSOAPFault/";

declare function xf:GetCRMActivityListSOAPFault($id as xs:string,
    $faultCode as xs:string,
    $faultDetail as xs:string)
    as element(ns0:SOAPFaultMessage) {
        <ns0:SOAPFaultMessage>
            <ns0:id>{ $id }</ns0:id>
            <ns0:Fault>
                <ns0:faultcode>{ $faultCode }</ns0:faultcode>
                <ns0:detail>{ $faultDetail }</ns0:detail>
            </ns0:Fault>
        </ns0:SOAPFaultMessage>
};

declare variable $id as xs:string external;
declare variable $faultCode as xs:string external;
declare variable $faultDetail as xs:string external;

xf:GetCRMActivityListSOAPFault($id,
    $faultCode,
    $faultDetail)
