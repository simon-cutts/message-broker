(:: pragma bea:global-element-return element="ns0:Fault" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

declare namespace ns0 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace xf = "http://tempuri.org/Common/error/xquery/SoapFaultWrapsOuFault/";

(: Places an OU SOAPFaultMessage1.1 inside a w3c SOAP Fault. Optionally accepts $detail of
   anyType :)

declare function xf:SoapFaultWrapsOuFault($code as xs:string,
    $message as xs:string,
    $detail as element(*)?)
    as element(ns0:Fault) {
        <ns0:Fault>
        	<faultcode>soapenv:Client</faultcode>
            <faultstring>{ $message }</faultstring>
            <detail>
				<SOAPFaultMessage xmlns="http://open.ac.uk/schema/faults">
					<id/>
					<Fault>
						<faultcode>{ $code }</faultcode>
						<detail>{ $message }</detail>
					</Fault>
				</SOAPFaultMessage>
				{ $detail }
			</detail>
        </ns0:Fault>
};

declare variable $code as xs:string external;
declare variable $message as xs:string external;
declare variable $detail as element(*)? external;

xf:SoapFaultWrapsOuFault($code,
    $message,
    $detail)
