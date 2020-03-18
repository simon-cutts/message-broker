xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$header" element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

(: Add an Header with correlation Id, but no audit event to SOAP header, while keeping existing
   headers. If an Header is already present then do not add a new one, because we want to keep the
   correlation id
   
   Author: Simon Cutts :)
   
declare namespace ns0 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace tns = "http://open.ac.uk/header/";
declare namespace xf = "http://tempuri.org/Common/resource/xquery/AddHeader/";

declare function xf:AddHeader($header as element(ns0:Header))
    as element(ns0:Header) {
        if (exists($header/tns:Header)) then
	    	$header
	    else
		    <ns0:Header>
		    	{$header/*}
			    <tns:Header>
			    
			    	(: Beware! fn-bea:uuid() does not work in eclipse test console :)
					<CorrelationId>{ fn-bea:uuid() }</CorrelationId>
					<AuditEvent/>
					<AuditTime>{ fn:current-dateTime() }</AuditTime>
				</tns:Header>
		    </ns0:Header>
};

declare variable $header as element(ns0:Header) external;

xf:AddHeader($header)