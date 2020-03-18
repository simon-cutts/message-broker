(:: pragma  parameter="$items" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:StudentModuleEvent" location="../../ServiceRepository/Student/StudentModuleEvent/xsd/StudentModuleEvent.1.0.xsd" ::)

declare namespace ns0 = "http://open.ac.uk/Student/StudentModuleEvent";
declare namespace xf = "http://tempuri.org/StudentModuleEvent/xquery/StudentModuleEvent/";

declare function xf:StudentModuleEvent($items as element(*),
    $productId as xs:string,
    $presentationId as xs:string)
    as element(ns0:StudentModuleEvent) {
        <ns0:StudentModuleEvent>
            <ns0:personalId>{ $items/Item[1]/text() }</ns0:personalId>
            <ns0:productCode>{ $items/Item[2]/text() }</ns0:productCode>
            <ns0:statusChangeDate>{ replace(fn-bea:trim-left($items/Item[4]/text()),' ','T') }</ns0:statusChangeDate>
            <ns0:statusCode>{ $items/Item[5]/text() }</ns0:statusCode>
            <ns0:presentationCode>{ $items/Item[3]/text() }</ns0:presentationCode>
            <ns0:productId>{ $productId }</ns0:productId>
            <ns0:presentationId>{ $presentationId }</ns0:presentationId>
        </ns0:StudentModuleEvent>
};

declare variable $items as element(*) external;
declare variable $productId as xs:string external;
declare variable $presentationId as xs:string external;

xf:StudentModuleEvent($items,
    $productId,
    $presentationId)
