(:: pragma bea:global-element-parameter parameter="$header" element="ns1:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$body" element="ns1:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$soapFault" element="ns1:Fault" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outbound" element="ns2:endpoint" location="../../../ServiceRepository/Osb/xsd/MessageContext.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Audit" location="../../../ServiceRepository/ouosb/xsd/Audit.xsd" ::)

declare namespace ns2 = "http://www.bea.com/wli/sb/context";
declare namespace ns1 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://open.ac.uk/audit/";
declare namespace xf = "http://tempuri.org/Common/error/xquery/AuditError/";

declare function xf:AuditError($header as element(ns1:Header)?,
    $body as element(ns1:Body)?,
    $outbound as element(ns2:endpoint)?,
    $soapFault as element(ns1:Fault)?)
    as element(ns0:Audit) {
        <ns0:Audit>
            <ns1:Header>{ $header/@* , $header/node() }</ns1:Header>
            <ns1:Body>{ $body/@* , $body/node() }</ns1:Body>
            <ns1:Fault>{ $soapFault/@* , $soapFault/node() }</ns1:Fault>
            <ns2:endpoint>{ $outbound/@* , $outbound/node() }</ns2:endpoint>
        </ns0:Audit>
};

declare variable $header as element(ns1:Header)? external;
declare variable $body as element(ns1:Body)? external;
declare variable $outbound as element(ns2:endpoint)? external;
declare variable $soapFault as element(ns1:Fault)? external;

xf:AuditError($header,
    $body,
    $outbound,
    $soapFault)