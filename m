From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/7] Blackfin I2C/TWI driver: add missing pin mux
	operation
Date: Wed, 26 Mar 2008 17:46:45 -0700
Message-ID: <1206578809-16038-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
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
List-Id: linux-i2c@vger.kernel.org

Blackfin TWI controller hardware pin should be requested from GPIO port controller
Before BF54x, there is no need to do this. But as long as BF54x and BF52x
are supported by this generic driver, the missing pin mux operation should be
added.

Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index f60db72..a55625f 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/blackfin.h>
+#include <asm/portmux.h>
 #include <asm/irq.h>
 
 #define POLL_TIMEOUT       (2 * HZ)
@@ -89,6 +90,11 @@ DEFINE_TWI_REG(XMT_DATA16, 0x84)
 DEFINE_TWI_REG(RCV_DATA8, 0x88)
 DEFINE_TWI_REG(RCV_DATA16, 0x8C)
 
+static const u16 pin_req[2][3] = {
+	{P_TWI0_SCL, P_TWI0_SDA, 0},
+	{P_TWI1_SCL, P_TWI1_SDA, 0},
+};
+
 static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface)
 {
 	unsigned short twi_int_status = read_INT_STAT(iface);
@@ -653,6 +659,12 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 	p_adap->class = I2C_CLASS_ALL;
 	p_adap->dev.parent = &pdev->dev;
 
+	rc = peripheral_request_list(pin_req[pdev->id], "i2c-bfin-twi");
+	if (rc) {
+		dev_err(&pdev->dev, "Can't setup pin mux!\n");
+		goto out_error_pin_mux;
+	}
+
 	rc = request_irq(iface->irq, bfin_twi_interrupt_entry,
 		IRQF_DISABLED, pdev->name, iface);
 	if (rc) {
@@ -690,6 +702,8 @@ out_error_add_adapter:
 	free_irq(iface->irq, iface);
 out_error_req_irq:
 out_error_no_irq:
+	peripheral_free_list(pin_req[pdev->id]);
+out_error_pin_mux:
 	iounmap(iface->regs_base);
 out_error_ioremap:
 out_error_get_res:
@@ -706,6 +720,7 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
 
 	i2c_del_adapter(&(iface->adap));
 	free_irq(iface->irq, iface);
+	peripheral_free_list(pin_req[pdev->id]);
 	iounmap(iface->regs_base);
 	kfree(iface);
 
-- 
1.5.4.3

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
