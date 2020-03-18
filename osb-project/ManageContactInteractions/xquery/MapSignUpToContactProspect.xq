(:: pragma bea:global-element-parameter parameter="$signUpRequest" element="ns4:SignUpRequest" location="../../ServiceRepository/Contact/SignUp/xsd/SignUp.1.0.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$signUpEnquirerResponse" element="ns0:SignUpEnquirerResponse" location="../../ServiceRepository/Utilities/sams/SignUpWS.wsdl" ::)
(:: pragma bea:global-element-return element="ns2:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns4 = "http://open.ac.uk/Contact/SignUp";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/MapSignUpToContactProspect/";

declare function xf:MapSignUpToContactProspect($signUpRequest as element(ns4:SignUpRequest),
    $signUpEnquirerResponse as element(ns0:SignUpEnquirerResponse))
    as element(ns2:CreateCustomerProspectRequest) {
        <ns2:CreateCustomerProspectRequest>
            {
                let $RequestHeader := $signUpRequest/ns4:RequestHeader
                return
                    <ns2:RequestHeader>
                        <ns1:id>{ data($RequestHeader/ns1:id) }</ns1:id>
                        {
                            for $source in $RequestHeader/ns1:source
                            return
                                <ns1:source>{ data($source) }</ns1:source>
                        }
                        {
                            for $user in $RequestHeader/ns1:user
                            return
                                <ns1:user>
                                    {
                                        for $credentials in $user/ns3:credentials
                                        return
                                            <ns3:credentials>{ data($credentials) }</ns3:credentials>
                                    }
                                    {
                                        for $userID in $user/ns3:userID
                                        return
                                            <ns3:userID>{ data($userID) }</ns3:userID>
                                    }
                                </ns1:user>
                        }
                    </ns2:RequestHeader>
            }
            <ns2:CustomerDetails>
                <ns2:Title>{ data($signUpRequest/ns4:CustomerDetails/ns2:Title) }</ns2:Title>
                {
                    for $Initials in $signUpRequest/ns4:CustomerDetails/ns2:Initials
                    return
                        <ns2:Initials>{ data($Initials) }</ns2:Initials>
                }
                <ns2:Forename>{ data($signUpRequest/ns4:CustomerDetails/ns2:Forename) }</ns2:Forename>
                <ns2:Surname>{ data($signUpRequest/ns4:CustomerDetails/ns2:Surname) }</ns2:Surname>
                <ns2:Email>{ data($signUpRequest/ns4:CustomerDetails/ns2:Email) }</ns2:Email>
                {
                    for $PhoneNumber in $signUpRequest/ns4:CustomerDetails/ns2:PhoneNumber
                    return
                        <ns2:PhoneNumber>{ data($PhoneNumber) }</ns2:PhoneNumber>
                }
                {
                    for $ReceiveSMS in $signUpRequest/ns4:CustomerDetails/ns2:ReceiveSMS
                    return
                        <ns2:ReceiveSMS>{ data($ReceiveSMS) }</ns2:ReceiveSMS>
                }
                {
                    for $AddressDetails in $signUpRequest/ns4:CustomerDetails/ns2:AddressDetails
                    return
                        <ns2:AddressDetails>
                            <ns2:HouseNameOrNumber>{ data($AddressDetails/ns2:HouseNameOrNumber) }</ns2:HouseNameOrNumber>
                            {
                                for $Line2 in $AddressDetails/ns2:Line2
                                return
                                    <ns2:Line2>{ data($Line2) }</ns2:Line2>
                            }
                            {
                                for $Line3 in $AddressDetails/ns2:Line3
                                return
                                    <ns2:Line3>{ data($Line3) }</ns2:Line3>
                            }
                            <ns2:TownOrCity>{ data($AddressDetails/ns2:TownOrCity) }</ns2:TownOrCity>
                            {
                                for $County in $AddressDetails/ns2:County
                                return
                                    <ns2:County>{ data($County) }</ns2:County>
                            }
                            {
                                for $Postcode in $AddressDetails/ns2:Postcode
                                return
                                    <ns2:Postcode>{ $Postcode }</ns2:Postcode>
                            }
                            <ns2:Country>{ data($AddressDetails/ns2:Country) }</ns2:Country>
                        </ns2:AddressDetails>
                }
                {
                    for $BirthDate in $signUpRequest/ns4:CustomerDetails/ns2:BirthDate
                    return
                        <ns2:BirthDate>{ data($BirthDate) }</ns2:BirthDate>
                }
                <ns2:SelectedCountry>{ data($signUpRequest/ns4:CustomerDetails/ns2:SelectedCountry) }</ns2:SelectedCountry>
                <ns2:CountryCode>{ data($signUpRequest/ns4:CustomerDetails/ns2:CountryCode) }</ns2:CountryCode>
                {
                    for $ProspectIntendsDegree in $signUpRequest/ns4:CustomerDetails/ns2:ProspectIntendsDegree
                    return
                        <ns2:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns2:ProspectIntendsDegree>
                }
                {
                    for $MarketingSubjectOfInterest in $signUpRequest/ns4:CustomerDetails/ns2:MarketingSubjectOfInterest
                    return
                        <ns2:MarketingSubjectOfInterest>{ data($MarketingSubjectOfInterest) }</ns2:MarketingSubjectOfInterest>
                }
                {
                    for $MarketingAttainedStudyLevel in $signUpRequest/ns4:CustomerDetails/ns2:MarketingAttainedStudyLevel
                    return
                        <ns2:MarketingAttainedStudyLevel>{ data($MarketingAttainedStudyLevel) }</ns2:MarketingAttainedStudyLevel>
                }
                {
                    for $StudyStartTimeframe in $signUpRequest/ns4:CustomerDetails/ns2:StudyStartTimeframe
                    return
                        <ns2:StudyStartTimeframe>{ data($StudyStartTimeframe) }</ns2:StudyStartTimeframe>
                }
                {
                    for $MarketingOccupationStatus in $signUpRequest/ns4:CustomerDetails/ns2:MarketingOccupationStatus
                    return
                        <ns2:MarketingOccupationStatus>{ data($MarketingOccupationStatus) }</ns2:MarketingOccupationStatus>
                }
                {
                    for $PreferredCallbackTime in $signUpRequest/ns4:CustomerDetails/ns2:PreferredCallbackTime
                    return
                        <ns2:PreferredCallbackTime>{ data($PreferredCallbackTime) }</ns2:PreferredCallbackTime>
                }
                {
                    for $SubjectOfQuery in $signUpRequest/ns4:CustomerDetails/ns2:SubjectOfQuery
                    return
                        <ns2:SubjectOfQuery>{ data($SubjectOfQuery) }</ns2:SubjectOfQuery>
                }
                {
                    for $Oucu in $signUpEnquirerResponse/ns0:SignUpEnquirerResult/ns0:Oucu
                    return
                        <ns2:Oucu>{ data($Oucu) }</ns2:Oucu>
                }
                {
                    for $PropectInfo in $signUpRequest/ns4:CustomerDetails/ns2:PropectInfo
                    return
                        <ns2:PropectInfo>
                            <ns2:Prospect1>{ data($PropectInfo/ns2:Prospect1) }</ns2:Prospect1>
                            {
                                for $Prospect2 in $PropectInfo/ns2:Prospect2
                                return
                                    <ns2:Prospect2>{ data($Prospect2) }</ns2:Prospect2>
                            }
                            {
                                for $Prospect3 in $PropectInfo/ns2:Prospect3
                                return
                                    <ns2:Prospect3>{ data($Prospect3) }</ns2:Prospect3>
                            }
                            <ns2:ReceiveProspectus>{ data($PropectInfo/ns2:ReceiveProspectus) }</ns2:ReceiveProspectus>
                        </ns2:PropectInfo>
                }
                <ns2:ProspectStatus>Active</ns2:ProspectStatus>
                <ns2:ContactType>{ data($signUpRequest/ns4:CustomerDetails/ns2:ContactType) }</ns2:ContactType>
                <ns2:PropositionType>{ data($signUpRequest/ns4:CustomerDetails/ns2:PropositionType) }</ns2:PropositionType>
                <ns2:AffinityMailingsAgreed>Y</ns2:AffinityMailingsAgreed>
                {
                    for $SourceInfo in $signUpRequest/ns4:CustomerDetails/ns2:SourceInfo
                    return
                        <ns2:SourceInfo>
                            {
                                for $Url in $SourceInfo/ns2:Url
                                return
                                    <ns2:Url>{ data($Url) }</ns2:Url>
                            }
                            <ns2:FormName>{ data($SourceInfo/ns2:FormName) }</ns2:FormName>
                            {
                                for $DaxId in $SourceInfo/ns2:DaxId
                                return
                                    <ns2:DaxId>{ data($DaxId) }</ns2:DaxId>
                            }
                        </ns2:SourceInfo>
                }
                {
                    for $CustomerMatch in $signUpRequest/ns4:CustomerDetails/ns2:CustomerMatch
                    return
                        <ns2:CustomerMatch>
                            {
                                for $MatchCode in $CustomerMatch/ns2:MatchCode
                                return
                                    <ns2:MatchCode>{ data($MatchCode) }</ns2:MatchCode>
                            }
                            {
                                for $CustomerPI in $CustomerMatch/ns2:CustomerPI
                                return
                                    <ns2:CustomerPI>{ data($CustomerPI) }</ns2:CustomerPI>
                            }
                        </ns2:CustomerMatch>
                }
                {
                    for $InteractionId in $signUpRequest/ns4:CustomerDetails/ns2:InteractionId
                    return
                        <ns2:InteractionId>{ data($InteractionId) }</ns2:InteractionId>
                }
                {
                    for $documents in $signUpRequest/ns4:CustomerDetails/ns2:documents
                    return
                        <ns2:documents>
                            {
                                for $document in $documents/ns2:document
                                return
                                    <ns2:document>{ $document/@* , $document/node() }</ns2:document>
                            }
                        </ns2:documents>
                }
            </ns2:CustomerDetails>
        </ns2:CreateCustomerProspectRequest>
};

declare variable $signUpRequest as element(ns4:SignUpRequest) external;
declare variable $signUpEnquirerResponse as element(ns0:SignUpEnquirerResponse) external;

xf:MapSignUpToContactProspect($signUpRequest,
    $signUpEnquirerResponse)
