(:: pragma bea:global-element-return element="ns1:UpdateContactInteractionResponse" location="../../ServiceRepository/Contact/UpdateCustomerInteraction/xsd/UpdateCustomerInteraction.1.0.xsd" ::)

declare namespace ns2 = "http://open.ac.uk/schema/ResponseHeader";
declare namespace ns1 = "http://open.ac.uk/Contact/UpdateCustomerInteraction";
declare namespace ns0 = "http://open.ac.uk/schema/faults";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/UpsertContactInteractionRes/";

declare function xf:UpsertContactInteractionRes()
as element(ns1:UpdateContactInteractionResponse) {
    <ns1:UpdateContactInteractionResponse>
        <ns1:UpdateContactInteractionResult>
            <ns1:Success>Success</ns1:Success>
        </ns1:UpdateContactInteractionResult>
    </ns1:UpdateContactInteractionResponse>
};


xf:UpsertContactInteractionRes()