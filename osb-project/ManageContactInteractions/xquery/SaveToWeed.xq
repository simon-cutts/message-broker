(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SaveToWeed" location="../../ServiceRepository/Contact/Weed/wsdl/DuplicateResolution.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://www.open.ac.uk/OU.SOALiaison";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/SaveToWeed/";

declare function xf:dateToString($date as xs:date)
    as xs:string? {
    
 	(: Format the current date and time into format dd-MMM-yyyy :)
 	concat(fn-bea:pad-left(xs:string(fn:day-from-date($date)),2,'0'),"-",
 	xf:month(fn-bea:pad-left(xs:string(fn:month-from-date($date)),2,'0')),"-",
 		fn:year-from-date($date))
};
declare function xf:dateTimeToString()
    as xs:string? {
    
    (: Format the current date and time into format DD-MMM-yyyy hh:mm:ss :)
    let $now := fn:current-date()
    let $nowTime := fn:current-time()
    
    return
 	concat(fn-bea:pad-left(xs:string(fn:day-from-date($now)),2,'0'),"-",
 	xf:month(fn-bea:pad-left(xs:string(fn:month-from-date($now)),2,'0')),"-",
 	fn:year-from-date($now)
 		," ",substring(xs:string($nowTime),1,8))
 	
};
declare function xf:month($month as xs:string)
    as xs:string {
    if ($month = '01') 
    	then "JAN"
    	
    else if ($month = '02') 
    	then "FEB"
    else if ($month = '03') 
    	then "MAR"
    else if ($month = '04') 
    	then "APR"
    else if ($month = '05') 
    	then "MAY"
    else if ($month = '06') 
    	then "JUN"
    else if ($month = '07') 
    	then "JUL"
    else if ($month = '08') 
    	then "AUG"
    else if ($month = '09') 
    	then "SEP"
    else if ($month = '10') 
    	then "OCT"
    else if ($month = '11') 
    	then "NOV"
    else
        "DEC"    
};

declare function xf:SaveToWeed($createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ns1:SaveToWeed) {
        <ns1:SaveToWeed>
            <ns1:inputDetails>
                <ns1:Title>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Title) }</ns1:Title>
                <ns1:Initials>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Initials) }</ns1:Initials>
                <ns1:Forenames>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Forename) }</ns1:Forenames>
                <ns1:Lastname>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Surname) }</ns1:Lastname>
                {
                    for $BirthDate in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:BirthDate
                    return
                        <ns1:DoB>{ xf:dateToString($BirthDate) }</ns1:DoB>
                }
                <ns1:Email>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:Email) }</ns1:Email>
                <ns1:EmailStatus>G</ns1:EmailStatus>
                <ns1:EmailStatusDate>{ xf:dateToString(fn:current-date()) }</ns1:EmailStatusDate>
                {
                    for $HouseNameOrNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:HouseNameOrNumber
                    return
                        <ns1:AddressLine1>{ data($HouseNameOrNumber) }</ns1:AddressLine1>
                }
                {
                    for $Line2 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line2
                    return
                        <ns1:AddressLine2>{ data($Line2) }</ns1:AddressLine2>
                }
                {
                    for $Line3 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line3
                    return
                        <ns1:AddressLine3>{ data($Line3) }</ns1:AddressLine3>
                }
                {
                    for $TownOrCity in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:TownOrCity
                    return
                        <ns1:AddressLine4>{ data($TownOrCity) }</ns1:AddressLine4>
                }
                {
                    for $County in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:County
                    return
                        <ns1:AddressLine5>{ data($County) }</ns1:AddressLine5>
                }
                {
                    for $Postcode in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Postcode
                    return
                        <ns1:Postcode>{ data($Postcode) }</ns1:Postcode>
                }
                 {
                    if (exists($createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Country)) then
                    for $Country in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Country
                    return
                        <ns1:Country>
                        { if (($Country = 'Wales') or ($Country = 'England') or ($Country = 'Northern Ireland') or ($Country = 'Scotland') or ($Country = 'Channel Islands')  or ($Country = 'Isle of Man') )
                        then 
                        'United Kingdom'
                        else  data($Country) 
                        }
                        </ns1:Country>
                    
                    else
                      for $SelectedCountry in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SelectedCountry
                      return
                       <ns1:Country>
                        { if (($SelectedCountry = 'Wales') or ($SelectedCountry = 'England') or ($SelectedCountry = 'Northern Ireland') or ($SelectedCountry = 'Scotland') or ($SelectedCountry = 'Channel Islands')  or ($SelectedCountry = 'Isle of Man') )
                        then 
                        	'United Kingdom'
                        else  
                        	data($SelectedCountry)
                        }
                        </ns1:Country>
                        
                }
                {
                    for $PhoneNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PhoneNumber
                    return
                        <ns1:PhoneNumber>{ data($PhoneNumber) }</ns1:PhoneNumber>
                }
                {
                    for $ProspectHasPrevOUStudy in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectHasPrevOUStudy
                    return
                        <ns1:ProspectHasPreviousStudy>{ data($ProspectHasPrevOUStudy) }</ns1:ProspectHasPreviousStudy>
                }
                {
                    for $ProspectIntendsDegree in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectIntendsDegree
                    return
                        <ns1:ProspectIntendsDegree>{ data($ProspectIntendsDegree) }</ns1:ProspectIntendsDegree>
                }
                {
                    for $MarketingAttainedStudyLevel in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingAttainedStudyLevel
                    return
                        <ns1:MarketingAttainedStudyLevel>{ data($MarketingAttainedStudyLevel) }</ns1:MarketingAttainedStudyLevel>
                }
                {
                    for $MarketingSubjectOfInterest in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingSubjectOfInterest
                    return
                        <ns1:MarketingSubjectOfInterest>{ data($MarketingSubjectOfInterest) }</ns1:MarketingSubjectOfInterest>
                }
                {
                    for $StudyStartTimeframe in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:StudyStartTimeframe
                    return
                        <ns1:StudyStartTimeFrame>{ data($StudyStartTimeframe) }</ns1:StudyStartTimeFrame>
                }
                {
                    for $MarketingOccupationStatus in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingOccupationStatus
                    return
                        <ns1:MarketingOccupationStatus>{ data($MarketingOccupationStatus) }</ns1:MarketingOccupationStatus>
                }
                {
                    for $InteractionId in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:InteractionId
                    return
                        <ns1:InterationId>{ data($InteractionId) }</ns1:InterationId>
                }
                <ns1:PotentialDuplicates>
                	<ns1:string>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:MatchCode) }</ns1:string>
                    {
                        for $CustomerPI in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:CustomerPI
                        return
                        	
                            <ns1:string>{ data($CustomerPI) }</ns1:string>
                    }
                </ns1:PotentialDuplicates>
				{
                    for $Oucu in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Oucu
                    return
                        <ns1:InterimOucu>{ data($Oucu) }</ns1:InterimOucu>
                }
            </ns1:inputDetails>
        </ns1:SaveToWeed>
};

declare variable $createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:SaveToWeed($createCustomerProspectRequest)
