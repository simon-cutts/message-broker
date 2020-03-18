(:: pragma bea:global-element-return element="ns0:Map" location="../xsd/Map.xsd" ::)

(: Extracts the HTTP query parameters and puts them into a Map
   
   Author: Simon Cutts :)
   
declare namespace ns0 = "http://open.ac.uk/rest/Map/";
declare namespace xf = "http://tempuri.org/Common/rest/xquery/HttpParametersToMap/";

declare function xf:HttpParametersToMap($queryParameters as xs:string)
    as element(ns0:Map) {
        <ns0:Map>
            {
          	for $nameValue in fn:tokenize($queryParameters,"&amp;")
          	return
	            <Entry>
	            	<Key>{ fn:substring-before($nameValue,'=') }</Key>
	                <Value>{ fn:substring-after($nameValue,'=') }</Value>
	            </Entry>
            }
        </ns0:Map>
};

declare variable $queryParameters as xs:string external;

xf:HttpParametersToMap($queryParameters)
