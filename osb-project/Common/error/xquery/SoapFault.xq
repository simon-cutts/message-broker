xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$soapbody" element="soap-env:Body" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$osbfault" element="ctx:fault" location="../../../ServiceRepository/Osb/xsd/MessageContext.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$osbinbound" element="ctx:endpoint" location="../../../ServiceRepository/Osb/xsd/MessageContext.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$osboutbound" element="ctx:endpoint" location="../../../ServiceRepository/Osb/xsd/MessageContext.xsd" ::)
(:: pragma bea:global-element-return element="soap-env:Fault" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

(: Create a true SOAP Fault from OSB faults

   Author: Simon Cutts :)
   
declare namespace xf = "http://rubix.nl/common/Soap11Fault/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace ctx = "http://www.bea.com/wli/sb/context";
declare namespace tp = "http://www.bea.com/wli/sb/transports";
declare namespace http = "http://www.bea.com/wli/sb/transports/http";

declare function xf:SoapFault($soapbody as element(soap-env:Body)?,
	$osbfault as element(ctx:fault)?,
	$osbinbound as element(ctx:endpoint)?,
	$osboutbound as element(ctx:endpoint)?,
	$guuid as xs:string?)
		as element(soap-env:Fault)
		{
		
		<soap-env:Fault>
			{
			if ($osbfault/ctx:errorCode="BEA-382505") then 
				<faultcode xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/">soapenv:Client</faultcode>
			else 
				<faultcode xmlns:soap-env="http://schemas.xmlsoap.org/soap/envelope/">soapenv:Server</faultcode>
			}
			{
			if ($soapbody/soap-env:Fault) then 
				<faultstring>{$soapbody/soap-env:Fault/faultstring/text()}</faultstring>
			else 
				<faultstring>Error in operation: {$osbinbound/ctx:service/ctx:operation/text()}</faultstring>
			}
			{
			if ($osboutbound/ctx:transport/ctx:uri) then 
				<faultactor>{$osboutbound/ctx:transport/ctx:uri/text()}</faultactor>
			else 
				<faultactor>{fn:concat($osbinbound/ctx:transport/ctx:request/tp:headers/http:Host,$osbinbound/ctx:transport/ctx:uri)}</faultactor>
			}
			<detail>
				<CorrelationId>{ $guuid }</CorrelationId>
				{
				if ($soapbody/soap-env:Fault) then 
					<business>{$soapbody/soap-env:Fault/detail}</business>
				else 
					<business/>
				}
				<runtime>{$osbfault}</runtime>
			</detail>
		</soap-env:Fault>

};

declare variable $soapbody as element(soap-env:Body)? external;
declare variable $osbfault as element(ctx:fault)? external;
declare variable $osbinbound as element(ctx:endpoint)? external;
declare variable $osboutbound as element(ctx:endpoint)? external;
declare variable $guuid as xs:string? external;

xf:SoapFault($soapbody,
	$osbfault,
	$osbinbound,
	$osboutbound,
	$guuid)