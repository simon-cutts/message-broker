(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:UpsertContact" location="../../ServiceRepository/Contact/OUVoiceUpsertContact/wsdl/OUVoiceUpsertContact.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/OUVoiceUpsertContactWS";
declare namespace xf = "http://tempuri.org/OUVoiceUpsertContact/xquery/UpsertContact/";

declare function xf:UpsertContactStudent($createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ns0:UpsertContact) {
        <ns0:UpsertContact>
            <ns0:Contacts>
                <ns0:PersonalId>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:CustomerPI[1]) }</ns0:PersonalId>
                <ns0:Title>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Title) }</ns0:Title>
                {
                    for $Oucu in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Oucu
                    return
                        <ns0:OUComputerUserName>{ data($Oucu) }</ns0:OUComputerUserName>
                }
                <ns0:EmailStatus>G</ns0:EmailStatus>
                <ns0:EmailingPreferred>1</ns0:EmailingPreferred>
                {
                    for $MarketingSubjectOfInterest in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingSubjectOfInterest
                    return
                        <ns0:MarketingSubjectOfInterest>{ data($MarketingSubjectOfInterest) }</ns0:MarketingSubjectOfInterest>
                }
                {
                    for $StudyStartTimeframe in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:StudyStartTimeframe
                    return
                        <ns0:StudyStartTimeframe>{ data($StudyStartTimeframe) }</ns0:StudyStartTimeframe>
                }
                {
                    for $MarketingOccupationStatus in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingOccupationStatus
                    return
                        <ns0:MarketingOccupationStatus>{ data($MarketingOccupationStatus) }</ns0:MarketingOccupationStatus>
                }
                {
                    for $MarketingAttainedStudyLevel in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingAttainedStudyLevel
                    return
                        <ns0:MarketingAttainedStudyLevel>{ data($MarketingAttainedStudyLevel) }</ns0:MarketingAttainedStudyLevel>
                }
                {
                    for $ProspectIntendsDegree in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectIntendsDegree
                    return
                        <ns0:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns0:ProspectIntendsDegree>
                }
            </ns0:Contacts>
        </ns0:UpsertContact>
};

declare variable $createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:UpsertContactStudent($createCustomerProspectRequest)
