(:: pragma bea:global-element-parameter parameter="$studentRegisteredProductsResponse" element="ns0:StudentRegisteredProductsResponse" location="../../ServiceRepository/Student/StudentRegisteredProduct/wsdl/StudentRegisteredProduct.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:StudentRegisteredProductsResponse" location="../../ServiceRepository/Student/StudentRegisteredProduct/wsdl/StudentRegisteredProduct.wsdl" ::)

declare namespace ns0 = "http://www.open.ac.uk/OU.VantageSST";
declare namespace xf = "http://tempuri.org/ManageStudentAllocation/xquery/FilterStudentRegisteredProductsResult/";

(: Filter StudentRegisteredProductsResult so that only products without a completion date are
   retuend
   
   Author: Simon Cutts :)
   
declare function xf:FilterStudentRegisteredProductsResult($studentRegisteredProductsResponse as element(ns0:StudentRegisteredProductsResponse))
    as element(ns0:StudentRegisteredProductsResponse) {
        <ns0:StudentRegisteredProductsResponse>
            <ns0:StudentRegisteredProductsResult>
                <ns0:Status>{ data($studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:Status) }</ns0:Status>
                <ns0:AppState>{ data($studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:AppState) }</ns0:AppState>
                {
                    for $ErrorMessage in $studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:ErrorMessage
                    return
                        <ns0:ErrorMessage>{ data($ErrorMessage) }</ns0:ErrorMessage>
                }
                {
                    for $Products in $studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:Products
                    return
                        <ns0:Products>
                            {
                                for $Product in $Products/ns0:Product
                                where (string-length($Product/ns0:CompletionDate) <= 0)
                                return
                                    <ns0:Product>{ $Product/@* , $Product/node() }</ns0:Product>
                            }
                        </ns0:Products>
                }
                <ns0:ProductCount>{ data($studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:ProductCount) }</ns0:ProductCount>
                {
                    for $StudGoalCode in $studentRegisteredProductsResponse/ns0:StudentRegisteredProductsResult/ns0:StudGoalCode
                    return
                        <ns0:StudGoalCode>{ data($StudGoalCode) }</ns0:StudGoalCode>
                }
            </ns0:StudentRegisteredProductsResult>
        </ns0:StudentRegisteredProductsResponse>
};

declare variable $studentRegisteredProductsResponse as element(ns0:StudentRegisteredProductsResponse) external;

xf:FilterStudentRegisteredProductsResult($studentRegisteredProductsResponse)
