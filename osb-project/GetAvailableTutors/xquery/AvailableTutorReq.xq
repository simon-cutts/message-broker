(:: pragma bea:global-element-parameter parameter="$getProductResponse" element="ns3:GetProductResponse" location="../../ServiceRepository/Product/GetProduct/xsd/GetProduct.0.7.xsd" ::)
(:: pragma bea:global-element-return element="ns2:GetAvailableTutor" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/soa/Student/GetAvailableTutors";
declare namespace ns1 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns3 = "http://open.ac.uk/Product/GetProduct";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetAvailableTutors/xquery/availableTutorReq/";

declare function xf:availableTutorReq($getProductResponse as element(ns3:GetProductResponse),
    $presentationId as xs:string)
    as element(ns2:GetAvailableTutor) {
        <ns2:GetAvailableTutor>
            <ns2:moduleCode>{ data($getProductResponse/ns3:Product[1]/ns3:productCode) }</ns2:moduleCode>
            {
                        for $ModulePresentation in $getProductResponse/ns3:Product/ns3:ModulePresentation
                        where data($ModulePresentation/ns3:presId) = data($presentationId)
                        return
                            <ns2:presentationCode>{ fn:concat($ModulePresentation/ns3:presStartYear,$ModulePresentation/ns3:mopi)} </ns2:presentationCode>
                }
        </ns2:GetAvailableTutor>
};

declare variable $getProductResponse as element(ns3:GetProductResponse) external;
declare variable $presentationId as xs:string external;

xf:availableTutorReq($getProductResponse,
    $presentationId)
