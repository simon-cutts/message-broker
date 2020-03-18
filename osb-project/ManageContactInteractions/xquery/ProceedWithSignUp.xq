(:: pragma bea:global-element-parameter parameter="$getContactByDetailsResponse" element="ns0:GetContactByDetailsResponse" location="../../ServiceRepository/Contact/OUVoiceGetContact/wsdl/OUVoiceGetContactV2.0.wsdl" ::)

declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/ouvoicegetcontactws";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/CheckOucuExists/";

declare function xf:CheckOucuExists($getContactByDetailsResponse as element(ns0:GetContactByDetailsResponse))
    as xs:string {
        
        for $Ocucu in fn:string-join($getContactByDetailsResponse/ns0:GetContactByDetailsResult/ns0:Contacts/ns0:GetContactOutputArgDetails/ns0:OUComputerUserName,',')
        return
            if (fn:string-length($Ocucu) > 0) then
           		'No'
 			else
                'Yes'	
                 	
};

declare variable $getContactByDetailsResponse as element(ns0:GetContactByDetailsResponse) external;

xf:CheckOucuExists($getContactByDetailsResponse)
