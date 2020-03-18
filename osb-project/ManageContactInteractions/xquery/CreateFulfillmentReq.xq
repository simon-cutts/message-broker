(:: pragma bea:global-element-parameter parameter="$CreateCustomerProspectRequest" element="ns3:CreateCustomerProspectRequest" location="../../ServiceRepository/Contact/CreateCustomerProspect/xsd/CreateCustomerProspect.1.0.xsd" ::)
(:: pragma bea:global-element-return element="ns1:SubmitMsg" location="../../ServiceRepository/Contact/CamelMsgReceiver/wsdl/messagereceiver1.1.wsdl" ::)

declare namespace ns2 = "http://open.ac.uk/schema/BaseType";
declare namespace ns1 = "http://open.ac.uk/EMessaging/MsgReceiver";
declare namespace ns3 = "http://open.ac.uk/Contact/CreateCustomerProspect";
declare namespace ns0 = "http://open.ac.uk/schema/RequestHeader";
declare namespace xf = "http://tempuri.org/ManageContactInteractions/xquery/CreateFulfillmentReq/";
 
 

declare function strip-namespace($inputRequest  as element()) as element()
{
		element {xs:QName(local-name($inputRequest ))}
		{
				for $child in $inputRequest /(@*,node())
				return
					if ($child instance of element())
						then strip-namespace($child)
					else $child
		}
};

declare function xf:CreateFulfillmentReq($CreateCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest))
    as element(ns1:SubmitMsg) {
        
         let $Documents := fn-bea:serialize(strip-namespace($CreateCustomerProspectRequest/ns3:CustomerDetails/ns3:documents))
         return       
            
        <ns1:SubmitMsg>
            <ns1:sMsgCode>INTPROSE</ns1:sMsgCode>
            <ns1:eMsgRecipientRoleCode>Interaction</ns1:eMsgRecipientRoleCode>
            {
                for $InteractionId in $CreateCustomerProspectRequest/ns3:CustomerDetails/ns3:InteractionId
                return
                    <ns1:sMsgRecipientId>{ data($InteractionId) }</ns1:sMsgRecipientId>
            }
            <ns1:sMsgData>{ concat("<Message><MessageData>",$Documents,"</MessageData ></Message>") } </ns1:sMsgData> 
            <ns1:sMsgDataType>X</ns1:sMsgDataType>
            <ns1:eMsgSourceOfData>Mixed</ns1:eMsgSourceOfData>
            <ns1:sMsgUserMailingRef>Request a Prospectus</ns1:sMsgUserMailingRef>
            <ns1:iMsgMailingId>0</ns1:iMsgMailingId>
            <ns1:sGroupMailingInd>N</ns1:sGroupMailingInd>
            <ns1:sCreatedByLocnCode>COMC</ns1:sCreatedByLocnCode>
            <ns1:sCreatedByUserId>soa</ns1:sCreatedByUserId>
            <ns1:sUserId>soa</ns1:sUserId>
        </ns1:SubmitMsg>
};

declare variable $CreateCustomerProspectRequest as element(ns3:CreateCustomerProspectRequest) external;

xf:CreateFulfillmentReq($CreateCustomerProspectRequest)
