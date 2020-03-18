(:: pragma bea:global-element-return element="ns0:OUGenerateNextPersonalId" location="../../ServiceRepository/Contact/NextNumberGenWS/wsdl/NextNumberGenWS.wsdl" ::)

declare namespace ns0 = "http://csintra6.open.ac.uk/NextNumberGenWS/";
declare namespace xf = "http://tempuri.org/CreateCustomer/xquery/CreateCustomerPI/";

declare function xf:CreateCustomerPI($dbname as xs:string)
    as element(ns0:OUGenerateNextPersonalId) {
        <ns0:OUGenerateNextPersonalId>
            <ns0:strDBName>{ $dbname }</ns0:strDBName>
        </ns0:OUGenerateNextPersonalId>
};

declare variable $dbname as xs:string external;

xf:CreateCustomerPI($dbname)
