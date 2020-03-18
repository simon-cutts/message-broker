(:: pragma bea:global-element-parameter parameter="$updateContactInteractionRequest" element="ns2:UpdateContactInteractionRequest" location="../../ServiceRepository/Contact/UpdateCustomerInteraction/xsd/UpdateCustomerInteraction.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ouv:UpsertActivity" location="../../ServiceRepository/Contact/OUVoiceActivity/OUVoiceActivity.V2.0.wsdl" ::)

declare namespace ouv = "http://www.open.ac.uk/voice/webservices/OUVoiceUpsertAccountWS";
declare namespace ns2 = "http://open.ac.uk/Contact/UpdateCustomerInteraction";
declare namespace ns4 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/Contact/GetCustomer";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/MapContactInteractionToUpsertActivity/";

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

declare function xf:MapContactInteractionToUpsertActivity($updateContactInteractionRequest as element(ns2:UpdateContactInteractionRequest))
    as element(ouv:UpsertActivity) {
        <ouv:UpsertActivity>
            <ouv:Activity>
                <ouv:PersonalId>{ data($updateContactInteractionRequest/ns2:Customer/ns3:personalId) }</ouv:PersonalId>
                <ouv:Description>My account update</ouv:Description>
                <ouv:Type>Account update</ouv:Type>
                <ouv:ActivityTopicCategory>Interaction</ouv:ActivityTopicCategory>
                <ouv:Priority>3-Medium</ouv:Priority>
                <ouv:Status>Done</ouv:Status>
                <ouv:PlannedStart>{ xf:dateTimeToString()}</ouv:PlannedStart>
                <ouv:Due>{ xf:dateTimeToString() }</ouv:Due>
                <ouv:OwnedBy>Q-SRS-GO-TO-MARKET</ouv:OwnedBy>
                <ouv:SRArea>My account</ouv:SRArea>
                <ouv:SRSubArea>My account update</ouv:SRSubArea>
                <ouv:AvoidableContactResponsibleParty>Necessary</ouv:AvoidableContactResponsibleParty>
                 <ouv:InteractionInfoItems>
                 {
                    for $Initials in $updateContactInteractionRequest/ns2:Customer/ns3:initials
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Initials</ouv:FieldDescription>
	                  <ouv:Value>{ data($Initials) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
				 {
                    for $Title in $updateContactInteractionRequest/ns2:Customer/ns3:title
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Title</ouv:FieldDescription>
	                  <ouv:Value>{ data($Title) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Forename in $updateContactInteractionRequest/ns2:Customer/ns3:forenames
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>First name</ouv:FieldDescription>
	                  <ouv:Value>{ data($Forename) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Surname in $updateContactInteractionRequest/ns2:Customer/ns3:surname
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Last name</ouv:FieldDescription>
	                  <ouv:Value>{ data($Surname) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $BirthDate in $updateContactInteractionRequest/ns2:Customer/ns3:dateOfBirth
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Date of birth</ouv:FieldDescription>
	                  <ouv:Value>{ xf:dateToString(xs:date($BirthDate)) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Email in $updateContactInteractionRequest/ns2:Customer/ns3:Contact/ns3:emailAddress
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Email address</ouv:FieldDescription>
	                  <ouv:Value>{ data(lower-case($Email)) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $PhoneNumber in $updateContactInteractionRequest/ns2:Customer/ns3:Contact/ns3:dayTelephoneNumber
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Phone number</ouv:FieldDescription>
	                  <ouv:Value>{ data($PhoneNumber) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Oucu  in $updateContactInteractionRequest/ns2:Customer/ns3:ouComputerUserName
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Oucu</ouv:FieldDescription>
	                  <ouv:Value>{ data($Oucu) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               
	               {
                    for $HouseNameOrNumber in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:addressLine1
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>House name/number</ouv:FieldDescription>
	                  <ouv:Value>{ data($HouseNameOrNumber) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Line2 in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:addressLine2
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Line2</ouv:FieldDescription>
	                  <ouv:Value>{ data($Line2) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $Line3 in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:addressLine3
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Line3</ouv:FieldDescription>
	                  <ouv:Value>{ data($Line3) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $TownOrCity in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:addressLine4
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Town Or City</ouv:FieldDescription>
	                  <ouv:Value>{ data($TownOrCity) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $County in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:addressLine5
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>County</ouv:FieldDescription>
	                  <ouv:Value>{ data($County) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Postcode in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:postcode
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Postcode</ouv:FieldDescription>
	                  <ouv:Value>{ data($Postcode) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $Country in $updateContactInteractionRequest/ns2:Customer/ns3:Address/ns3:country
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
                    for $ProspectIntendsDegree in $updateContactInteractionRequest/ns2:Customer/ns3:MarketingSegment/ns3:intendsDegree
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Is your intention to study for a degree?</ouv:FieldDescription>
	                  <ouv:Value>{ data($ProspectIntendsDegree) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $MarketingAttainedStudyLevel in $updateContactInteractionRequest/ns2:Customer/ns3:MarketingSegment/ns3:marketingAttainedStudyLevel
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>What is your highest level of education to date?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingAttainedStudyLevel) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $MarketingSubjectOfInterest in $updateContactInteractionRequest/ns2:Customer/ns3:MarketingSegment/ns3:marketingSourceOfInterest
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>What subject are you interested in?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingSubjectOfInterest) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               
	               {
                    for $StudyStartTimeframe in $updateContactInteractionRequest/ns2:Customer/ns3:MarketingSegment/ns3:StudyStartTimeframe
                    return
                       
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>When would you like to start your studies?</ouv:FieldDescription>
	                  <ouv:Value>{ data($StudyStartTimeframe) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
	               {
                    for $MarketingOccupationStatus in $updateContactInteractionRequest/ns2:Customer/ns3:MarketingSegment/ns3:marketingOccupationStatus
                    return
                       
                         <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Are you working at the moment?</ouv:FieldDescription>
	                  <ouv:Value>{ data($MarketingOccupationStatus) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
                   {
                    for $PreferredTimeToCall in $updateContactInteractionRequest/ns2:Customer/ns3:PreferredCustomerDetails/ns3:preferredTimeToCall
                    return
                      <ouv:InteractionInfoItem>
	                  <ouv:FieldDescription>Preferred time to call?</ouv:FieldDescription>
	                  <ouv:Value>{ data($PreferredTimeToCall) }</ouv:Value>
	                  <ouv:Type>Captured</ouv:Type>
	               </ouv:InteractionInfoItem>
                   }
				   
				    {
                        for $SourceInfo in $updateContactInteractionRequest/ns2:SourceInfo
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Url</ouv:FieldDescription>
                                <ouv:Value>{ data($SourceInfo/ns2:Url) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
							 
                     } 
                     {
                        for $SourceInfo in $updateContactInteractionRequest/ns2:SourceInfo
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Form Name</ouv:FieldDescription>
                                <ouv:Value>{ data($SourceInfo/ns2:FormName) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
							 
                     } 
                     {
                        for $SourceInfo in $updateContactInteractionRequest/ns2:SourceInfo
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Dax ID</ouv:FieldDescription>
                                <ouv:Value>{ data($SourceInfo/ns2:DaxId) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
							 
                     } 
                   (: 
				      Lakshminadh :Currently Shortlist and Customer Funding Preference are not required. in case Required we will uncomment the same.
				       
				   	  {
							for $ShortListDetail in $updateContactInteractionRequest/ns2:Customer/ns3:ShortListDetails/ns3:ShortListDetail
							return
							<ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Short List Detail</ouv:FieldDescription>
                                <ouv:Value>{ concat('Product : '$ShortListDetail/ns3:product ,',Start Date : ',$ShortListDetail/ns3:startDate ,',Funding Req : ', $ShortListDetail/ns3:fundingRequested) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
						}
					{
                        for $CustomerFundingPreference in $updateContactInteractionRequest/ns2:Customer/ns3:CustomerFundingPreferences/ns3:CustomerFundingPreference
                        return
                            <ouv:InteractionInfoItem>
                                <ouv:FieldDescription>Customer Funding Preference</ouv:FieldDescription>
                                <ouv:Value>{ concat('QID : ',$CustomerFundingPreference/ns3:questionId,',Answer : ',$CustomerFundingPreference/ns3:answer,',BFPO : ', $CustomerFundingPreference/ns3:british_forces_postal_overseas) }</ouv:Value>
                                <ouv:Type>Captured</ouv:Type>
                            </ouv:InteractionInfoItem>
                    }
						


				   :)
	               
                </ouv:InteractionInfoItems>
                
            </ouv:Activity>
        </ouv:UpsertActivity>
};

declare variable $updateContactInteractionRequest as element(ns2:UpdateContactInteractionRequest) external;

xf:MapContactInteractionToUpsertActivity($updateContactInteractionRequest)