(:: pragma bea:global-element-parameter parameter="$getAvailableTutor" element="ns2:GetAvailableTutor" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$getAvailableTutorByIdRequest" element="ns2:GetAvailableTutorByIdRequest" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns2:GetAvailableTutorRequest" location="../../ServiceRepository/Student/GetAvailableTutors/xsd/GetAvailableTutors.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/soa/Student/GetAvailableTutors";
declare namespace ns1 = "http://open.ac.uk/schema/BaseType";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/GetAvailableTutors/xquery/GetAvailableTutorsReq/";

declare function xf:GetAvailableTutorsReq($getAvailableTutor as element(ns2:GetAvailableTutor),
    $getAvailableTutorByIdRequest as element(ns2:GetAvailableTutorByIdRequest))
    as element(ns2:GetAvailableTutorRequest) {
        <ns2:GetAvailableTutorRequest>
            <ns2:RequestHeader>
                <ns0:id>{ data($getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:id) }</ns0:id>
                {
                    for $source in $getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:source
                    return
                        <ns0:source>{ data($source) }</ns0:source>
                }
                {
                    for $user in $getAvailableTutorByIdRequest/ns2:RequestHeader/ns0:user
                    return
                        <ns0:user>{ $user/@* , $user/node() }</ns0:user>
                }
            </ns2:RequestHeader>
            <ns2:GetAvailableTutor>
                <ns2:moduleCode>{ data($getAvailableTutor/ns2:moduleCode) }</ns2:moduleCode>
                <ns2:presentationCode>{ data($getAvailableTutor/ns2:presentationCode) }</ns2:presentationCode>
            </ns2:GetAvailableTutor>
        </ns2:GetAvailableTutorRequest>
};

declare variable $getAvailableTutor as element(ns2:GetAvailableTutor) external;
declare variable $getAvailableTutorByIdRequest as element(ns2:GetAvailableTutorByIdRequest) external;

xf:GetAvailableTutorsReq($getAvailableTutor,
    $getAvailableTutorByIdRequest)
