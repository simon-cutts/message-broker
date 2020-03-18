(:: pragma bea:global-element-parameter parameter="$header" element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$body" element="ns0:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Envelope" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

(: Build a SOAP envelope from SOAP header and SOAP body
   
   Author: Simon Cutts :)
   
declare namespace ns0 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace xf = "http://tempuri.org/OsbMessageDelay/xquery/SoapEnvelope/";

declare function xf:SoapEnvelope($header as element(ns0:Header),
    $body as element(ns0:Body))
    as element(ns0:Envelope) {
        <ns0:Envelope>
            <ns0:Header>{ $header/@* , $header/node() }</ns0:Header>
            <ns0:Body>{ $body/@* , $body/node() }</ns0:Body>
        </ns0:Envelope>
};

declare variable $header as element(ns0:Header) external;
declare variable $body as element(ns0:Body) external;

xf:SoapEnvelope($header,
    $body)