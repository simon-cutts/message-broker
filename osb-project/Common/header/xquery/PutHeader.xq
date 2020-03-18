xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$header" element="tns:Header" location="../../../ServiceRepository/ouosb/xsd/Header.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$soapHeader" element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Header" location="../../../ServiceRepository/w3c/xsd/soap-envelope.xsd" ::)

declare namespace xf = "http://tempuri.org/Common/header/xquery/PutHeader/";
declare namespace ns0 = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace tns = "http://open.ac.uk/header/";

declare function xf:PutHeader($header as element(tns:Header),
    $soapHeader as element(ns0:Header))
    as element(ns0:Header) {
        if (exists($soapHeader/tns:Header)) then
	    	$soapHeader
	    else
		    <ns0:Header>
		    	{$soapHeader/*}
			    {$header}
		    </ns0:Header>
};

declare variable $header as element(tns:Header) external;
declare variable $soapHeader as element(ns0:Header) external;

xf:PutHeader($header,
    $soapHeader)
