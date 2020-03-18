
declare namespace xf = "http://tempuri.org/Common/error/xquery/LogError/";

declare function xf:LogError($tier as xs:string,
    $serviceName as xs:string,
    $correlationId as xs:string)
    as xs:string {
        concat('OSB tier ',$tier,' service ',$serviceName,' recorded an error for message correlation Id: ',$correlationId)
};

declare variable $tier as xs:string external;
declare variable $serviceName as xs:string external;
declare variable $correlationId as xs:string external;

xf:LogError($tier,
    $serviceName,
    $correlationId)
