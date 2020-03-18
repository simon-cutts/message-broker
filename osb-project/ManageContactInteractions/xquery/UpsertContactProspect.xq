(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:UpsertContact" location="../../ServiceRepository/Contact/OUVoiceUpsertContact/wsdl/OUVoiceUpsertContact.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/OUVoiceUpsertContactWS";
declare namespace xf = "http://tempuri.org/OUVoiceUpsertContact/xquery/UpsertContact/";

declare function xf:dateToString($date as xs:date)
    as xs:string? {
    
 	(: Format the current date and time into format mm/dd/yyyy :)
 	concat(fn-bea:pad-left(xs:string(fn:month-from-date($date)),2,'0'),"/",
 		fn-bea:pad-left(xs:string(fn:day-from-date($date)),2,'0'),"/",
 		fn:year-from-date($date))
};
declare function xf:dateTimeToString()
    as xs:string? {
    
    (: Format the current date and time into format mm/dd/yyyy hh:mm:ss :)
    let $now := fn:current-date()
    let $nowTime := fn:current-time()
    
    return
 	concat(fn-bea:pad-left(xs:string(fn:month-from-date($now)),2,'0'),"/"
 		,fn-bea:pad-left(xs:string(fn:day-from-date($now)),2,'0'),"/"
 		,fn:year-from-date($now)
 		," ",substring(xs:string($nowTime),1,8))
 	
};

declare function xf:UpsertContactProspect($createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ns0:UpsertContact) {
        <ns0:UpsertContact>
            <ns0:Contacts>
                <ns0:PersonalId>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:CustomerPI[1]) }</ns0:PersonalId>
                <ns0:Surname>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Surname) }</ns0:Surname>
                <ns0:Initials>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Initials) }</ns0:Initials>
                <ns0:Title>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Title) }</ns0:Title>
                {
                    for $BirthDate in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:BirthDate
                    return
                    <ns0:BirthDate>{ xf:dateToString(xs:date($BirthDate)) }</ns0:BirthDate>
                }  
                {
                    for $Postcode in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Postcode
                    return
                    <ns0:Postcode>{ data($Postcode) }</ns0:Postcode>
                    
                }    
                <ns0:Forenames>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Forename) }</ns0:Forenames>
                {
                    for $PhoneNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PhoneNumber
                    return
                    <ns0:DayTelephoneNum>{ data($PhoneNumber) }</ns0:DayTelephoneNum>
                }  
                {
                    for $PhoneNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PhoneNumber
                    return
               		<ns0:EveningTelephoneNum>{ data($PhoneNumber) } </ns0:EveningTelephoneNum>
                }  
				
                {
                    for $HouseNameOrNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:HouseNameOrNumber
                    return
                    <ns0:AddressLine1>{ data($HouseNameOrNumber) }</ns0:AddressLine1>
                }  
                {
                    for $Line2 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line2
                    return
                        <ns0:AddressLine2>{ data($Line2) }</ns0:AddressLine2>
                }
                {
                    for $Line3 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line3
                    return
                        <ns0:AddressLine3>{ data($Line3) }</ns0:AddressLine3>
                }
               
                {
                    for $TownOrCity in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:TownOrCity
                    return
                        <ns0:AddressLine4>{ data($TownOrCity) }</ns0:AddressLine4>
                }
                {
                    for $County in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:County
                    return
                        <ns0:AddressLine5>{ data($County) }</ns0:AddressLine5>
                }
                {
                    for $Country in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Country
                    return
                    <ns0:CountryName>
                    {	if (($Country = 'Wales') or ($Country = 'England') or ($Country = 'Northern Ireland') or ($Country = 'Scotland') or ($Country = 'Channel Islands')  or ($Country = 'Isle of Man') )	then
                    	'United Kingdom' 
	                   		else 
	                   			data($Country)
                        }   
                       
                    </ns0:CountryName>   
                }
                {
                    for $UKArea in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Country
                    return
                    <ns0:UKArea>
                    { if (($UKArea = 'Wales') or ($UKArea = 'England') or ($UKArea = 'Northern Ireland') or ($UKArea = 'Scotland') or ($UKArea = 'Channel Islands')  or ($UKArea = 'Isle of Man') ) then
                       data($UKArea)
                    else  
                       ''
                    }
                    </ns0:UKArea>
                }
                {
                    for $Oucu in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Oucu
                    return
                        <ns0:OUComputerUserName>{ data($Oucu) }</ns0:OUComputerUserName>
                }
                              
                <ns0:EmailAddress>{ data(lower-case($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Email)) }</ns0:EmailAddress>
                <ns0:ContactType>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:ContactType) }</ns0:ContactType>
                <ns0:EmailStatus>G</ns0:EmailStatus>
                <ns0:EmailingPreferred>1</ns0:EmailingPreferred>
                <ns0:AffinityMailingsAgreed>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:AffinityMailingsAgreed) }</ns0:AffinityMailingsAgreed>
                <ns0:EmailingPrefSetDate>{ xf:dateTimeToString() }</ns0:EmailingPrefSetDate>
                <ns0:EmailingSetByUserId>ccdba</ns0:EmailingSetByUserId>
                <ns0:EmailStatusDate>{ xf:dateTimeToString() }</ns0:EmailStatusDate>
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
                <ns0:ProspectStatus>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectStatus) }</ns0:ProspectStatus>
                
                {
                    for $ProspectIntendsDegree in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectIntendsDegree
                    return
                        <ns0:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns0:ProspectIntendsDegree>
                }
                {
                    for $ReceiveSMS in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ReceiveSMS
                    return
                        <ns0:ContactBySMSAgreed>{ data($ReceiveSMS) }</ns0:ContactBySMSAgreed>
                }
                {
                    for $PreferredCallbackTime in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime
                    return
                        <ns0:BestTimeToCall>{ data($PreferredCallbackTime) }</ns0:BestTimeToCall>
                }
				{	
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
						<ns0:SignonEmailAddress>
                        {	if ((upper-case($PropositionType) = 'SIGNUP') or (upper-case($PropositionType) = 'SIGNUPANDRQAP') ) then 
	                     		data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Email)
	                     	else 
	                     		''	
	                    }
                        </ns0:SignonEmailAddress>
                }
                
                
            </ns0:Contacts>
        </ns0:UpsertContact>
};

declare variable $createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:UpsertContactProspect($createCustomerProspectRequest)

