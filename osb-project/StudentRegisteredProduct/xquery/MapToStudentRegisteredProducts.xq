xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$map" element="ns1:Map" location="../../Common/rest/xsd/Map.xsd" ::)
(:: pragma bea:global-element-return element="ns0:StudentRegisteredProducts" location="../../ServiceRepository/Student/StudentRegisteredProduct/wsdl/StudentRegisteredProduct.wsdl" ::)

(: Populates StudentRegisteredProducts from the Map type
   
   Author: Simon Cutts :)
   
declare namespace xf = "http://tempuri.org/StudentRegisteredProduct/xquery/MapToStudentRegisteredProducts/";
declare namespace ns1 = "http://open.ac.uk/rest/Map/";
declare namespace ns0 = "http://www.open.ac.uk/OU.VantageSST";

declare function xf:MapToStudentRegisteredProducts($map as element(ns1:Map))
    as element(ns0:StudentRegisteredProducts) {
        <ns0:StudentRegisteredProducts>
             {for $data in $map/Entry[Key='sPersonalId']
              return
        		<ns0:sPersonalId>{ $data/Value/text() }</ns0:sPersonalId>
             }
             {for $data in $map/Entry[Key='sUserId']
              return
		    	<ns0:sUserId>{ $data/Value/text() }</ns0:sUserId>
		    }
		</ns0:StudentRegisteredProducts>
};

declare variable $map as element(ns1:Map) external;

xf:MapToStudentRegisteredProducts($map)
