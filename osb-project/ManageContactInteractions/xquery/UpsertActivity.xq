(:: pragma bea:global-element-parameter parameter="$createCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ouv:UpsertActivity" location="../../ServiceRepository/Contact/OUVoiceActivity/OUVoiceActivity.V2.0.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ouv = "http://www.open.ac.uk/voice/webservices/OUVoiceUpsertAccountWS";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/UpsertActivity/";

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

declare function xf:addDayAndTimeSlot($slot as xs:string)
    as xs:string? {
    
    (: Format the current date and time into format mm/dd/yyyy hh:mm:ss :)
    let $now := fn:current-date() + xdt:dayTimeDuration("P1D")
	
    
    let $nowTime := if ($slot = 'Morning') then
       					'09:00:00'
    				else if ($slot = 'Afternoon') then
       					'12:30:00'
    				else
       					'17:30:00'
    return
       	
 	concat(fn-bea:pad-left(xs:string(fn:month-from-date($now)),2,'0'),"/"
 		,fn-bea:pad-left(xs:string(fn:day-from-date($now)),2,'0'),"/"
 		,fn:year-from-date($now)
 		," ",substring(xs:string($nowTime),1,8))
 	
};

declare function xf:UpsertActivity($createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ouv:UpsertActivity) {
        <ouv:UpsertActivity>
            <ouv:Activity>
            	{
                        for $CustomerPI in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:CustomerPI[1]
                        where data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:MatchCode) != 'Partial'
                        return
                            <ouv:PersonalId>{ data($CustomerPI) }</ouv:PersonalId>
                }
                
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:Description>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'Call me back'
	                   		else 
	                   			'Interaction Online proposition'
                        }
                          </ouv:Description>
                }
                
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:Type>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'Call - Outbound'
	                     	else if (($PropositionType = 'SignUp') ) then 
	                     		'Account request'	
	                     	else 
	                   			'Fulfilment'
                        }
                          </ouv:Type>
                }
                <ouv:ActivityTopicCategory>Interaction</ouv:ActivityTopicCategory>
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:Priority>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'2-High'
	                     	else if (($PropositionType = 'SignUp') ) then 
	                     		'3-Medium'		
	                   		else 
	                   			'3-Medium'
                        }
                          </ouv:Priority>
                }
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:Status>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'Open'
	                     	else if (($PropositionType = 'SignUp') ) then 
	                     		'Done'	
	                   		else 
	                   			'Done'
                        }
                          </ouv:Status>
                }
                
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        <ouv:PlannedStart>
                        {	
                         	if (($PropositionType = 'CallMeBack') ) then
                         	
                         		if (exists($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime)) then
                         	 			xf:addDayAndTimeSlot($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime)
                         	 	 else xf:addDayAndTimeSlot('Evening')
                         	 else  
	                     		xf:dateTimeToString()	
	                    }
                         </ouv:PlannedStart>
                }
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        <ouv:Due>
                        {	
                         	if (($PropositionType = 'CallMeBack') ) then
                         	 	if (exists($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime)) then
                         	 			xf:addDayAndTimeSlot($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime)
                         	 	 else xf:addDayAndTimeSlot('Evening')
	                     	else  
	                     		xf:dateTimeToString()	
	                    }
                         </ouv:Due>
                }
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:OwnedBy>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'Q-SRS-OUTBOUND'
	                   		else 
	                   			'Q-SRS-GO-TO-MARKET'
                        }
                          </ouv:OwnedBy>
                }
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:SRArea>
                        {	if (($PropositionType = 'CallMeBack') ) then 
	                     		'Call me back'
	                     	else if (($PropositionType = 'SignUp') ) then 
	                     		'Sign up'		
	                   		else 
	                   			'Publication request'
                        }
                          </ouv:SRArea>
                }
                
                {
                        for $PropositionType in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType
                        return
                        	<ouv:SRSubArea>
                        {	if (($PropositionType = 'CallMeBack') )	then 
	                     		 data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:SubjectOfQuery) 
	                   		else 
	                   			''
                        }
                          </ouv:SRSubArea>
                }
                <ouv:AvoidableContactResponsibleParty>Necessary</ouv:AvoidableContactResponsibleParty>
				{
                    for $PreferredCallbackTime in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime
                    return
                        <ouv:PreferredCallbackTimeslot>{ data($PreferredCallbackTime) }</ouv:PreferredCallbackTimeslot>
                }
                <ouv:InteractionInfoItems>
                {
                    for $Title in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Title
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Title</ouv:FieldDescription>
	                  <ouv:Value>{ data($Title) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Forename in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Forename
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>First name</ouv:FieldDescription>
	                  <ouv:Value>{ data($Forename) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Surname in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Surname
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Last name</ouv:FieldDescription>
	                  <ouv:Value>{ data($Surname) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $BirthDate in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:BirthDate
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Date of birth</ouv:FieldDescription>
	                  <ouv:Value>{ xf:dateToString(xs:date($BirthDate)) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Email in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Email
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Email address</ouv:FieldDescription>
	                  <ouv:Value>{ data(lower-case($Email)) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $PhoneNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PhoneNumber 
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Phone number</ouv:FieldDescription>
	                  <ouv:Value>{ data($PhoneNumber) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Oucu  in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:Oucu 
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Oucu</ouv:FieldDescription>
	                  <ouv:Value>{ data($Oucu) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               
	               {
                    for $HouseNameOrNumber in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:HouseNameOrNumber
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>House name/number</ouv:FieldDescription>
	                  <ouv:Value>{ data($HouseNameOrNumber) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Line2 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line2
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Line2</ouv:FieldDescription>
	                  <ouv:Value>{ data($Line2) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Line3 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Line3
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Line3</ouv:FieldDescription>
	                  <ouv:Value>{ data($Line3) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $TownOrCity in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:TownOrCity
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Town Or City</ouv:FieldDescription>
	                  <ouv:Value>{ data($TownOrCity) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $County in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:County
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>County</ouv:FieldDescription>
	                  <ouv:Value>{ data($County) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Postcode in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Postcode
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Postcode</ouv:FieldDescription>
	                  <ouv:Value>{ data($Postcode) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Country in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:AddressDetails/ns3:Country
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Country</ouv:FieldDescription>
	                  
	                  {
	                   if (($Country = 'Wales') or ($Country = 'England') or ($Country = 'Northern Ireland') or ($Country = 'Scotland') or ($Country = 'Channel Islands') or ($Country = 'Isle of Man') )
	                   then 
	                     	<ouv:Value>United Kingdom</ouv:Value>
	                   else 
	                   		<ouv:Value>{ data($Country) } </ouv:Value>
	                  }
	                  
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $SelectedCountry in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SelectedCountry
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Selected Country</ouv:FieldDescription>
	                  <ouv:Value>{ data($SelectedCountry) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Prospect1 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropectInfo/ns3:Prospect1
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Prospect1</ouv:FieldDescription>
	                  <ouv:Value>{ data($Prospect1) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   } 
	               
	               {
                    for $Prospect2 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropectInfo/ns3:Prospect2
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Prospect2</ouv:FieldDescription>
	                  <ouv:Value>{ data($Prospect2) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Prospect3 in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropectInfo/ns3:Prospect3
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Prospect3</ouv:FieldDescription>
	                  <ouv:Value>{ data($Prospect3) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $ReceiveProspectus in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropectInfo/ns3:ReceiveProspectus
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>How would you like to receive prospectus?</ouv:FieldDescription>
	                  <ouv:Value>{ data($ReceiveProspectus) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               
	               
	               {
                    for $ProspectIntendsDegree in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:ProspectIntendsDegree
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Is your intention to study for a degree?</ouv:FieldDescription>
	                  <ouv:Value>{ data($ProspectIntendsDegree) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $MarketingAttainedStudyLevel in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingAttainedStudyLevel
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>What is your highest level of education to date?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingAttainedStudyLevel) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $MarketingSubjectOfInterest in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingSubjectOfInterest
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>What subject are you interested in?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingSubjectOfInterest) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               
	               {
                    for $StudyStartTimeframe in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:StudyStartTimeframe
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>When would you like to start your studies?</ouv:FieldDescription>
	                  <ouv:Value>{ data($StudyStartTimeframe) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $MarketingOccupationStatus in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:MarketingOccupationStatus
                    return
                       
                         <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Are you working at the moment?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingOccupationStatus) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $PreferredCallbackTime in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:PreferredCallbackTime
                    where data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType) = 'CallMeBack'
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Preferred callback time?</ouv:FieldDescription>
	                  <ouv:Value>{ data($PreferredCallbackTime) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $SubjectOfQuery in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SubjectOfQuery
                    where data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:PropositionType) = 'CallMeBack'
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Subject Of Query</ouv:FieldDescription>
	                  <ouv:Value>{ data($SubjectOfQuery) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	                <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Match Type</ouv:FieldDescription>
	                  <ouv:Value>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:MatchCode) }</ouv:Value>
	                  <ouv:Type>Derived</ouv:Type>
	               </ouv:InteractionInfoItem>
                    {
                        for $CustomerPI in fn:string-join($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:CustomerPI,',')
                        where data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:CustomerMatch/ns3:MatchCode) = 'Partial'
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Matched Ids</ouv:FieldDescription>
                                <ouv:Value>{ data($CustomerPI) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
                    }
                    {
                        for $SourceInfo in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Url</ouv:FieldDescription>
                                <ouv:Value>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo/ns3:Url) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
                     } 
                     {
                        for $SourceInfo in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo
                        return      
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Form Name</ouv:FieldDescription>
                                <ouv:Value>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo/ns3:FormName) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
                            
                    }
                    {
                        for $SourceInfo in $createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo
                        return      
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Dax Id</ouv:FieldDescription>
                                <ouv:Value>{ data($createCustomerProspectRequest/ns3:CustomerDetails/ns3:SourceInfo/ns3:DaxId) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
                            
                    }
                    
                    
                    
                </ouv:InteractionInfoItems>
            </ouv:Activity>
        </ouv:UpsertActivity>
};

declare variable $createCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:UpsertActivity($createCustomerProspectRequest)
