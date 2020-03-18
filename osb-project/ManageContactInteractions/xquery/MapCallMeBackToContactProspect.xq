(:: pragma bea:global-element-parameter parameter="$callMeBackRequest" element="ns3:CallMeBackRequest" location="../../ServiceRepository/Contact/CallMeBack/xsd/CallMeBack.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns3 = "http://open.ac.uk/Contact/CallMeBack";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/MapCallMeBackToContactProspect/";

declare function xf:MapCallMeBackToContactProspect($callMeBackRequest as element(ns3:CallMeBackRequest))
    as element(ns1:CreateCustomerProspectRequest) {
        <ns1:CreateCustomerProspectRequest>
            {
                let $RequestHeader := $callMeBackRequest/ns3:RequestHeader
                return
                    <ns1:RequestHeader>
                        <ns0:id>{ data($RequestHeader/ns0:id) }</ns0:id>
                        {
                            for $source in $RequestHeader/ns0:source
                            return
                                <ns0:source>{ data($source) }</ns0:source>
                        }
                        {
                            for $user in $RequestHeader/ns0:user
                            return
                                <ns0:user>
                                    {
                                        for $credentials in $user/ns2:credentials
                                        return
                                            <ns2:credentials>{ data($credentials) }</ns2:credentials>
                                    }
                                    {
                                        for $userID in $user/ns2:userID
                                        return
                                            <ns2:userID>{ data($userID) }</ns2:userID>
                                    }
                                </ns0:user>
                        }
                    </ns1:RequestHeader>
            }
            {
                let $CustomerDetails := $callMeBackRequest/ns3:CustomerDetails
                return
                    <ns1:CustomerDetails>
                        <ns1:Title>{ data($CustomerDetails/ns1:Title) }</ns1:Title>
                        <ns1:Forename>{ data($CustomerDetails/ns1:Forename) }</ns1:Forename>
                        <ns1:Surname>{ data($CustomerDetails/ns1:Surname) }</ns1:Surname>
                        <ns1:Email>{ data($CustomerDetails/ns1:Email) }</ns1:Email>
                        {
                            for $PhoneNumber in $CustomerDetails/ns1:PhoneNumber
                            return
                                <ns1:PhoneNumber>{ data($PhoneNumber) }</ns1:PhoneNumber>
                        }
                        {
                            for $ReceiveSMS in $CustomerDetails/ns1:ReceiveSMS
                            return
                                <ns1:ReceiveSMS>{ data($ReceiveSMS) }</ns1:ReceiveSMS>
                        }
                        {
                            for $AddressDetails in $CustomerDetails/ns1:AddressDetails
                            return
                                <ns1:AddressDetails>
                                    <ns1:HouseNameOrNumber>{ data($AddressDetails/ns1:HouseNameOrNumber) }</ns1:HouseNameOrNumber>
                                    {
                                        for $Line2 in $AddressDetails/ns1:Line2
                                        return
                                            <ns1:Line2>{ data($Line2) }</ns1:Line2>
                                    }
                                    {
                                        for $Line3 in $AddressDetails/ns1:Line3
                                        return
                                            <ns1:Line3>{ data($Line3) }</ns1:Line3>
                                    }
                                    <ns1:TownOrCity>{ data($AddressDetails/ns1:TownOrCity) }</ns1:TownOrCity>
                                    {
                                        for $County in $AddressDetails/ns1:County
                                        return
                                            <ns1:County>{ data($County) }</ns1:County>
                                    }
                                    {
                                        for $Postcode in $AddressDetails/ns1:Postcode
                                        return
                                            <ns1:Postcode>{ data($Postcode) }</ns1:Postcode>
                                    }
                                    <ns1:Country>{ data($AddressDetails/ns1:Country) }</ns1:Country>
                                </ns1:AddressDetails>
                        }
                        {
                            for $BirthDate in $CustomerDetails/ns1:BirthDate
                            return
                                <ns1:BirthDate>{ data($BirthDate) }</ns1:BirthDate>
                        }
                        <ns1:SelectedCountry>{ data($CustomerDetails/ns1:SelectedCountry) }</ns1:SelectedCountry>
                        <ns1:CountryCode>{ data($CustomerDetails/ns1:CountryCode) }</ns1:CountryCode>
                        {
                            for $ProspectIntendsDegree in $CustomerDetails/ns1:ProspectIntendsDegree
                            return
                                <ns1:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns1:ProspectIntendsDegree>
                        }
                        {
                            for $MarketingSubjectOfInterest in $CustomerDetails/ns1:MarketingSubjectOfInterest
                            return
                                <ns1:MarketingSubjectOfInterest>{ data($MarketingSubjectOfInterest) }</ns1:MarketingSubjectOfInterest>
                        }
                        {
                            for $MarketingAttainedStudyLevel in $CustomerDetails/ns1:MarketingAttainedStudyLevel
                            return
                                <ns1:MarketingAttainedStudyLevel>{ data($MarketingAttainedStudyLevel) }</ns1:MarketingAttainedStudyLevel>
                        }
                        {
                            for $StudyStartTimeframe in $CustomerDetails/ns1:StudyStartTimeframe
                            return
                                <ns1:StudyStartTimeframe>{ data($StudyStartTimeframe) }</ns1:StudyStartTimeframe>
                        }
                        {
                            for $MarketingOccupationStatus in $CustomerDetails/ns1:MarketingOccupationStatus
                            return
                                <ns1:MarketingOccupationStatus>{ data($MarketingOccupationStatus) }</ns1:MarketingOccupationStatus>
                        }
                        {
                            for $PreferredCallbackTime in $CustomerDetails/ns1:PreferredCallbackTime
                            return
                                <ns1:PreferredCallbackTime>{ data($PreferredCallbackTime) }</ns1:PreferredCallbackTime>
                        }
                        {
                            for $SubjectOfQuery in $CustomerDetails/ns1:SubjectOfQuery
                            return
                                <ns1:SubjectOfQuery>{ data($SubjectOfQuery) }</ns1:SubjectOfQuery>
                        }
                        {
                            for $Oucu in $CustomerDetails/ns1:Oucu
                            return
                                <ns1:Oucu>{ data($Oucu) }</ns1:Oucu>
                        }
                        {
                            for $PropectInfo in $CustomerDetails/ns1:PropectInfo
                            return
                                <ns1:PropectInfo>
                                    <ns1:Prospect1>{ data($PropectInfo/ns1:Prospect1) }</ns1:Prospect1>
                                    {
                                        for $Prospect2 in $PropectInfo/ns1:Prospect2
                                        return
                                            <ns1:Prospect2>{ data($Prospect2) }</ns1:Prospect2>
                                    }
                                    {
                                        for $Prospect3 in $PropectInfo/ns1:Prospect3
                                        return
                                            <ns1:Prospect3>{ data($Prospect3) }</ns1:Prospect3>
                                    }
                                    <ns1:ReceiveProspectus>{ data($PropectInfo/ns1:ReceiveProspectus) }</ns1:ReceiveProspectus>
                                </ns1:PropectInfo>
                        }
                        <ns1:ProspectStatus>{ data($CustomerDetails/ns1:ProspectStatus) }</ns1:ProspectStatus>
                        <ns1:ContactType>{ data($CustomerDetails/ns1:ContactType) }</ns1:ContactType>
                        <ns1:PropositionType>{ data($CustomerDetails/ns1:PropositionType) }</ns1:PropositionType>
                        <ns1:AffinityMailingsAgreed>{ data($CustomerDetails/ns1:AffinityMailingsAgreed) }</ns1:AffinityMailingsAgreed>
                        {
                            for $SourceInfo in $CustomerDetails/ns1:SourceInfo
                            return
                                <ns1:SourceInfo>
                                    {
                                        for $Url in $SourceInfo/ns1:Url
                                        return
                                            <ns1:Url>{ data($Url) }</ns1:Url>
                                    }
                                    <ns1:FormName>{ data($SourceInfo/ns1:FormName) }</ns1:FormName>
                                    {
                                        for $DaxId in $SourceInfo/ns1:DaxId
                                        return
                                            <ns1:DaxId>{ data($DaxId) }</ns1:DaxId>
                                    }
                                </ns1:SourceInfo>
                        }
                        {
                            for $CustomerMatch in $CustomerDetails/ns1:CustomerMatch
                            return
                                <ns1:CustomerMatch>
                                    {
                                        for $MatchCode in $CustomerMatch/ns1:MatchCode
                                        return
                                            <ns1:MatchCode>{ data($MatchCode) }</ns1:MatchCode>
                                    }
                                    {
                                        for $CustomerPI in $CustomerMatch/ns1:CustomerPI
                                        return
                                            <ns1:CustomerPI>{ data($CustomerPI) }</ns1:CustomerPI>
                                    }
                                </ns1:CustomerMatch>
                        }
                        {
                            for $InteractionId in $CustomerDetails/ns1:InteractionId
                            return
                                <ns1:InteractionId>{ data($InteractionId) }</ns1:InteractionId>
                        }
                        {
                            for $documents in $CustomerDetails/ns1:documents
                            return
                                <ns1:documents>{ $documents/@* , $documents/node() }</ns1:documents>
                        }
                    </ns1:CustomerDetails>
            }
        </ns1:CreateCustomerProspectRequest>
};

declare variable $callMeBackRequest as element(ns3:CallMeBackRequest) external;

xf:MapCallMeBackToContactProspect($callMeBackRequest)
