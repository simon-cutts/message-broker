(:: pragma bea:global-element-parameter parameter="$signUpRequest" element="ns4:SignUpRequest" location="../../ServiceRepository/Contact/SignUp/xsd/SignUp.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SignUpEnquirer" location="../../ServiceRepository/Utilities/sams/SignUpWS.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns4 = "http://open.ac.uk/Contact/SignUp";
declare namespace ns3 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/SignUpEnquirer/";

declare function xf:SignUpEnquirer($signUpRequest as element(ns4:SignUpRequest))
    as element(ns0:SignUpEnquirer) {
        <ns0:SignUpEnquirer>
            <ns0:inputs>
                <ns0:EmailAddress>{ data(lower-case($signUpRequest/ns4:CustomerDetails/ns2:Email)) }</ns0:EmailAddress>
                {
                    for $Password in $signUpRequest/ns4:CustomerDetails/ns2:Password
                    return
                        <ns0:Password>{ data($Password) }</ns0:Password>
                }
                <ns0:Forenames>{ data($signUpRequest/ns4:CustomerDetails/ns2:Forename) }</ns0:Forenames>
                <ns0:Surname>{ data($signUpRequest/ns4:CustomerDetails/ns2:Surname) }</ns0:Surname>
                {
        			for $CountryCode in $signUpRequest/ns4:CustomerDetails/ns2:CountryCode
        			return
        			<ns0:CountryCode>
        			{
        				if (($CountryCode = 'WA') or ($CountryCode = 'EN') or ($CountryCode = 'NI') or ($CountryCode = 'SC') or ($CountryCode = 'CHA') or ($CountryCode = 'IOM') )
	        			then 
	           				'GB'
	            		else 
	            		    data($CountryCode)
	           		 }
	                 </ns0:CountryCode>
	
				}
                <ns0:CustomerState>{ data($signUpRequest/ns4:CustomerDetails/ns2:ContactType) }</ns0:CustomerState>
            </ns0:inputs>
        </ns0:SignUpEnquirer>
};

declare variable $signUpRequest as element(ns4:SignUpRequest) external;

xf:SignUpEnquirer($signUpRequest)
