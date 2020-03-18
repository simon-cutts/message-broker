(:: pragma bea:global-element-parameter parameter="$map" element="ns0:Map" location="../../Common/rest/xsd/Map.xsd" ::)
(:: pragma bea:global-element-return element="ns3:GetProductListRequest" location="../../ServiceRepository/Product/GetProductList/xsd/GetProductList.0.6.xsd" ::)

(: Populates GetProductListRequest from the Map type
   
   Author: Simon Cutts :)
   
declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns3 = "http://open.ac.uk/Product/GetProductList";
declare namespace ns0 = "http://open.ac.uk/rest/Map/";
declare namespace xf = "http://tempuri.org/Curriculum/xquery/MapToGetProductList/";

declare function xf:MapToGetProductList($map as element(ns0:Map))
    as element(ns3:GetProductListRequest) {
        <ns3:GetProductListRequest>
            <ns3:RequestDetails>
	            {for $data in $map/Entry[Key='productType']
	             return
                <ns3:productType>{ $data/Value/text()}</ns3:productType>
                }
	            {for $data in $map/Entry[Key='productStatus']
	             return
                <ns3:productStatus>{ $data/Value/text() }</ns3:productStatus>
                }
	            {for $data in $map/Entry[Key='organisationUnitId']
	             return
                <ns3:organisationUnitId>{ $data/Value/text() }</ns3:organisationUnitId>
                }
            </ns3:RequestDetails>
        </ns3:GetProductListRequest>
};

declare variable $map as element(ns0:Map) external;

xf:MapToGetProductList($map)
