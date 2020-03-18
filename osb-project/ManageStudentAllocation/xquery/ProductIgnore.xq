xquery version "1.0" encoding "Cp1252";

(: ProductIgnore configuraion XML with embedded XQuery. This is a list of products present
   in Planet but not curriculum.

   Returns true if the productCode exists in the XML, false if not. If true then the 
   product should be ignored because it does not exist in curriculum
   
   The XML was saved from an Excel spreasheet as 'XML Spreadsheet 2003' format and then edited
   to remove spurios elements

   Author: Simon Cutts :)

declare namespace xf = "http://tempuri.org/CommonConfig/resources/xquery/ProductIgnore/";

declare function xf:Xml()
    as element(*) {
	 <Worksheet>
	    <Cell>A280</Cell>
	    <Cell>A844</Cell>
	    <Cell>A864</Cell>
	    <Cell>A874</Cell>
	    <Cell>B859</Cell>
	    <Cell>B864</Cell>
	    <Cell>BG003</Cell>
	    <Cell>BG014</Cell>
	    <Cell>BG015</Cell>
	    <Cell>BG016</Cell>
	    <Cell>BG017</Cell>
	    <Cell>BG018</Cell>
	    <Cell>BG019</Cell>
	    <Cell>BG022</Cell>
	    <Cell>BYS834</Cell>
	    <Cell>BYW121</Cell>
	    <Cell>BYW122</Cell>
	    <Cell>BYW201</Cell>
	    <Cell>BYW203</Cell>
	    <Cell>BYW301</Cell>
	    <Cell>BYW322</Cell>
	    <Cell>BYW324</Cell>
	    <Cell>BZR628</Cell>
	    <Cell>BZR629</Cell>
	    <Cell>BZR690</Cell>
	    <Cell>CCPP230</Cell>
	    <Cell>CCPP260</Cell>
	    <Cell>CDDR300</Cell>
	    <Cell>CDDR320</Cell>
	    <Cell>CLUP355</Cell>
	    <Cell>COXR206</Cell>
	    <Cell>COXR305</Cell>
	    <Cell>D800</Cell>
	    <Cell>EE880</Cell>
	    <Cell>EXA881</Cell>
	    <Cell>EXA882</Cell>
	    <Cell>EXA883</Cell>
	    <Cell>EXA884</Cell>
	    <Cell>EXA885</Cell>
	    <Cell>EXAJ885</Cell>
	    <Cell>EXAW885</Cell>
	    <Cell>EXB881</Cell>
	    <Cell>EXB882</Cell>
	    <Cell>EXB883</Cell>
	    <Cell>EXC881</Cell>
	    <Cell>EXC882</Cell>
	    <Cell>EXC883</Cell>
	    <Cell>EXC884</Cell>
	    <Cell>EXC885</Cell>
	    <Cell>EXCJ885</Cell>
	    <Cell>EXCW885</Cell>
	    <Cell>EXD881</Cell>
	    <Cell>EXD882</Cell>
	    <Cell>EXD883</Cell>
	    <Cell>EXF881</Cell>
	    <Cell>EXF882</Cell>
	    <Cell>EXF883</Cell>
	    <Cell>EXG881</Cell>
	    <Cell>EXG882</Cell>
	    <Cell>EXG883</Cell>
	    <Cell>EXG884</Cell>
	    <Cell>EXG885</Cell>
	    <Cell>EXGJ885</Cell>
	    <Cell>EXGW885</Cell>
	    <Cell>EXL881</Cell>
	    <Cell>EXL882</Cell>
	    <Cell>EXL883</Cell>
	    <Cell>EXL884</Cell>
	    <Cell>EXL885</Cell>
	    <Cell>EXLJ885</Cell>
	    <Cell>EXLW885</Cell>
	    <Cell>EXM881</Cell>
	    <Cell>EXM882</Cell>
	    <Cell>EXM883</Cell>
	    <Cell>EXM884</Cell>
	    <Cell>EXM885</Cell>
	    <Cell>EXMJ885</Cell>
	    <Cell>EXMS885</Cell>
	    <Cell>EXMW885</Cell>
	    <Cell>EXN881</Cell>
	    <Cell>EXN882</Cell>
	    <Cell>EXN883</Cell>
	    <Cell>EXN884</Cell>
	    <Cell>EXN885</Cell>
	    <Cell>EXNJ885</Cell>
	    <Cell>EXNW885</Cell>
	    <Cell>EXP380</Cell>
	    <Cell>EXP383</Cell>
	    <Cell>EXP881</Cell>
	    <Cell>EXP882</Cell>
	    <Cell>EXP883</Cell>
	    <Cell>EXP884</Cell>
	    <Cell>EXP885</Cell>
	    <Cell>EXPJ885</Cell>
	    <Cell>EXPW885</Cell>
	    <Cell>EXS880</Cell>
	    <Cell>EXS881</Cell>
	    <Cell>EXS882</Cell>
	    <Cell>EXS883</Cell>
	    <Cell>EXT881</Cell>
	    <Cell>EXT882</Cell>
	    <Cell>EXT883</Cell>
	    <Cell>EXT884</Cell>
	    <Cell>EXT885</Cell>
	    <Cell>EXTJ885</Cell>
	    <Cell>EXTW885</Cell>
	    <Cell>EXX886</Cell>
	    <Cell>GB002</Cell>
	    <Cell>GB003</Cell>
	    <Cell>GB010</Cell>
	    <Cell>GB012</Cell>
	    <Cell>GB079</Cell>
	    <Cell>GB089</Cell>
	    <Cell>GGB002</Cell>
	    <Cell>GGB003</Cell>
	    <Cell>GGB010</Cell>
	    <Cell>GGB012</Cell>
	    <Cell>GGB079</Cell>
	    <Cell>GT099</Cell>
	    <Cell>KG001</Cell>
	    <Cell>KG002</Cell>
	    <Cell>KG003</Cell>
	    <Cell>KG004</Cell>
	    <Cell>MYT362</Cell>
	    <Cell>MYT363</Cell>
	    <Cell>MYT364</Cell>
	    <Cell>SG071</Cell>
	    <Cell>SG072</Cell>
	    <Cell>SG073</Cell>
	    <Cell>SG075</Cell>
	    <Cell>SG076</Cell>
	    <Cell>SG077</Cell>
	    <Cell>SG089</Cell>
	    <Cell>SKG085</Cell>
	    <Cell>SKG095</Cell>
	    <Cell>SS001</Cell>
	    <Cell>STG074</Cell>
	    <Cell>T805</Cell>
	    <Cell>TMYT470</Cell>
	    <Cell>UYS810</Cell>
	    <Cell>XK117</Cell>
	    <Cell>XK236</Cell>
	    <Cell>XK237</Cell>
	    <Cell>XK238</Cell>
	    <Cell>XKPS216</Cell>
	    <Cell>XKPS315</Cell>
	    <Cell>XKPW113</Cell>
	    <Cell>XKPW216</Cell>
	    <Cell>XKPW315</Cell>
	    <Cell>XKYN117</Cell>
	    <Cell>XKYN237</Cell>
	    <Cell>XKYN238</Cell>
	    <Cell>XKYN317</Cell>
	    <Cell>Z999</Cell>
	    <Cell>ZZ888</Cell>
	</Worksheet>
};

(: Return true if the productCode found, false if not :)
declare function xf:ProductIgnore($productCode as xs:string)
    as xs:boolean {
	exists(xf:Xml()//*[text() = $productCode])
};

declare variable $productCode as xs:string external;

xf:ProductIgnore($productCode)