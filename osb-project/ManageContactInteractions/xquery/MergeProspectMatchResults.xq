(:: pragma bea:global-element-parameter parameter="$verifyContactResponse" element="ns1:VerifyContactResponse" location="../../ServiceRepository/Contact/VerifyContact/xsd/VerifyContact.1.0.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns5:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns5:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/Contact/VerifyContact";
declare namespace ns4 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace ns5 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/MergeProspectReqWithContactMatch/";

declare function xf:MergeProspectReqWithContactMatch($verifyContactResponse as element(ns1:VerifyContactResponse),
    $createCustomerProspectRequest as element(ns5:CreateCustomerProspectRequest))
    as element(ns5:CreateCustomerProspectRequest) {
        <ns5:CreateCustomerProspectRequest>
            <ns5:RequestHeader>{ $createCustomerProspectRequest/ns5:RequestHeader/@* , $createCustomerProspectRequest/ns5:RequestHeader/node() }</ns5:RequestHeader>
            {
                let $CustomerDetails := $createCustomerProspectRequest/ns5:CustomerDetails
                return
                    <ns5:CustomerDetails>
                        <ns5:Title>{ data($CustomerDetails/ns5:Title) }</ns5:Title>
                        {
                            for $Initials in $CustomerDetails/ns5:Initials
                            return
                            <ns5:Initials>{ data($Initials) }</ns5:Initials>
                        }
                        <ns5:Forename>{ data($CustomerDetails/ns5:Forename) }</ns5:Forename>
                        <ns5:Surname>{ data($CustomerDetails/ns5:Surname) }</ns5:Surname>
                        <ns5:Email>{ data(lower-case($CustomerDetails/ns5:Email)) }</ns5:Email>
                        {
                            for $PhoneNumber in $CustomerDetails/ns5:PhoneNumber
                            return
                                <ns5:PhoneNumber>{ data($PhoneNumber) }</ns5:PhoneNumber>
                        }
                        {
                            for $ReceiveSMS in $CustomerDetails/ns5:ReceiveSMS
                            return
                                <ns5:ReceiveSMS>{ data($ReceiveSMS) }</ns5:ReceiveSMS>
                        }
                        {
                            for $AddressDetails in $CustomerDetails/ns5:AddressDetails
                            return
                                <ns5:AddressDetails>{ $AddressDetails/@* , $AddressDetails/node() }</ns5:AddressDetails>
                        }
                        {
                            for $BirthDate in $CustomerDetails/ns5:BirthDate
                            return
                                <ns5:BirthDate>{ data($BirthDate) }</ns5:BirthDate>
                        }
                        {
                            for $SelectedCountry in $CustomerDetails/ns5:SelectedCountry
                            return
                                <ns5:SelectedCountry>{ data($SelectedCountry) }</ns5:SelectedCountry>
                        }
                        <ns5:CountryCode>{ data($CustomerDetails/ns5:CountryCode) }</ns5:CountryCode>
                        
                        {
                            for $ProspectIntendsDegree in $CustomerDetails/ns5:ProspectIntendsDegree
                            return
                                <ns5:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns5:ProspectIntendsDegree>
                        }
                        {
                            for $MarketingSubjectOfInterest in $CustomerDetails/ns5:MarketingSubjectOfInterest
                            return
                                <ns5:MarketingSubjectOfInterest>{ data($MarketingSubjectOfInterest) }</ns5:MarketingSubjectOfInterest>
                        }
                        
                        {
                            for $MarketingAttainedStudyLevel in $CustomerDetails/ns5:MarketingAttainedStudyLevel
                            return
                                <ns5:MarketingAttainedStudyLevel>{ data($MarketingAttainedStudyLevel) }</ns5:MarketingAttainedStudyLevel>
                        }
                        {
                            for $StudyStartTimeframe in $CustomerDetails/ns5:StudyStartTimeframe
                            return
                                <ns5:StudyStartTimeframe>{ data($StudyStartTimeframe) }</ns5:StudyStartTimeframe>
                        }
                        {
                            for $MarketingOccupationStatus in $CustomerDetails/ns5:MarketingOccupationStatus
                            return
                                <ns5:MarketingOccupationStatus>{ data($MarketingOccupationStatus) }</ns5:MarketingOccupationStatus>
                        }
                        {
                            for $PreferredCallbackTime in $CustomerDetails/ns5:PreferredCallbackTime
                            return
                                <ns5:PreferredCallbackTime>{ data($PreferredCallbackTime) }</ns5:PreferredCallbackTime>
                        }
						{
                            for $SubjectOfQuery in $CustomerDetails/ns5:SubjectOfQuery
                            return
                                <ns5:SubjectOfQuery>{ data($SubjectOfQuery) }</ns5:SubjectOfQuery>
                        }
                        {
                            for $Oucu in $CustomerDetails/ns5:Oucu
                            return
                                <ns5:Oucu>{ data($Oucu) }</ns5:Oucu>
                        }
                        {
                            for $PropectInfo in $CustomerDetails/ns5:PropectInfo
                            return
                                <ns5:PropectInfo>{ $PropectInfo/@* , $PropectInfo/node() }</ns5:PropectInfo>
                        }
                        <ns5:ProspectStatus>{ data($CustomerDetails/ns5:ProspectStatus) }</ns5:ProspectStatus>
                        <ns5:ContactType>{ data($CustomerDetails/ns5:ContactType) }</ns5:ContactType>
                        <ns5:PropositionType>{ data($CustomerDetails/ns5:PropositionType) }</ns5:PropositionType>
                        <ns5:AffinityMailingsAgreed>{ data($CustomerDetails/ns5:AffinityMailingsAgreed) }</ns5:AffinityMailingsAgreed>
                        {
                            for $SourceInfo in $CustomerDetails/ns5:SourceInfo
                            return
                                <ns5:SourceInfo>{ $SourceInfo/@* , $SourceInfo/node() }</ns5:SourceInfo>
                        }
                        <ns5:CustomerMatch>
                            {
                                for $MatchCode in $verifyContactResponse/ns1:ContactResult/ns1:MatchCode
                                return
                                    <ns5:MatchCode>{ data($MatchCode) }</ns5:MatchCode>
                            }
                            {
                                for $CustomerPI in $verifyContactResponse/ns1:ContactResult/ns1:CustomerPI
                                return
                                    <ns5:CustomerPI>{ data($CustomerPI) }</ns5:CustomerPI>
                            }
                        </ns5:CustomerMatch>
                        {
                            for $InteractionId in $CustomerDetails/ns5:InteractionId
                            return
                                <ns5:InteractionId>{ data($InteractionId) }</ns5:InteractionId>
                        }
                        {
                            for $documents in $CustomerDetails/ns5:documents
                            return
                                <ns5:documents>{ $documents/@* , $documents/node() }</ns5:documents>
                        }
                    </ns5:CustomerDetails>
            }
        </ns5:CreateCustomerProspectRequest>
};

declare variable $verifyContactResponse as element(ns1:VerifyContactResponse) external;
declare variable $createCustomerProspectRequest as element(ns5:CreateCustomerProspectRequest) external;

xf:MergeProspectReqWithContactMatch($verifyContactResponse,
    $createCustomerProspectRequest)
