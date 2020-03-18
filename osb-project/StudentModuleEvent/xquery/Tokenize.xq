(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/ManageSttAllocation/xquery/Tokenize/";

(: Create an Items object from a tokenized string of registration details 

   Author: Simon Cutts :)
   
declare function xf:Tokenize($tokens as xs:string?)
    as element(*)? {
    
    	let $clean := fn:normalize-space($tokens)
    	return
    	if (string-length($clean) > 0) then
	        <Items>{
	 		for $t in tokenize($clean,",")
	 		return <Item>{$t}</Item>
			}</Items>
		else ()
};

declare variable $tokens as xs:string? external;

xf:Tokenize($tokens)