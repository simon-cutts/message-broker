(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:VerifyContactRequest" location="../../ServiceRepository/Contact/VerifyContact/xsd/VerifyContact.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://open.ac.uk/Contact/VerifyContact";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/VerifyContactReq/";

declare function xf:VerifyContactReq($createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ns0:VerifyContactRequest) {
        <ns0:VerifyContactRequest>
            {
                let $RequestHeader := $createCustomerProspectRequest/ns3:RequestHeader
                return
                    <ns0:RequestHeader>
                        <ns1:id>{ data($RequestHeader/ns1:id) }</ns1:id>
                    </ns0:RequestHeader>
            }
            <ns0:ContactDetails>
                {
                    for $Initials in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Initials
                    return
                            <ns0:Initials>{ data($Initials) }</ns0:Initials>
                }
                <ns0:Forename>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Forename) }</ns0:Forename>
                <ns0:Surname>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Surname) }</ns0:Surname>
                <ns0:Email>{ data(lower-case($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Email)) }</ns0:Email>
                {
                    for $AddressDetails in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails
                    return
                        <ns0:AddressDetails>
                            <ns0:HouseNameOrNumber>{ data($AddressDetails/ns3:HouseNameOrNumber) }</ns0:HouseNameOrNumber>
                            {
                                for $Line2 in $AddressDetails/ns3:Line2
                                return
                                    <ns0:Line2>{ data($Line2) }</ns0:Line2>
                            }
                            {
                                for $Line3 in $AddressDetails/ns3:Line3
                                return
                                    <ns0:Line3>{ data($Line3) }</ns0:Line3>
                            }
                            <ns0:TownOrCity>{ data($AddressDetails/ns3:TownOrCity) }</ns0:TownOrCity>
                            {
                                for $County in $AddressDetails/ns3:County
                                return
                                    <ns0:County>{ data($County) }</ns0:County>
                            }
                            {
                                for $Postcode in $AddressDetails/ns3:Postcode
                                return
                                     <ns0:Postcode>{ data($Postcode) }</ns0:Postcode>
                            }
                           
                            <ns0:Country>{ data($AddressDetails/ns3:Country) }</ns0:Country>
                        </ns0:AddressDetails>
                }
                {
                    for $BirthDate in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:BirthDate
                    return
                        <ns0:BirthDate>{ data($BirthDate) }</ns0:BirthDate>
                }
            </ns0:ContactDetails>
        </ns0:VerifyContactRequest>
};

declare variable $createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:VerifyContactReq($createCustomerProspectRequest)
