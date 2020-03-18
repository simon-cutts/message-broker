(:: pragma bea:global-element-parameter parameter="$retrieveListOfValuesResponse" element="ns2:RetrieveListOfValuesResponse" location="../../ServiceRepository/Contact/OUVoiceListOfValues/wsdl/OUVoiceListOfValues.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:GetCRMActivityListResponse" location="../../ServiceRepository/Contact/GetCRMActivityList/xsd/GetCRMActivityList.0.2.xsd" ::)

declare namespace ns2 = "http://www.open.ac.uk/voice/webservices/OUVoiceListOfValuesWS";
declare namespace ns1 = "http://open.ac.uk/Contact/GetCRMActivityList";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetCRMActivityList/xquery/GetCRMActivityListRes/";

declare function xf:GetCRMActivityListRes($id as xs:string,
    $retrieveListOfValuesResponse as element(ns2:RetrieveListOfValuesResponse))
    as element(ns1:GetCRMActivityListResponse) {
        <ns1:GetCRMActivityListResponse>
            <ns1:ResponseHeader>
                <ns3:id>{ $id }</ns3:id>
            </ns1:ResponseHeader>
            <ns1:Activities>
                {
                    for $ListOfValuesDetails in $retrieveListOfValuesResponse/ns2:RetrieveListOfValuesResult/ns2:ListOfValues/ns2:ListOfValuesDetails
                    return
                        <ns1:Type>
                            <ns1:ActivityType>{ data($ListOfValuesDetails/ns2:DisplayValue) }</ns1:ActivityType>
                            {
                                for $ListOfValuesDetails0 in $ListOfValuesDetails/ns2:ListOfValuesChild/ns2:ListOfValuesDetails
                                where ((fn:number(data($ListOfValuesDetails0/ns2:Order)) > 3000.0
                                                        or fn:number(data($ListOfValuesDetails0/ns2:Order)) < 2000.0)
                                                       or fn:string-length(data($ListOfValuesDetails0/ns2:Order)) = 0)
                                return
                                    <ns1:SRArea>
                                        <ns1:SRArea>{ data($ListOfValuesDetails0/ns2:DisplayValue) }</ns1:SRArea>
                                        <ns1:SRSubArea>
                                            {
                                                for $ListOfValuesDetails1 in $ListOfValuesDetails0/ns2:ListOfValuesChild/ns2:ListOfValuesDetails
                                                return
                                                    <ns1:SRSubArea>{ data($ListOfValuesDetails1/ns2:DisplayValue) }</ns1:SRSubArea>
                                            }
                                        </ns1:SRSubArea>
                                    </ns1:SRArea>
                            }
                        </ns1:Type>
                }
            </ns1:Activities>
        </ns1:GetCRMActivityListResponse>
};

declare variable $id as xs:string external;
declare variable $retrieveListOfValuesResponse as element(ns2:RetrieveListOfValuesResponse) external;

xf:GetCRMActivityListRes($id,
    $retrieveListOfValuesResponse)