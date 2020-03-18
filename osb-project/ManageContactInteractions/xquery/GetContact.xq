(:: pragma bea:global-element-return element="ns0:GetContact" location="../../ServiceRepository/Contact/OUVoiceGetContact/wsdl/OUVoiceGetContactV2.0.wsdl" ::)

declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/ouvoicegetcontactws";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/GetContact/";

declare function xf:GetContact($customerPI as xs:string)
    as element(ns0:GetContact) {
        <ns0:GetContact>
            <ns0:PersonalIDs>
                <ns0:string>{ $customerPI }</ns0:string>
            </ns0:PersonalIDs>
        </ns0:GetContact>
};

declare variable $customerPI as xs:string external;

xf:GetContact($customerPI)
