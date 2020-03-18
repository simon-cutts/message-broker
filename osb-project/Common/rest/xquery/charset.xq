xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Common/rest/xquery/charset/";

declare function xf:charset()
as xs:string {
    'text/xml; charset=utf-8'
};


xf:charset()
