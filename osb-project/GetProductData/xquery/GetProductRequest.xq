(:: pragma bea:global-element-parameter parameter="$getProductDataRequest" element="ns1:GetProductDataRequest" location="../../ServiceRepository/Product/GetProductData/xsd/GetProductData.0.1.xsd" ::)
(:: pragma bea:global-element-return element="ns3:GetProductRequest" location="../../ServiceRepository/Product/GetProduct/xsd/GetProduct.0.7.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/Product/GetProductData";
declare namespace ns3 = "http://open.ac.uk/Product/GetProduct";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/GetProductData/xquery/GetProductRequest/";

declare function xf:GetProductRequest($getProductDataRequest as element(ns1:GetProductDataRequest))
    as element(ns3:GetProductRequest) {
        <ns3:GetProductRequest>
            {
                let $RequestHeader := $getProductDataRequest/ns1:RequestHeader
                return
                    <ns3:RequestHeader>
                        <ns0:id>{ data($RequestHeader/ns0:id) }</ns0:id>
                        {
                            for $source in $RequestHeader/ns0:source
                            return
                                <ns0:source>{ data($source) }</ns0:source>
                        }
                        {
                            for $user in $RequestHeader/ns0:user
                            return
                                <ns0:user>{ $user/@* , $user/node() }</ns0:user>
                        }
                    </ns3:RequestHeader>
            }
            {
                for $RequestedProduct in $getProductDataRequest/ns1:RequestedProduct
                return
                    <ns3:RequestedProduct>
                        {
                            for $productId in $RequestedProduct/ns1:productId
                            return
                                <ns3:productId>{ data($productId) }</ns3:productId>
                        }
                        {
                            for $productType in $RequestedProduct/ns1:productType
                            return
                                <ns3:productType>{ data($productType) }</ns3:productType>
                        }
                        {
                            for $productCode in $RequestedProduct/ns1:productCode
                            return
                                <ns3:productCode>{ data($productCode) }</ns3:productCode>
                        }
                    </ns3:RequestedProduct>
            }
        </ns3:GetProductRequest>
};

declare variable $getProductDataRequest as element(ns1:GetProductDataRequest) external;

xf:GetProductRequest($getProductDataRequest)
