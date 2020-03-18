(:: pragma bea:global-element-parameter parameter="$metadata" element="ns1:Metadata" location="../../../ServiceRepository/Event/xsd/Event.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Header" location="../../../ServiceRepository/ouosb/xsd/Header.xsd" ::)

declare namespace ns1 = "http://open.ac.uk/event/";
declare namespace ns0 = "http://open.ac.uk/header/";
declare namespace xf = "http://tempuri.org/Event/xquery/GetMetadata/";

declare function xf:GetMetadata($metadata as element(ns1:Metadata))
    as element(ns0:Header) {
        <ns0:Header>
            <CorrelationId>{ data($metadata/CorrelationId) }</CorrelationId>
            <AuditTime>{ data($metadata/CreateTime) }</AuditTime>
        </ns0:Header>
};

declare variable $metadata as element(ns1:Metadata) external;

xf:GetMetadata($metadata)