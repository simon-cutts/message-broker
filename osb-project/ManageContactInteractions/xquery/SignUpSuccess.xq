(:: pragma bea:global-element-parameter parameter="$signUpEnquirerResponse" element="ns1:SignUpEnquirerResponse" location="../../ServiceRepository/Utilities/sams/SignUpWS.wsdl" ::)
(:: pragma bea:global-element-return element="ns3:SignUpResponse" location="../../ServiceRepository/Contact/SignUp/xsd/SignUp.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns3 = "http://open.ac.uk/Contact/SignUp";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/SignUpSuccess/";

declare function xf:SignUpSuccess($signUpEnquirerResponse as element(ns1:SignUpEnquirerResponse))
    as element(ns3:SignUpResponse) {
        <ns3:SignUpResponse>
            <ns3:SignUpResult>
                <ns3:Success>{ data($signUpEnquirerResponse/ns1:SignUpEnquirerResult/ns1:Successful) }</ns3:Success>
                {
                    for $Oucu in $signUpEnquirerResponse/ns1:SignUpEnquirerResult/ns1:Oucu
                    return
                        <ns3:Oucu>{ data($Oucu) }</ns3:Oucu>
                }
            </ns3:SignUpResult>
        </ns3:SignUpResponse>
};

declare variable $signUpEnquirerResponse as element(ns1:SignUpEnquirerResponse) external;

xf:SignUpSuccess($signUpEnquirerResponse)
