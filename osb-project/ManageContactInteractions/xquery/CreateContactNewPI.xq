(:: pragma bea:global-element-parameter parameter="$oUGenerateNextPersonalIdResponse" element="ns1:OUGenerateNextPersonalIdResponse" location="../../ServiceRepository/Contact/NextNumberGenWS/wsdl/NextNumberGenWS.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:VerifyContactResponse" location="../../ServiceRepository/Contact/VerifyContact/xsd/VerifyContact.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/Contact/VerifyContact";
declare namespace ns1 = "http://csintra6.open.ac.uk/NextNumberGenWS/";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/CreateCustomerNewPI/";

declare function xf:CreateCustomerNewPI($id as xs:string,
    $oUGenerateNextPersonalIdResponse as element(ns1:OUGenerateNextPersonalIdResponse))
    as element(ns2:VerifyContactResponse) {
        <ns2:VerifyContactResponse>
            <ns2:ResponseHeader>
                <ns3:id>{ $id }</ns3:id>
            </ns2:ResponseHeader>
            <ns2:ContactResult>
                <ns2:Success>Success</ns2:Success>
                <ns2:MatchCode>None</ns2:MatchCode>
                <ns2:CustomerPI>{ data($oUGenerateNextPersonalIdResponse/ns1:strNewPersonalId) }</ns2:CustomerPI>
            </ns2:ContactResult>
        </ns2:VerifyContactResponse>
};

declare variable $id as xs:string external;
declare variable $oUGenerateNextPersonalIdResponse as element(ns1:OUGenerateNextPersonalIdResponse) external;

xf:CreateCustomerNewPI($id,
    $oUGenerateNextPersonalIdResponse)
