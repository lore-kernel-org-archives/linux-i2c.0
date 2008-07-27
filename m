From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] Blackfin I2C Driver: Functional power management
	support
Date: Sun, 27 Jul 2008 14:41:54 +0800
Message-ID: <1217140914-21718-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

PM_SUSPEND_MEM: Blackfin does not maintain register state through
Hibernate. Save and restore peripheral base initialization during
PM transitions.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 48d084b..3c855ff 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -49,6 +49,8 @@ struct bfin_twi_iface {
 	struct i2c_msg 		*pmsg;
 	int			msg_num;
 	int			cur_msg;
+	u16			saved_clkdiv;
+	u16			saved_control;
 	void __iomem		*regs_base;
 };
 
@@ -565,32 +567,43 @@ static u32 bfin_twi_functionality(struct i2c_adapter *adap)
 	       I2C_FUNC_I2C;
 }
 
-
 static struct i2c_algorithm bfin_twi_algorithm = {
 	.master_xfer   = bfin_twi_master_xfer,
 	.smbus_xfer    = bfin_twi_smbus_xfer,
 	.functionality = bfin_twi_functionality,
 };
 
-
-static int i2c_bfin_twi_suspend(struct platform_device *dev, pm_message_t state)
+static int i2c_bfin_twi_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	struct bfin_twi_iface *iface = platform_get_drvdata(dev);
+	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
+
+	iface->saved_clkdiv = read_CLKDIV(iface);
+	iface->saved_control = read_CONTROL(iface);
+
+	free_irq(iface->irq, iface);
 
 	/* Disable TWI */
-	write_CONTROL(iface, read_CONTROL(iface) & ~TWI_ENA);
-	SSYNC();
+	write_CONTROL(iface, iface->saved_control & ~TWI_ENA);
 
 	return 0;
 }
 
-static int i2c_bfin_twi_resume(struct platform_device *dev)
+static int i2c_bfin_twi_resume(struct platform_device *pdev)
 {
-	struct bfin_twi_iface *iface = platform_get_drvdata(dev);
+	struct bfin_twi_iface *iface = platform_get_drvdata(pdev);
 
-	/* Enable TWI */
-	write_CONTROL(iface, read_CONTROL(iface) | TWI_ENA);
-	SSYNC();
+	int rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
+		IRQF_DISABLED, pdev->name, iface);
+	if (rc) {
+		dev_err(&pdev->dev, "Can't get IRQ %d !\n", iface->irq);
+		return -ENODEV;
+	}
+
+	/* Resume TWI interface clock as specified */
+	write_CLKDIV(iface, iface->saved_clkdiv);
+
+	/* Resume TWI */
+	write_CONTROL(iface, iface->saved_control);
 
 	return 0;
 }
-- 
1.5.6


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
