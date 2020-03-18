(:: pragma bea:global-element-return element="ns0:ProductIds" location="../xsd/ProductId.xsd" ::)

declare namespace ns0 = "http://open.ac.uk/curriculum/ProductId/";
declare namespace xf = "http://tempuri.org/ManageSttAllocation/xquery/ProductId/";

(: Create a ProductIds object from a tokenized string of productIds 

   Author: Simon Cutts :)
   
declare function xf:ProductId($tokens as xs:string?)
    as element(ns0:ProductIds)? {
    
    	if (string-length($tokens) > 0) then
	        <ns0:ProductIds>{
	 		for $t in tokenize($tokens,"/")
	 		return <productId>{$t}</productId>
			}</ns0:ProductIds>
		else ()
};

declare variable $tokens as xs:string? external;

xf:ProductId($tokens)