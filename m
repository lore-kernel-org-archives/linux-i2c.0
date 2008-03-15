From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
Subject: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
	part 1
Date: Sat, 15 Mar 2008 14:47:16 +0200
Message-ID: <1205585237-21492-3-git-send-email-me@felipebalbi.com>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1205585237-21492-2-git-send-email-me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, David Brownell <david-b-ZKR15rr3LjGsTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Based on David Brownell's patch for tps65010, this patch
starts converting isp1301_omap.c to new-style i2c driver.

Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
---
 drivers/i2c/chips/isp1301_omap.c |   61 +++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index 2a31601..d094b99 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -49,7 +49,8 @@ MODULE_LICENSE("GPL");
 
 struct isp1301 {
 	struct otg_transceiver	otg;
-	struct i2c_client	client;
+	struct i2c_client	*client;
+	struct i2c_client	c;
 	void			(*i2c_release)(struct device *dev);
 
 	int			irq;
@@ -153,25 +154,25 @@ static struct i2c_driver isp1301_driver;
 static inline u8
 isp1301_get_u8(struct isp1301 *isp, u8 reg)
 {
-	return i2c_smbus_read_byte_data(&isp->client, reg + 0);
+	return i2c_smbus_read_byte_data(isp->client, reg + 0);
 }
 
 static inline int
 isp1301_get_u16(struct isp1301 *isp, u8 reg)
 {
-	return i2c_smbus_read_word_data(&isp->client, reg);
+	return i2c_smbus_read_word_data(isp->client, reg);
 }
 
 static inline int
 isp1301_set_bits(struct isp1301 *isp, u8 reg, u8 bits)
 {
-	return i2c_smbus_write_byte_data(&isp->client, reg + 0, bits);
+	return i2c_smbus_write_byte_data(isp->client, reg + 0, bits);
 }
 
 static inline int
 isp1301_clear_bits(struct isp1301 *isp, u8 reg, u8 bits)
 {
-	return i2c_smbus_write_byte_data(&isp->client, reg + 1, bits);
+	return i2c_smbus_write_byte_data(isp->client, reg + 1, bits);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -349,10 +350,10 @@ isp1301_defer_work(struct isp1301 *isp, int work)
 	int status;
 
 	if (isp && !test_and_set_bit(work, &isp->todo)) {
-		(void) get_device(&isp->client.dev);
+		(void) get_device(&isp->client->dev);
 		status = schedule_work(&isp->work);
 		if (!status && !isp->working)
-			dev_vdbg(&isp->client.dev,
+			dev_vdbg(&isp->client->dev,
 				"work item %d may be lost\n", work);
 	}
 }
@@ -1107,7 +1108,7 @@ isp1301_work(struct work_struct *work)
 		/* transfer state from otg engine to isp1301 */
 		if (test_and_clear_bit(WORK_UPDATE_ISP, &isp->todo)) {
 			otg_update_isp(isp);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 #endif
 		/* transfer state from isp1301 to otg engine */
@@ -1115,7 +1116,7 @@ isp1301_work(struct work_struct *work)
 			u8		stat = isp1301_clear_latch(isp);
 
 			isp_update_otg(isp, stat);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (test_and_clear_bit(WORK_HOST_RESUME, &isp->todo)) {
@@ -1150,7 +1151,7 @@ isp1301_work(struct work_struct *work)
 			}
 			host_resume(isp);
 			// mdelay(10);
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (test_and_clear_bit(WORK_TIMER, &isp->todo)) {
@@ -1159,15 +1160,15 @@ isp1301_work(struct work_struct *work)
 			if (!stop)
 				mod_timer(&isp->timer, jiffies + TIMER_JIFFIES);
 #endif
-			put_device(&isp->client.dev);
+			put_device(&isp->client->dev);
 		}
 
 		if (isp->todo)
-			dev_vdbg(&isp->client.dev,
+			dev_vdbg(&isp->client->dev,
 				"work done, todo = 0x%lx\n",
 				isp->todo);
 		if (stop) {
-			dev_dbg(&isp->client.dev, "stop\n");
+			dev_dbg(&isp->client->dev, "stop\n");
 			break;
 		}
 	} while (isp->todo);
@@ -1191,7 +1192,7 @@ static void isp1301_release(struct device *dev)
 {
 	struct isp1301	*isp;
 
-	isp = container_of(dev, struct isp1301, client.dev);
+	isp = container_of(dev, struct isp1301, c.dev);
 
 	/* ugly -- i2c hijacks our memory hook to wait_for_completion() */
 	if (isp->i2c_release)
@@ -1205,7 +1206,7 @@ static int isp1301_detach_client(struct i2c_client *i2c)
 {
 	struct isp1301	*isp;
 
-	isp = container_of(i2c, struct isp1301, client);
+	isp = container_of(i2c, struct isp1301, c);
 
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_FALLING, ~0);
 	isp1301_clear_bits(isp, ISP1301_INTERRUPT_RISING, ~0);
@@ -1257,7 +1258,7 @@ static int isp1301_otg_enable(struct isp1301 *isp)
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
 		INTR_VBUS_VLD | INTR_SESS_VLD | INTR_ID_GND);
 
-	dev_info(&isp->client.dev, "ready for dual-role USB ...\n");
+	dev_info(&isp->client->dev, "ready for dual-role USB ...\n");
 
 	return 0;
 }
@@ -1282,7 +1283,7 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 
 #ifdef	CONFIG_USB_OTG
 	isp->otg.host = host;
-	dev_dbg(&isp->client.dev, "registered host\n");
+	dev_dbg(&isp->client->dev, "registered host\n");
 	host_suspend(isp);
 	if (isp->otg.gadget)
 		return isp1301_otg_enable(isp);
@@ -1297,7 +1298,7 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 	if (machine_is_omap_h2())
 		isp1301_set_bits(isp, ISP1301_MODE_CONTROL_1, MC1_DAT_SE0);
 
-	dev_info(&isp->client.dev, "A-Host sessions ok\n");
+	dev_info(&isp->client->dev, "A-Host sessions ok\n");
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_RISING,
 		INTR_ID_GND);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
@@ -1315,7 +1316,7 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 	return 0;
 
 #else
-	dev_dbg(&isp->client.dev, "host sessions not allowed\n");
+	dev_dbg(&isp->client->dev, "host sessions not allowed\n");
 	return -EINVAL;
 #endif
 
@@ -1341,7 +1342,7 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
 
 #ifdef	CONFIG_USB_OTG
 	isp->otg.gadget = gadget;
-	dev_dbg(&isp->client.dev, "registered gadget\n");
+	dev_dbg(&isp->client->dev, "registered gadget\n");
 	/* gadget driver may be suspended until vbus_connect () */
 	if (isp->otg.host)
 		return isp1301_otg_enable(isp);
@@ -1364,8 +1365,8 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
 		INTR_SESS_VLD);
 	isp1301_set_bits(isp, ISP1301_INTERRUPT_FALLING,
 		INTR_VBUS_VLD);
-	dev_info(&isp->client.dev, "B-Peripheral sessions ok\n");
-	dump_regs(isp, __FUNCTION__);
+	dev_info(&isp->client->dev, "B-Peripheral sessions ok\n");
+	dump_regs(isp, __func__);
 
 	/* If this has a Mini-AB connector, this mode is highly
 	 * nonstandard ... but can be handy for testing, so long
@@ -1377,7 +1378,7 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
 	return 0;
 
 #else
-	dev_dbg(&isp->client.dev, "peripheral sessions not allowed\n");
+	dev_dbg(&isp->client->dev, "peripheral sessions not allowed\n");
 	return -EINVAL;
 #endif
 }
@@ -1493,12 +1494,12 @@ static int isp1301_probe(struct i2c_adapter *bus, int address, int kind)
 	isp->timer.data = (unsigned long) isp;
 
 	isp->irq = -1;
-	isp->client.addr = address;
-	i2c_set_clientdata(&isp->client, isp);
-	isp->client.adapter = bus;
-	isp->client.driver = &isp1301_driver;
-	strlcpy(isp->client.name, DRIVER_NAME, I2C_NAME_SIZE);
-	i2c = &isp->client;
+	isp->c.addr = address;
+	i2c_set_clientdata(&isp->c, isp);
+	isp->c.adapter = bus;
+	isp->c.driver = &isp1301_driver;
+	strlcpy(isp->c.name, DRIVER_NAME, I2C_NAME_SIZE);
+	isp->client = i2c = &isp->c;
 
 	/* if this is a true probe, verify the chip ... */
 	if (kind < 0) {
@@ -1583,7 +1584,7 @@ fail2:
 		goto fail1;
 	}
 
-	isp->otg.dev = &isp->client.dev;
+	isp->otg.dev = &isp->client->dev;
 	isp->otg.label = DRIVER_NAME;
 
 	isp->otg.set_host = isp1301_set_host,
-- 
1.5.4.3.447.gc95b3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
