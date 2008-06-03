From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: i2c: Documentation: fix device matching description
Date: Tue, 03 Jun 2008 17:47:12 +0100
Message-ID: <20080603164711.843849539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-i2c-documentation-idtable.patch
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The matching process described for new style clients in
Documentation/i2c/writing-clients is classed as out-of-date
as it requires the presence of an .id_table entry in the
driver's i2c_driver entry.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-rc4-quilt3/Documentation/i2c/writing-clients
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/Documentation/i2c/writing-clients	2008-06-03 17:31:39.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/Documentation/i2c/writing-clients	2008-06-03 17:37:29.000000000 +0100
@@ -25,12 +25,23 @@ routines, and should be zero-initialized
 provide.  A client structure holds device-specific information like the
 driver model device node, and its I2C address.
 
+/* iff driver uses driver model ("new style") binding model: */
+
+static struct i2c_device_id foo_idtable[] = {
+	{ "foo", my_id_for_foo },
+	{ "bar", my_id_for_bar },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, foo_idtable);
+
 static struct i2c_driver foo_driver = {
 	.driver = {
 		.name	= "foo",
 	},
 
 	/* iff driver uses driver model ("new style") binding model: */
+	.id_table	= foo_ids,
 	.probe		= foo_probe,
 	.remove		= foo_remove,
 
@@ -173,10 +184,15 @@ handle may be used during foo_probe().  
 (zero not a negative status code) it may save the handle and use it until
 foo_remove() returns.  That binding model is used by most Linux drivers.
 
-Drivers match devices when i2c_client.driver_name and the driver name are
-the same; this approach is used in several other busses that don't have
-device typing support in the hardware.  The driver and module name should
-match, so hotplug/coldplug mechanisms will modprobe the driver.
+Drivers match devices when an entry in the id_table[x].name and the
+device name are the same; this approach is used in several other busses
+that don't have device typing support in the hardware. The driver and
+module name should match, so hotplug/coldplug mechanisms will modprobe
+the driver.
+
+The id argument to the probe function will be the id_table entry matched
+during the probe, so that a device can support more than one flavour of
+similar device.
 
 
 Device Creation (Standard driver model)

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
