From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] i2c: i2c_mxs: Set ACK_MODE bit
Date: Tue, 2 Jul 2013 13:01:00 -0300
Message-ID: <1372780860-12972-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: marex-ynQEQJNshbs@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, cb-/RsSufbtIHM@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

According to mx23 erratum 2727:

"2727 : I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set.

Description:

When RETAIN_CLOCK is set, the ninth clock pulse (ACK) is not generated. 
However, the SDA line is read at the proper timing interval. If 
RETAIN_CLOCK is cleared, the ninth clock pulse is generated.
Also, the HW_I2C_VERSION register incorrectly states the version is 1.2. 
It should be 1.3.

Workaround:
HW_I2C_CTRL1[ACK_MODE] has default value of 0. It should be set to 1 to 
enable the fix for this issue."

It has also been noticed that mx28 needs to implement this fix in order to have
SMBus to work properly.

Reported-by: Christoph Baumann <cb-/RsSufbtIHM@public.gmane.org>
Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 6d8094d..ce7ac86 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -56,6 +56,7 @@
 #define MXS_I2C_CTRL1_CLR	(0x48)
 
 #define MXS_I2C_CTRL1_CLR_GOT_A_NAK		0x10000000
+#define MXS_I2C_CTRL1_ACK_MODE			0x08000000
 #define MXS_I2C_CTRL1_BUS_FREE_IRQ		0x80
 #define MXS_I2C_CTRL1_DATA_ENGINE_CMPLT_IRQ	0x40
 #define MXS_I2C_CTRL1_NO_SLAVE_ACK_IRQ		0x20
@@ -140,6 +141,14 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
 
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
+
+	/*
+	 * According to mx23 erratum 2727:
+	 * "I2C 9th Clock Pulse (ACK) not generated when RETAIN_CLOCK set"
+	 *
+	 * HW_I2C_CTRL1[ACK_MODE] needs to be set when RETAIN_CLOCK is set.
+	 */
+	writel(MXS_I2C_CTRL1_ACK_MODE, i2c->regs + MXS_I2C_CTRL1_SET);
 }
 
 static void mxs_i2c_dma_finish(struct mxs_i2c_dev *i2c)
-- 
1.8.1.2
