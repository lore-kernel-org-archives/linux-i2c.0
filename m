From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/6] Blackfin I2C/TWI driver: add missing pin mux
	operation
Date: Wed, 12 Mar 2008 16:25:48 +0000 (UTC)
Message-ID: <1205479360-25240-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Date: Fri, 14 Mar 2008 00:22:37 -0700
In-Reply-To: <>
References: <>
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
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Blackfin TWI controller hardware pin should be requested from GPIO port controller
Before BF54x, there is no need to do this. But as long as BF54x and BF52x
are supported by this generic driver, the missing pin mux operation should be
added.

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 515fe08..674c053 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/blackfin.h>
+#include <asm/portmux.h>
 #include <asm/irq.h>
 
 #define POLL_TIMEOUT       (2 * HZ)
@@ -63,6 +64,7 @@ struct bfin_twi_iface {
 	int			msg_num;
 	int			cur_msg;
 	void __iomem		*regs_base;
+	int			bus_num;
 };
 
 
@@ -89,6 +91,23 @@ DEFINE_TWI_REG(XMT_DATA16, 0x84)
 DEFINE_TWI_REG(RCV_DATA8, 0x88)
 DEFINE_TWI_REG(RCV_DATA16, 0x8C)
 
+static u16 pin_req[2][3] = {
+	{P_TWI0_SCL, P_TWI0_SDA, 0},
+	{P_TWI1_SCL, P_TWI1_SDA, 0},
+};
+
+static int setup_pin_mux(struct bfin_twi_iface *iface, int action)
+{
+	int rc = 0;
+
+	if (action)
+		rc = peripheral_request_list(pin_req[iface->bus_num], "i2c-bfin-twi");
+	else
+		peripheral_free_list(pin_req[iface->bus_num]);
+
+	return rc;
+}
+
 static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 {
 	unsigned short twi_int_status = read_INT_STAT(iface);
@@ -640,6 +659,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 		goto out_error_no_irq;
 	}
 
+	iface->bus_num = pdev->id;
 	init_timer(&(iface->timeout_timer));
 	iface->timeout_timer.function = bfin_twi_timeout;
 	iface->timeout_timer.data = (unsigned long)iface;
@@ -653,6 +673,12 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	p_adap->class = I2C_CLASS_ALL;
 	p_adap->dev.parent = &pdev->dev;
 
+	rc = setup_pin_mux(iface, 1);
+	if (rc) {
+		dev_err(&pdev->dev, "Can't setup Pin Mux!\n");
+		goto out_error_pin_mux;
+	}
+
 	rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
 		IRQF_DISABLED, pdev->name, iface);
 	if (rc) {
@@ -690,6 +716,8 @@ out_error_add_adapter:
 	free_irq(iface->irq, iface);
 out_error_req_irq:
 out_error_no_irq:
+	setup_pin_mux(iface, 0);
+out_error_pin_mux:
 	iounmap(iface->regs_base);
 out_error_ioremap:
 out_error_get_res:
@@ -706,6 +734,7 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&(iface->adap));
 	free_irq(iface->irq, iface);
+	setup_pin_mux(iface, 0);
 
 	return 0;
 }
-- 
1.5.4.3


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
