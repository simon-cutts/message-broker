xquery version "1.0" encoding "Cp1252";

(: ServiceTier configuraion XML with embedded XQuery. Uses a key of the proxy service to retrieve
   its tier number. The URL portion of the XML is to confirm the proxy service name is correct. 
   
   The default is 4, if a tier is different to the default, then the service should be added below

   Author: Simon Cutts :)

declare namespace xf = "http://tempuri.org/CommonConfig/resources/xquery/ServiceTier/";

declare function xf:Xml()
    as element(*) {
    <Services>
		<Service>
			<Proxy>CallMeBack</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/CallMeBack/1.0</Url>
		</Service>
		<Service>
			<Proxy>GetCustomer</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/GetCustomer/2.0</Url>
		</Service>
		<Service>
			<Proxy>UpdateContact</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/UpdateContact/2.0</Url>
		</Service>
		<Service>
			<Proxy>ContactRequestProspectus</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/RequestProspectus/1.0</Url>
		</Service>
		<Service>
			<Proxy>UpdateCustomerInteraction</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/UpdateCustomerInteraction/1.0</Url>
		</Service>
		<Service>
			<Proxy>UpdateCustomer</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/UpdateCustomer/1.0</Url>
		</Service>
		<Service>
			<Proxy>SignUp</Proxy>
			<Tier>2</Tier>
			<Url>/osb/Contact/SignUp/1.0</Url>
		</Service>
		<Service>
			<Proxy>ContactFulfilmentListener</Proxy>
			<Tier>2</Tier>
			<Url></Url>
		</Service>
		<Service>
			<Proxy>ContactInteractionsListener</Proxy>
			<Tier>2</Tier>
			<Url></Url>
		</Service>
		<Service>
			<Proxy>ContactProspectListener</Proxy>
			<Tier>2</Tier>
			<Url></Url>
		</Service>	
		<Service>
			<Proxy>WeedInteractionListener</Proxy>
			<Tier>2</Tier>
			<Url></Url>
		</Service>		
   </Services>
};

(: Get the service tier, return None if no tier found :)
declare function xf:ServiceTier($proxy as xs:string)
    as xs:string {
	let $tier := xf:GetTier($proxy)
	return
	if (exists($tier)) then 
    	$tier
    else
    	"4"
};

(: Read the XML to get the tier, matching on proxy :)
declare function xf:GetTier($proxy as xs:string)
    as xs:string? {
 	
	for $p in xf:Xml()/Service
	where $p/Proxy = $proxy	
	return $p/Tier
};

declare variable $proxy as xs:string external;

xf:ServiceTier($proxy)