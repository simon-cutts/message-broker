(:: pragma bea:global-element-parameter parameter="$verifyContactRequest" element="ns1:VerifyContactRequest" location="../../ServiceRepository/Contact/VerifyContact/xsd/VerifyContact.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetDuplicateContacts" location="../../ServiceRepository/Contact/OUVoiceGetContact/wsdl/OUVoiceGetContactV2.0.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://open.ac.uk/Contact/VerifyContact";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/ouvoicegetcontactws";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/CheckDuplicatesReq/";

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

declare function xf:CheckDuplicatesReq($verifyContactRequest as element(ns1:VerifyContactRequest))
    as element(ns0:GetDuplicateContacts) {
        <ns0:GetDuplicateContacts>
            <ns0:oInput>
                (: Lakshminadh Commented to give proper match results. 
                
                {
                    for $Initials in $verifyContactRequest/ns1:ContactDetails/ns1:Initials
                    return
                        <ns0:Initials>{ data($Initials) }</ns0:Initials>
                }
                :)
                {
                    for $Forename in $verifyContactRequest/ns1:ContactDetails/ns1:Forename
                    return
                        <ns0:Forenames>{ data($Forename) }</ns0:Forenames>
                }
                {                
                    for $HouseNameOrNumber in $verifyContactRequest/ns1:ContactDetails/ns1:AddressDetails/ns1:HouseNameOrNumber
                    return
                        <ns0:AddressLine1>{ data($HouseNameOrNumber) }</ns0:AddressLine1>
                }
                {
                    for $Postcode in $verifyContactRequest/ns1:ContactDetails/ns1:AddressDetails/ns1:Postcode
                    return
                        <ns0:Postcode>{ data($Postcode) }</ns0:Postcode>
                }
                {
                    for $Email in $verifyContactRequest/ns1:ContactDetails/ns1:Email
                    return
                        <ns0:EmailAddress>{ data($Email) }</ns0:EmailAddress>
                }
                {
                    for $Surname in $verifyContactRequest/ns1:ContactDetails/ns1:Surname
                    return
                        <ns0:Surname>{ data($Surname) }</ns0:Surname>
                }
                {
                    for $BirthDate in $verifyContactRequest/ns1:ContactDetails/ns1:BirthDate
                    return
                        <ns0:BirthDate>{ xf:dateToString(xs:date($BirthDate)) }</ns0:BirthDate>
                }
                
                
            </ns0:oInput>
        </ns0:GetDuplicateContacts>
};

declare variable $verifyContactRequest as element(ns1:VerifyContactRequest) external;

xf:CheckDuplicatesReq($verifyContactRequest)
