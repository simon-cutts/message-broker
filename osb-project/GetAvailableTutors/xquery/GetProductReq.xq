(:: pragma bea:global-element-parameter parameter="$getAvailableTutorByIdRequest" element="ns2:GetAvailableTutorByIdRequest" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns3:GetProductRequest" location="../../ServiceRepository/Product/GetProduct/xsd/GetProduct.0.6.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/soa/Student/GetAvailableTutors";
declare namespace ns1 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/Product/GetProduct";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/GetAvailableTutors/xquery/GetProductReq/";

declare function xf:GetProductReq($getAvailableTutorByIdRequest as element(ns2:GetAvailableTutorByIdRequest))
    as element(ns3:GetProductRequest) {
        <ns3:GetProductRequest>
            <ns3:RequestHeader>
                <ns0:id>{ data($getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:id) }</ns0:id>
                {
                    for $source in $getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:source
                    return
                        <ns0:source>{ data($source) }</ns0:source>
                }
                {
                    for $user in $getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:user
                    return
                        <ns0:user>{ $user/@* , $user/node() }</ns0:user>
                }
            </ns3:RequestHeader>
            <ns3:RequestedProduct>
                <ns3:productId>{ data($getAvailableTutorByIdRequest/ns2:GetAvailableTutor/ns2:productId) }</ns3:productId>
               
              (::  <ns3:effectiveDate>{ substring(xs:string(fn:current-date()),1,10) }</ns3:effectiveDate> ::)
            </ns3:RequestedProduct>
        </ns3:GetProductRequest>
};

declare variable $getAvailableTutorByIdRequest as element(ns2:GetAvailableTutorByIdRequest) external;

xf:GetProductReq($getAvailableTutorByIdRequest)
