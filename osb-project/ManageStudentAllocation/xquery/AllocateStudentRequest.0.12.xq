(:: pragma bea:global-element-parameter parameter="$manageStudentSSTAllocationRequest" element="ns5:ManageStudentSSTAllocationRequest" location="../../ServiceRepository/Composed/Student/ManageStudentAllocations/xsd/ManageStudentSSTAllocation.0.6.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$studentRegisteredProductsResponse" element="ns1:StudentRegisteredProductsResponse" location="../../ServiceRepository/Student/StudentRegisteredProduct/wsdl/StudentRegisteredProduct.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$productIds" element="ns0:ProductIds" location="../xsd/ProductId.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$linkedProductIds" element="ns0:ProductIds" location="../xsd/ProductId.xsd" ::)
(:: pragma bea:global-element-return element="ns3:AllocateStudentToSSTRequest" location="../../ServiceRepository/Student/AllocateStudentToSST/xsd/AllocateStudentToSST.0.12.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns1 = "http://www.open.ac.uk/OU.VantageSST";
declare namespace ns4 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/Student/AllocateStudentToSST";
declare namespace ns0 = "http://open.ac.uk/curriculum/ProductId/";
declare namespace ns5 = "http://open.ac.uk/Student/ManageStudentSSTAllocation";
declare namespace xf = "http://tempuri.org/ManageStudentAllocation/xquery/AllocateStudentRequest/";

(: Create an AllocateStudentRequest
   
   Author: Simon Cutts :)
declare function xf:AllocateStudentRequest($manageStudentSSTAllocationRequest as element(ns5:ManageStudentSSTAllocationRequest),
    $studentRegisteredProductsResponse as element(ns1:StudentRegisteredProductsResponse)?,
    $productIds as element(ns0:ProductIds)?,
    $linkedProductIds as element(ns0:ProductIds)?,
    $allocatedProductId as xs:string)
    as element(ns3:AllocateStudentToSSTRequest) {
        <ns3:AllocateStudentToSSTRequest>
            {
                let $RequestHeader := $manageStudentSSTAllocationRequest/ns5:RequestHeader
                return
                    <ns3:RequestHeader>
                        <ns2:id>{ data($RequestHeader/ns2:id) }</ns2:id>
                        {
                            for $source in $RequestHeader/ns2:source
                            return
                                <ns2:source>{ data($source) }</ns2:source>
                        }
                        {
                            for $user in $RequestHeader/ns2:user
                            return
                                <ns2:user>{ $user/@* , $user/node() }</ns2:user>
                        }
                    </ns3:RequestHeader>
            }
            <ns3:Student>
                <ns3:personalId>{ data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:personalId) }</ns3:personalId>
                <ns3:regionCode>{ data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:regionCode) }</ns3:regionCode>
                <ns3:marketingSubject>{ data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:marketingSubject) }</ns3:marketingSubject>
                <ns3:studyGoalCode>{ data($studentRegisteredProductsResponse/ns1:StudentRegisteredProductsResult/ns1:StudGoalCode) }</ns3:studyGoalCode>
                <ns3:AllocatedProduct>
                    <ns3:productId>{ $allocatedProductId }</ns3:productId>
                    <ns3:productType>{ lower-case(data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:productType)) }</ns3:productType>
                    <ns3:statusChangeDate>{ data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:statusChangeDate) }</ns3:statusChangeDate>
                    <ns3:productStatus>{ xf:productStatus(data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:studentProductStatus)) }</ns3:productStatus>
                    <ns3:productCode>{ data($manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:productCode) }</ns3:productCode>
                    {
                        for $transitionalQualStatus in $manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:transitionalQualStatus
                        return
                            <ns3:transitionalQualStatus>{ data($transitionalQualStatus) }</ns3:transitionalQualStatus>
                    }
                    {
                        for $qualificationLevel in $manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:qualificationLevel
                        return
                            <ns3:qualificationLevel>{ data($qualificationLevel) }</ns3:qualificationLevel>
                    }
                    {
                        for $LinkedProduct at $los in $manageStudentSSTAllocationRequest/ns5:RequestDetails/ns5:Product/ns5:LinkedProduct
                        return
                            <ns3:LinkedProduct>
                                <ns3:productId>{ data($linkedProductIds/productId[$los]) }</ns3:productId>
                                <ns3:statusChangeDate>{ data($LinkedProduct/ns5:statusChangeDate) }</ns3:statusChangeDate>
                            </ns3:LinkedProduct>
                    }
                </ns3:AllocatedProduct>
                {
                    for $Product at $pos in $studentRegisteredProductsResponse/ns1:StudentRegisteredProductsResult/ns1:Products/ns1:Product
                    return
                        <ns3:RegisteredProduct>
                            <ns3:registrationDate>{ xf:dateTime(data($Product/ns1:RegistrationDate)) }</ns3:registrationDate>
                            {
                                for $TransitionalQualStatus in $Product/ns1:TransitionalQualStatus
                                return
                                    <ns3:transitionalQualStatus>{ data($TransitionalQualStatus) }</ns3:transitionalQualStatus>
                            }
                            {
                            	if (string-length($Product/ns1:CompletionDate) > 0) then 
                            		<ns3:completionDate>{ xf:dateTime(data($Product/ns1:CompletionDate)) }</ns3:completionDate>
                            	else ""
                            }
                            <ns3:Product>
                            	<ns3:productId>{ data($productIds/productId[$pos]) }</ns3:productId>
                                <ns3:productType>{ lower-case(data($Product/ns1:ProductType)) }</ns3:productType>
                                <ns3:productCode>{ data($Product/ns1:ProductCode) }</ns3:productCode>
                                {
                                    for $QualificationLevel in $Product/ns1:QualificationLevel
                                    return
                                        <ns3:qualificationLevel>{ data($QualificationLevel) }</ns3:qualificationLevel>
                                }
                            </ns3:Product>
                        </ns3:RegisteredProduct>
                }
            </ns3:Student>
        </ns3:AllocateStudentToSSTRequest>
};


(: Convert an xs:string of a date into an xs:dateTime of format CCYY-MM-DDThh:mm:ss. Expects the xs:string date to look
   like '04-Apr-2012 16:07:07'  :)
   
declare function xf:dateTime($date as xs:string)
    as xs:dateTime? {
    
    let $trimmed := fn-bea:trim-left(fn-bea:trim-right($date))
    
    return
    if (string-length($trimmed) > 0) then
	    let $day := substring($trimmed,1,2)
	    let $month := xf:month(substring($trimmed,4,3))
	    let $year := substring($trimmed,8,4)
	    let $time := substring($trimmed,13,8)
   		return xs:dateTime(concat($year,"-",$month,"-",$day,"T", $time))
    
    else()
};

(: Convert an xs:string of a month into its number, i.e. Jan into 01, Dec into 12 :)

declare function xf:month($month as xs:string)
    as xs:string {
    if ($month = 'Jan') 
    	then "01"
    else if ($month = 'Feb') 
    	then "02"
    else if ($month = 'Mar') 
    	then "03"
    else if ($month = 'Apr') 
    	then "04"
    else if ($month = 'May') 
    	then "05"
    else if ($month = 'Jun') 
    	then "06"
    else if ($month = 'Jul') 
    	then "07"
    else if ($month = 'Aug') 
    	then "08"
    else if ($month = 'Sep') 
    	then "09"
    else if ($month = 'Oct') 
    	then "10"
    else if ($month = 'Nov') 
    	then "11"
    else
        "12"    
};

declare function xf:productStatus($status as xs:string)
    as xs:string {
    if ($status = 'PA' or $status = 'R') 
    	then "Registered"
    else
        "Reserved"
    
};

declare variable $manageStudentSSTAllocationRequest as element(ns5:ManageStudentSSTAllocationRequest) external;
declare variable $studentRegisteredProductsResponse as element(ns1:StudentRegisteredProductsResponse)? external;
declare variable $productIds as element(ns0:ProductIds)? external;
declare variable $linkedProductIds as element(ns0:ProductIds)? external;
declare variable $allocatedProductId as xs:string external;

xf:AllocateStudentRequest($manageStudentSSTAllocationRequest,
    $studentRegisteredProductsResponse,
    $productIds,
    $linkedProductIds,
    $allocatedProductId)