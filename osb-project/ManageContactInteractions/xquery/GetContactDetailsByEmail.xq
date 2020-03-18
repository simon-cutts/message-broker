(:: pragma bea:global-element-return element="ns0:GetContactByDetails" location="../../ServiceRepository/Contact/OUVoiceGetContact/wsdl/OUVoiceGetContactV2.0.wsdl" ::)

declare namespace ns0 = "http://www.open.ac.uk/voice/webservices/ouvoicegetcontactws";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/GetContactDetailsByEmail/";

declare function xf:GetContactDetailsByEmail($firstname as xs:string,
    $lastname as xs:string,
    $emailId as xs:string)
    as element(ns0:GetContactByDetails) {
        <ns0:GetContactByDetails>
            <ns0:oInput>
                <ns0:FirstName>{ $firstname }</ns0:FirstName>
                <ns0:LastName>{ $lastname }</ns0:LastName>
                <ns0:EmailAddress>{ $emailId }</ns0:EmailAddress>
            </ns0:oInput>
        </ns0:GetContactByDetails>
};

declare variable $firstname as xs:string external;
declare variable $lastname as xs:string external;
declare variable $emailId as xs:string external;

xf:GetContactDetailsByEmail($firstname,
    $lastname,
    $emailId)
