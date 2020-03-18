(:: pragma bea:global-element-return element="ns0:StudentRegisteredProducts" location="../../ServiceRepository/Student/StudentRegisteredProduct/wsdl/StudentRegisteredProduct.wsdl" ::)

declare namespace ns0 = "http://www.open.ac.uk/OU.VantageSST";
declare namespace xf = "http://tempuri.org/ManageSttAllocation/xquery/StudentRegisteredProducts/";

(: Create the the StudentRegisteredProducts request 

   Author: Simon Cutts :)
   
declare function xf:StudentRegisteredProducts($personalId as xs:string)
    as element(ns0:StudentRegisteredProducts) {
        <ns0:StudentRegisteredProducts>
            <ns0:sPersonalId>{ $personalId }</ns0:sPersonalId>
            <ns0:sUserId>{ $personalId }</ns0:sUserId>
        </ns0:StudentRegisteredProducts>
};

declare variable $personalId as xs:string external;

xf:StudentRegisteredProducts($personalId)