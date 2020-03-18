(:: pragma bea:global-element-parameter parameter="$getAvailableTutorResponse" element="ns2:GetAvailableTutorResponse" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns2:GetAvailableTutorResponse" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/soa/Student/GetAvailableTutors";
declare namespace ns1 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/GetAvailableTutors/xquery/GetAvailableTutorsRes/";

declare function xf:GetAvailableTutorsRes($getAvailableTutorResponse as element(ns2:GetAvailableTutorResponse))
    as element(ns2:GetAvailableTutorResponse) {
        <ns2:GetAvailableTutorResponse>
            <ns2:ResponseHeader>
                <ns1:id>{ data($getAvailableTutorResponse/ns2:ResponseHeader/ns1:id) }</ns1:id>
                {
                    for $fault in $getAvailableTutorResponse/ns2:ResponseHeader/ns1:fault
                    return
                        <ns1:fault>{ $fault/@* , $fault/node() }</ns1:fault>
                }
            </ns2:ResponseHeader>
            {
                for $AvailableTutors in $getAvailableTutorResponse/ns2:AvailableTutors
                return
                    <ns2:AvailableTutors>
                        <ns2:staffId>{ data($AvailableTutors/ns2:staffId) }</ns2:staffId>
                        <ns2:surname>{ data($AvailableTutors/ns2:surname) }</ns2:surname>
                        <ns2:initials>{ data($AvailableTutors/ns2:initials) }</ns2:initials>
                        <ns2:appointmentNumber>{ data($AvailableTutors/ns2:appointmentNumber) }</ns2:appointmentNumber>
                        <ns2:presentationPattern>{ data($AvailableTutors/ns2:presentationPattern) }</ns2:presentationPattern>
                        <ns2:region>{ data($AvailableTutors/ns2:region) }</ns2:region>
                        <ns2:appointmentDescription>{ data($AvailableTutors/ns2:appointmentDescription) }</ns2:appointmentDescription>
                        <ns2:roleCode>{ data($AvailableTutors/ns2:roleCode) }</ns2:roleCode>
                    </ns2:AvailableTutors>
            }
        </ns2:GetAvailableTutorResponse>
};

declare variable $getAvailableTutorResponse as element(ns2:GetAvailableTutorResponse) external;

xf:GetAvailableTutorsRes($getAvailableTutorResponse)
