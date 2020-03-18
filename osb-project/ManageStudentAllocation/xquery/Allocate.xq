xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/ManageStudentAllocation/xquery/Allocate/";

(: Determine if this is an allocation or de-allocation event. If allocation then return true, de-allocation
   return false
   
   
   
   Author: Simon Cutts :)

declare function xf:Allocate($productType as xs:string,
    $studentProductStatus as xs:string)
    as xs:boolean {
    
    (: If Qualification .... :)
    
    (: Lakshmi - Added new conditions for Qualification and StudentProductStatus .... :)
    if ( (upper-case($productType) = 'QUALIFICATION') and (upper-case($studentProductStatus) = 'R')  ) then
        	xs:boolean('true')
    else 
        if ( (upper-case($productType) = 'QUALIFICATION') and ( (upper-case($studentProductStatus) = 'D') or (upper-case($studentProductStatus) = 'DEALLOC')  ) ) then
        	xs:boolean('false')
        	 
    (: .. otherwise Module :)  	
    else
   		if (upper-case($studentProductStatus) = 'JA') then
    		xs:boolean('true')
    		
   		else if (upper-case($studentProductStatus) = 'PA') then
    		xs:boolean('true')

   		else if (upper-case($studentProductStatus) = 'JD') then
    		xs:boolean('true')
    		    		
    		(: All other studentProductStatus for Module treated as dealloction: JK, JU, PK, PU, XX, XY :)
    	else (: studentProductStatus = C :)
    		xs:boolean('false')  
};

declare variable $productType as xs:string external;
declare variable $studentProductStatus as xs:string external;

xf:Allocate($productType,
    $studentProductStatus)
