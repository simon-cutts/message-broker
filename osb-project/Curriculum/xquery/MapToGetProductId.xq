(:: pragma bea:global-element-parameter parameter="$map" element="ns1:Map" location="../../Common/rest/xsd/Map.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetProductIdRequest" location="../../ServiceRepository/Product/getProductId/xsd/GetProductId.0.3.xsd" ::)

(: Populates GetProductIdRequest from the Map type
   
   Author: Simon Cutts :)
   
declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/rest/Map/";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://open.ac.uk/Product/GetProductId";
declare namespace xf = "http://tempuri.org/Curriculum/xquery/MapToGetProductId/";

declare function xf:MapToGetProductId($map as element(ns1:Map))
    as element(ns0:GetProductIdRequest) {
        <ns0:GetProductIdRequest>
            <ns0:RequestDetails>
            {for $data in $map/Entry[Key='productType']
             return
                <ns0:productType>{ $data/Value/text() }</ns0:productType>
			}
            {for $data in $map/Entry[Key='productCode']
             return
                <ns0:productCode>{ $data/Value/text() }</ns0:productCode>
			}
            </ns0:RequestDetails>
        </ns0:GetProductIdRequest>
};

declare variable $map as element(ns1:Map) external;

xf:MapToGetProductId($map)
