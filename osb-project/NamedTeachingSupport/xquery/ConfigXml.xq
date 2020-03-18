xquery version "1.0" encoding "Cp1252";

(: Project specific configuraion XML with embedded XQuery

   Author: Simon Cutts :)

declare namespace xf = "http://tempuri.org/CommonConfig/resources/xquery/ConfigXml/";

declare function xf:Xml() as xs:string {
    '<?xml version="1.0" encoding="UTF-8"?>
    <Properties>

		<Map>
			<Key>audit</Key>
			<Value>true</Value>
			<Comment>Boolean allowed values: true, false. Used to indicate auditing is required</Comment>
		</Map>
		
		<Map>
			<Key>validate</Key>
			<Value>true</Value>
			<Comment>Boolean allowed values: true, false. Indicates message validation is required</Comment>
		</Map>
		
   </Properties>'
};

declare function xf:ConfigXml($key as xs:string)
    as xs:string {
 	
 	(: Read the XML, matching on key :)
	for $p in fn-bea:inlinedXML(xf:Xml())/Properties/Map
	where $p/Key = $key
    return $p/Value
};

declare variable $key as xs:string external;

xf:ConfigXml($key)