(:: pragma bea:global-element-parameter parameter="$updateContactInteractionRequest" element="ns2:UpdateContactInteractionRequest" location="../../ServiceRepository/Contact/UpdateCustomerInteraction/xsd/UpdateCustomerInteraction.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns0:UpdateCustomerRequest" location="../../ServiceRepository/Contact/OUVoiceUpsertContact/xsd/UpdateCustomer.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/Contact/UpdateCustomerInteraction";
declare namespace ns1 = "http://open.ac.uk/schema/RequestHeader";
declare namespace ns4 = "http://open.ac.uk/schema/BaseType";
declare namespace ns3 = "http://open.ac.uk/Contact/GetCustomer";
declare namespace ns0 = "http://open.ac.uk/Contact/UpdateCustomer";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/MapContactInteractionToUpdateContact/";

declare function xf:MapContactInteractionToUpdateContact($updateContactInteractionRequest as element(ns2:UpdateContactInteractionRequest))
    as element(ns0:UpdateCustomerRequest) {
        <ns0:UpdateCustomerRequest>
            {
                let $RequestHeader := $updateContactInteractionRequest/ns2:RequestHeader
                return
                    <ns0:RequestHeader>{ $RequestHeader/@* , $RequestHeader/node() }</ns0:RequestHeader>
            }
            {
                let $Customer := $updateContactInteractionRequest/ns2:Customer
                return
                    <ns0:Customer>{ $Customer/@* , $Customer/node() }</ns0:Customer>
                    
            }
        </ns0:UpdateCustomerRequest>
};

declare variable $updateContactInteractionRequest as element(ns2:UpdateContactInteractionRequest) external;

xf:MapContactInteractionToUpdateContact($updateContactInteractionRequest)