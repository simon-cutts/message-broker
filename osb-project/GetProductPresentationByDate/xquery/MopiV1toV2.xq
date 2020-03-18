(:: pragma bea:global-element-parameter parameter="$getProductPresentationByMopiResponse" element="ns1:GetProductPresentationByMopiResponse" location="../../ServiceRepository/Product/GetProductPresentationByDate/wsdl/ProductPresentation.xsd" ::)
(:: pragma bea:global-element-return element="ns1:GetProductPresentationByMopiResponse" location="../../ServiceRepository/Product/GetProductPresentationByDate/wsdl/ProductPresentationV2.0.xsd" ::)

declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "http://open.ac.uk/Product/ProductPresentation";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetProductPresentationByDate/xquery/MopiV1toV2/";

declare function xf:MopiV1toV2($getProductPresentationByMopiResponse as element(ns1:GetProductPresentationByMopiResponse))
    as element(ns1:GetProductPresentationByMopiResponse) {
        <ns1:GetProductPresentationByMopiResponse>
            <ns1:ResponseHeader>
                <ns3:id>{ data($getProductPresentationByMopiResponse/ns1:ResponseHeader/ns3:id) }</ns3:id>
                {
                    for $Fault in $getProductPresentationByMopiResponse/ns1:ResponseHeader/ns3:fault/ns0:Fault
                    return
                        <ns3:fault/>
                }
            </ns1:ResponseHeader>
            <ns1:Products>
                <ns1:Product>
                    {
                        for $GeographicalArea in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:GeographicalArea
                        return
                            <ns1:GeographicalArea>{ $GeographicalArea/@* , $GeographicalArea/node() }</ns1:GeographicalArea>
                    }
                    {
                        for $Module in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:Module
                        return
                            <ns1:Module>{ $Module/@* , $Module/node() }</ns1:Module>
                    }
                    <ns1:ProductPresentation>
                        {
                            for $ModulePresentation in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:ProductPresentation/ns1:ModulePresentation
                            return
                                <ns1:ModulePresentation>{ $ModulePresentation/@* , $ModulePresentation/node() }</ns1:ModulePresentation>
                        }
                        {
                            for $Presentation in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:ProductPresentation/ns1:Presentation
                            return
                                <ns1:Presentation>{ $Presentation/@* , $Presentation/node() }</ns1:Presentation>
                        }
                        <ns1:cPGStudentNorm>20</ns1:cPGStudentNorm>
                        {
                            for $presentationId in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:ProductPresentation/ns1:presentationId
                            return
                                <ns1:presentationId>{ data($presentationId) }</ns1:presentationId>
                        }
                    </ns1:ProductPresentation>
                    {
                        for $productCode in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:productCode
                        return
                            <ns1:productCode>{ data($productCode) }</ns1:productCode>
                    }
                    {
                        for $productId in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:productId
                        return
                            <ns1:productId>{ data($productId) }</ns1:productId>
                    }
                    {
                        for $productStatus in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:productStatus
                        return
                            <ns1:productStatus>{ data($productStatus) }</ns1:productStatus>
                    }
                    {
                        for $productTitle in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:productTitle
                        return
                            <ns1:productTitle>{ data($productTitle) }</ns1:productTitle>
                    }
                    {
                        for $productType in $getProductPresentationByMopiResponse/ns1:Products/ns1:Product[1]/ns1:productType
                        return
                            <ns1:productType>{ data($productType) }</ns1:productType>
                    }
                </ns1:Product>
            </ns1:Products>
        </ns1:GetProductPresentationByMopiResponse>
};

declare variable $getProductPresentationByMopiResponse as element(ns1:GetProductPresentationByMopiResponse) external;

xf:MopiV1toV2($getProductPresentationByMopiResponse)
