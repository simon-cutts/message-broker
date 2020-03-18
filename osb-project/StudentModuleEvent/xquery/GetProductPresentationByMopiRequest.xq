(:: pragma bea:global-element-return element="ns1:GetProductPresentationByMopiRequest" location="../../ServiceRepository/Product/GetProductPresentationByDate/wsdl/ProductPresentation.xsd" ::)

declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "http://open.ac.uk/Product/ProductPresentation";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://schemas.datacontract.org/2004/07/OU.Curriculum.GetProductPresentationByDateService.V0_4.MessageContracts";
declare namespace xf = "http://tempuri.org/StudentModuleEvent/xquery/GetProductPresentationByMopiRequest/";

declare function xf:GetProductPresentationByMopiRequest($presentationCode as xs:string,
    $productCode as xs:string)
    as element(ns1:GetProductPresentationByMopiRequest) {
        <ns1:GetProductPresentationByMopiRequest>
            <ns1:RequestHeader>
                <ns1:id>OSB</ns1:id>
                <ns1:source>OSB</ns1:source>
            </ns1:RequestHeader>
            <ns1:RequestedProductMopi>
                <ns0:productCode>{ $productCode }</ns0:productCode>
                <ns0:productType>
                    <ns2:string>Module</ns2:string>
                </ns0:productType>
                <ns1:Mopi>{ $presentationCode }</ns1:Mopi>
            </ns1:RequestedProductMopi>
        </ns1:GetProductPresentationByMopiRequest>
};

declare variable $presentationCode as xs:string external;
declare variable $productCode as xs:string external;

xf:GetProductPresentationByMopiRequest($presentationCode,
    $productCode)
