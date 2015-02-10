From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: mpc: assign the correct prescaler from SVR
Date: Tue, 10 Feb 2015 16:46:33 +0100
Message-ID: <1423583193-28450-1-git-send-email-valentin.longchamp@keymile.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For the 85xx platforms, the source clock for the i2c-mpc can change from
one SoC to another. This is documented in the AN2919 "Determining the
I2C Frequency Divider Ratio for SCL" by Freescale. Not taking this into
account can lead to the output SCL frequency to by off by an offset. It
was observed on the P2041 from the QorIQ family.

This patch fixes this problem by setting the prescaler value to the
appropriate value when required. The SoCs that required a different
prescaler than 1 are identified by reading out the SVR as discussed in
http://thread.gmane.org/gmane.linux.drivers.devicetree/94247/focus=20556

Signed-off-by: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>

---

 drivers/i2c/busses/i2c-mpc.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c74cc2b..dc03a91 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -29,6 +29,7 @@
 #include <linux/delay.h>
 
 #include <asm/mpc52xx.h>
+#include <asm/mpc85xx.h>
 #include <sysdev/fsl_soc.h>
 
 #define DRV_NAME "mpc-i2c"
@@ -346,6 +347,33 @@ static u32 mpc_i2c_get_sec_cfg_8xxx(void)
 	return val;
 }
 
+static u32 mpc_i2c_get_prescaler_8xxx(void)
+{
+	/* mpc83xx and mpc82xx all have prescaler 1 */
+	u32 prescaler = 1;
+
+	/* mpc85xx */
+	if (pvr_version_is(PVR_VER_E500V1) || pvr_version_is(PVR_VER_E500V2)
+		|| pvr_version_is(PVR_VER_E500MC)
+		|| pvr_version_is(PVR_VER_E5500)
+		|| pvr_version_is(PVR_VER_E6500)) {
+		unsigned int svr = mfspr(SPRN_SVR);
+
+		if ((SVR_SOC_VER(svr) == SVR_8540)
+			|| (SVR_SOC_VER(svr) == SVR_8541)
+			|| (SVR_SOC_VER(svr) == SVR_8560)
+			|| (SVR_SOC_VER(svr) == SVR_8555)
+			|| (SVR_SOC_VER(svr) == SVR_8610))
+			/* the above 85xx SoCs have prescaler 1 */
+			prescaler = 1;
+		else
+			/* all the other 85xx have prescaler 2 */
+			prescaler = 2;
+	}
+
+	return prescaler;
+}
+
 static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 					  u32 prescaler, u32 *real_clk)
 {
@@ -363,7 +391,7 @@ static int mpc_i2c_get_fdr_8xxx(struct device_node *node, u32 clock,
 	if (of_device_is_compatible(node, "fsl,mpc8544-i2c"))
 		prescaler = mpc_i2c_get_sec_cfg_8xxx() ? 3 : 2;
 	if (!prescaler)
-		prescaler = 1;
+		prescaler = mpc_i2c_get_prescaler_8xxx();
 
 	divider = fsl_get_sys_freq() / clock / prescaler;
 
-- 
1.8.0.1
