(:: pragma bea:global-element-parameter parameter="$body" element="ns0:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$header" element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Envelope" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

(: Build an audit message by reconsructing SOAP body and header into a SOAP envelope. This XQuery
   will only work if an Header is present in the SOAP header
   
   Author: Simon Cutts :)

declare namespace ns0 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns1 = "http://open.ac.uk/header/";
declare namespace xf = "http://tempuri.org/Common/resource/xquery/AuditMessage/";

(: Replace an existing audit event with $auditEvent :)
declare function xf:ReplaceAudit($element as element(*),
	$auditEvent as xs:string)
    as element(*) {
  		if ($element/self::AuditEvent)
		then <AuditEvent> {$auditEvent} </AuditEvent>
		else element {node-name($element)}  
		             {$element/@*, 
		              for $child in $element/node()  
		              return if ($child instance of element())  
		                     then xf:ReplaceAudit($child, $auditEvent)  
		                     else $child  
		             }  
};

(: Build up the audit messaage within an SOAP envelope:)
declare function xf:AuditMessage($body as element(ns0:Body),
    $header as element(ns0:Header),
    $auditEvent as xs:string)
    as element(ns0:Envelope) {   
    	<ns0:Envelope>
            <ns0:Header>
            	{ $header/@* ,xf:ReplaceAudit($header/*, $auditEvent) }
            </ns0:Header>
            <ns0:Body>
            	{ $body/@* , $body/node() }
            </ns0:Body>
        </ns0:Envelope>
};

declare variable $body as element(ns0:Body) external;
declare variable $header as element(ns0:Header) external;
declare variable $auditEvent as xs:string external;

xf:AuditMessage($body,
    $header,
    $auditEvent)