(:: pragma bea:global-element-parameter parameter="$getDuplicateContactsResponse" element="ns1:GetDuplicateContactsResponse" location="../../ServiceRepository/Contact/OUVoiceGetContact/wsdl/OUVoiceGetContactV2.0.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:VerifyContactResponse" location="../../ServiceRepository/Contact/VerifyContact/xsd/VerifyContact.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/Contact/VerifyContact";
declare namespace ns1 = "http://www.open.ac.uk/voice/webservices/ouvoicegetcontactws";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/VerifyContactRes/";

declare function xf:VerifyContactRes($getDuplicateContactsResponse as element(ns1:GetDuplicateContactsResponse),
    $id as xs:string)
    as element(ns2:VerifyContactResponse) {
        <ns2:VerifyContactResponse>
            <ns2:ResponseHeader>
                <ns3:id>{ $id }</ns3:id>
            </ns2:ResponseHeader>
            <ns2:ContactResult>
                <ns2:Success>Success</ns2:Success>
                <ns2:MatchCode>{ data($getDuplicateContactsResponse/ns1:GetDuplicateContactsResult/ns1:MatchCode) }</ns2:MatchCode>
                {
                    for $GetContactOutputArgDetails in $getDuplicateContactsResponse/ns1:GetDuplicateContactsResult/ns1:Contacts/ns1:GetContactOutputArgDetails
                    return
                        <ns2:CustomerPI>{ data($GetContactOutputArgDetails/ns1:PersonalID) }</ns2:CustomerPI>
                }
            </ns2:ContactResult>
        </ns2:VerifyContactResponse>
};

declare variable $getDuplicateContactsResponse as element(ns1:GetDuplicateContactsResponse) external;
declare variable $id as xs:string external;

xf:VerifyContactRes($getDuplicateContactsResponse,
    $id)
