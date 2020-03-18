(:: pragma bea:global-element-parameter parameter="$getProductResponse" element="ns3:GetProductResponse" location="../../ServiceRepository/Product/GetProduct/xsd/GetProduct.0.7.xsd" ::)
(:: pragma bea:global-element-return element="ns1:GetProductDataResponse" location="../../ServiceRepository/Product/GetProductData/xsd/GetProductData.0.2.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns1 = "http://open.ac.uk/Product/GetProductData";
declare namespace ns3 = "http://open.ac.uk/Product/GetProduct";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetProductData/xquery/GetProductDataResponse.0.2/";

declare function xf:GetProductDataResponse($getProductResponse as element(ns3:GetProductResponse))
    as element(ns1:GetProductDataResponse) {
        <ns1:GetProductDataResponse xmlns="http://open.ac.uk/Product/GetProductData">
            {
                let $ResponseHeader := $getProductResponse/ns3:ResponseHeader
                return
                    <ns1:ResponseHeader>
                        <ns2:id>{ data($ResponseHeader/ns2:id) }</ns2:id>
                        {
                            for $fault in $ResponseHeader/ns2:fault
                            return
                                <ns2:fault>{ $fault/@* , $fault/node() }</ns2:fault>
                        }
                    </ns1:ResponseHeader>
            }
            {
                for $Product in $getProductResponse/ns3:Product
                return
                    <ns1:Product>
                        <ns1:productId>{ data($Product/ns3:productId) }</ns1:productId>
                        <ns1:productType>{ xf:decodeProductType(data($Product/ns3:productType)) }</ns1:productType>
                        <ns1:productCode>{ data($Product/ns3:productCode) }</ns1:productCode>
                        <ns1:productTitle>{ data($Product/ns3:productTitle) }</ns1:productTitle>
                        {
                            for $ModulePresentation in $Product/ns3:ModulePresentation
                            return
                                <ns1:ProductPresentation>
                                    <ns1:presentationID>{ data($ModulePresentation/ns3:presId) }</ns1:presentationID>
                                    <ns1:Presentation>
                                        <ns1:ModuleTypePresentation>
                                            <ns1:presentationStartYear>{ xs:int(data($ModulePresentation/ns3:presStartYear)) }</ns1:presentationStartYear>
                                            <ns1:presentationStartMonth>{ xs:int(data($ModulePresentation/ns3:presStartMonth)) }</ns1:presentationStartMonth>
                                            <ns1:mopi>{ data($ModulePresentation/ns3:mopi) }</ns1:mopi>
                                        </ns1:ModuleTypePresentation>
                                    </ns1:Presentation>
                                </ns1:ProductPresentation>
                        }
                                <ns1:OrganisationUnit>
                        {
                            for $OrganisationUnit in $Product/ns3:OrganisationUnit/ns3:organisationUnitId
                            return
                            	<ns1:organisationUnitID>{ data($OrganisationUnit) }</ns1:organisationUnitID>
                        }
                                </ns1:OrganisationUnit>
                    </ns1:Product>
            }
        </ns1:GetProductDataResponse>
};

(: Convert the productType integer into a meaningful string :)
declare function xf:decodeProductType($typeId as xs:string)
    as xs:string {
    
    if ($typeId = '0') 
    	then "Unknown"
    else if ($typeId = '1') 
    	then "RegisterableQualification"
    else if ($typeId = '2') 
    	then "AwardableQualification"
    else if ($typeId = '3') 
    	then "Module"
    else if ($typeId = '4') 
    	then "Stage"
    else if ($typeId = '5') 
    	then "Specialism"
    else if ($typeId = '6') 
    	then "StructureEdition"
    else if ($typeId = '7') 
    	then "ModuleGroup"
    else if ($typeId = '8') 
    	then "ModuleVariant"
    else 
	"ChoiceGroup"    
};

declare variable $getProductResponse as element(ns3:GetProductResponse) external;

xf:GetProductDataResponse($getProductResponse)
