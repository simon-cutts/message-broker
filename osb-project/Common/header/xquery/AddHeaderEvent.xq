(:: pragma bea:global-element-parameter parameter="$ouHeader" element="ns0:Header" location="../../../ServiceRepository/ouosb/xsd/Header.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Header" location="../../../ServiceRepository/ouosb/xsd/Header.xsd" ::)

declare namespace ns0 = "http://open.ac.uk/header/";
declare namespace xf = "http://tempuri.org/Common/header/xquery/AddHeaderEvent/";

declare function xf:AddHeaderEvent($event as xs:string)
    as element(ns0:Header) {
        <ns0:Header>
            <CorrelationId/>
            <AuditEvent>{ $event }</AuditEvent>
        </ns0:Header>
};

declare variable $event as xs:string external;

xf:AddHeaderEvent($event)