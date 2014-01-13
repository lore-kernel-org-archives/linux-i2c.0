From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/5] i2c: mv64xxx: Add support for the
 Allwinner A31 I2C driver
Date: Mon, 13 Jan 2014 11:34:50 +0100
Message-ID: <1389609293-2824-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1389609293-2824-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCEFZ6LAKGQERISBSFY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1389609293-2824-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, duanmintao-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Allwinner A31 I2C controller is almost identical to the one used in the
other Allwinner SoCs, except for the fact that it needs to clear the interrupt
by setting the INT_FLAGS bit in the control register, instead of clearing it.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |  9 ++++++---
 drivers/i2c/busses/i2c-mv64xxx.c                      | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 603003a..2763225 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -4,15 +4,18 @@
 Required properties :
 
  - reg             : Offset and length of the register set for the device
- - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
-                     or "marvell,mv78230-i2c"
+ - compatible      : Should be "marvell,mv64xxx-i2c", "allwinner,sun4i-i2c",
+                     "marvell,mv78230-i2c" or "allwinner,sun6i-a31-i2c"
  - interrupts      : The interrupt number
 
 Optional properties :
 
  - clock-frequency : Desired I2C bus clock frequency in Hz. If not set the
 default frequency is 100kHz
- - resets          : phandle to the parent reset controller
+
+ - resets          : phandle to the parent reset controller. Mandatory
+                     whenever you're using the "allwinner,sun6i-a31-i2c"
+                     compatible.
 
 Examples:
 
diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 0f6dde5..12ecf4b 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -151,6 +151,7 @@ struct mv64xxx_i2c_data {
 /* 5us delay in order to avoid repeated start timing violation */
 	bool			errata_delay;
 	struct reset_control	*rstc;
+	bool			irq_clear_inverted;
 };
 
 static struct mv64xxx_i2c_regs mv64xxx_i2c_regs_mv64xxx = {
@@ -568,6 +569,11 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 		status = readl(drv_data->reg_base + drv_data->reg_offsets.status);
 		mv64xxx_i2c_fsm(drv_data, status);
 		mv64xxx_i2c_do_action(drv_data);
+
+		if (drv_data->irq_clear_inverted)
+			writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_IFLG,
+			       drv_data->reg_base + drv_data->reg_offsets.control);
+
 		rc = IRQ_HANDLED;
 	}
 	spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -692,6 +698,7 @@ static const struct i2c_algorithm mv64xxx_i2c_algo = {
  */
 static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 	{ .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
+	{ .compatible = "allwinner,sun6i-a31-i2c", .data = &mv64xxx_i2c_regs_sun4i},
 	{ .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{ .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
 	{}
@@ -795,6 +802,9 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		drv_data->errata_delay = true;
 	}
 
+	if (of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
+		drv_data->irq_clear_inverted = true;
+
 out:
 	return rc;
 #endif
-- 
1.8.4.2
