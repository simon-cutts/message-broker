(:: pragma bea:global-element-parameter parameter="$sOAPFaultMessage" element="ns0:SOAPFaultMessage" location="../../../ServiceRepository/common/xsd/SOAPFault.1.1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Fault" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/Common/error/xquery/OuFaultToSoapFault/";

declare function xf:OuFaultToSoapFault($sOAPFaultMessage as element(ns0:SOAPFaultMessage),
	$faultCode as xs:string?)
    as element(ns1:Fault) {
        <ns1:Fault>
        	<faultcode>{ data($faultCode) }</faultcode>
            <faultstring>{ data($sOAPFaultMessage/ns0:Fault/ns0:detail) }</faultstring>
            <detail>
            {$sOAPFaultMessage}
            </detail>
        </ns1:Fault>
};

declare variable $sOAPFaultMessage as element(ns0:SOAPFaultMessage) external;
declare variable $faultCode as xs:string? external;


xf:OuFaultToSoapFault($sOAPFaultMessage,$faultCode)
