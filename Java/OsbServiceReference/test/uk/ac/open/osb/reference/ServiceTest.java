package uk.ac.open.osb.reference;

import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class ServiceTest {

	private static final ResourceFactory SERVICE_FACTORY = ResourceFactory
			.getInstance();

	// @Test
	// public void testReferenceHierarchy() {
	// Service s1 = SERVICE_FACTORY.get("ProxyA");
	// Service b1 = s1.ref("Biz1");
	// Service b2 = s1.ref("Biz2");
	//
	// Service s2 = s1.ref("ProxyB");
	// Service b3 = s2.ref("Biz3");
	//
	// Service s3 = s1.ref("ProxyC");
	// Service b4 = s3.ref("Biz4");
	//
	// Service s4 = SERVICE_FACTORY.get("ProxyB-A");
	// Service b5 = s4.ref("Biz5");
	// s2.ref("ProxyB-A");
	//
	// System.out.println(s1);
	//
	// // String result = "ProxyA\n" +
	// // "  Biz1\n" +
	// // "  Biz2\n" +
	// // "  ProxyB\n" +
	// // "    Biz3\n" +
	// // "    ProxyB-A\n" +
	// // "      Biz5\n" +
	// // "  ProxyC\n" +
	// // "    Biz4";
	//
	// // Assert.assertEquals(result, s1);
	// }
	//
	// @Test
	// public void testReferenceByHierarchy() {
	// Service s1 = SERVICE_FACTORY.get("ProxyA");
	// Service b1 = s1.ref("Biz1");
	// Service b2 = s1.ref("Biz2");
	//
	// Service s2 = s1.ref("ProxyB");
	// Service b3 = s2.ref("Biz3");
	//
	// Service s3 = s1.ref("ProxyC");
	// Service b4 = s3.ref("Biz4");
	//
	// Service s4 = SERVICE_FACTORY.get("ProxyB-A");
	// Service b5 = s4.ref("Biz5");
	// s2.ref("ProxyB-A");
	//
	// Service sx = SERVICE_FACTORY.get("Proxy1");
	// sx.ref("ProxyA");
	//
	// System.out.println(b1.printRefBy());
	// }
	//
	// @Test
	// public void testJarEntry() {
	// Service s1 = SERVICE_FACTORY
	// .get("CamelMsgReceiver/proxy/CamelMsgReceiver.ProxyService");
	// Assert.assertEquals(s1.getName(),
	// "CamelMsgReceiver/proxy/CamelMsgReceiver");
	// Service s2 = SERVICE_FACTORY
	// .get("CamelMsgReceiver/biz/MessageReceiver.BusinessService");
	// Assert.assertEquals(s2.getName(),
	// "CamelMsgReceiver/biz/MessageReceiver");
	// }

}
