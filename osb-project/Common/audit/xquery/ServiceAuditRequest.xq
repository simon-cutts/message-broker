(:: pragma bea:global-element-parameter parameter="$requestBody" element="ns1:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseBody" element="ns1:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ServiceAudit" location="../../../ServiceRepository/ouosb/xsd/ServiceAudit.xsd" ::)

declare namespace ns1 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ns0 = "http://open.ac.uk/audit/service";
declare namespace xf = "http://tempuri.org/Common/audit/xquery/ServiceAudit/";

declare function xf:ServiceAudit($requestBody as element(*)?,
    $responseBody as element(*)?,
    $requestHeader as element(*)?,
    $responseHeader as element(*)?,
    $correlationId as xs:string?,
    $event as xs:string)
    as element(ns0:ServiceAudit) {
        <ns0:ServiceAudit>
            <ns0:CorrelationId>{ $correlationId }</ns0:CorrelationId>
            <ns0:AuditEvent>{ $event }</ns0:AuditEvent>
            <ns0:Request>
                <ns1:Header>{ $requestHeader }</ns1:Header>
                <ns1:Body>{ $requestBody }</ns1:Body>
            </ns0:Request>
            <ns0:Response>
                <ns1:Header>{ $responseHeader }</ns1:Header>
                <ns1:Body>{ $responseBody }</ns1:Body>
            </ns0:Response>
        </ns0:ServiceAudit>
};

declare variable $requestBody as element(*) external;
declare variable $responseBody as element(*)? external;
declare variable $requestHeader as element(*)? external;
declare variable $responseHeader as element(*)? external;
declare variable $correlationId as xs:string? external;
declare variable $event as xs:string? external;

xf:ServiceAudit($requestBody,
    $responseBody,
    $requestHeader,
    $responseHeader,
    $correlationId,
    $event)