From: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 5/8] i2c: imx: change register offset representation
Date: Wed, 7 Aug 2013 17:05:40 +0800
Message-ID: <1375866343-2074-5-git-send-email-b35083@freescale.com>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375866343-2074-1-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

  the I2C register offset may different between SoCs,
to provid support for all these chips, split the
register offset into a fixed base address and a
variable shift value, then the full register offset
will be calculated by
reg_off = ( reg_base_addr << reg_shift)

Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/busses/i2c-imx.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 1a3c608..8a292a9 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -64,12 +64,21 @@
 /* Default value */
 #define IMX_I2C_BIT_RATE	100000	/* 100kHz */
 
-/* IMX I2C registers */
+/* IMX I2C registers:
+ * the I2C register offset is different between SoCs,
+ * to provid support for all these chips, split the
+ * register offset into a fixed base address and a
+ * variable shift value, then the full register offset
+ * will be calculated by
+ * reg_off = ( reg_base_addr << reg_shift)
+ */
 #define IMX_I2C_IADR	0x00	/* i2c slave address */
-#define IMX_I2C_IFDR	0x04	/* i2c frequency divider */
-#define IMX_I2C_I2CR	0x08	/* i2c control */
-#define IMX_I2C_I2SR	0x0C	/* i2c status */
-#define IMX_I2C_I2DR	0x10	/* i2c transfer data */
+#define IMX_I2C_IFDR	0x01	/* i2c frequency divider */
+#define IMX_I2C_I2CR	0x02	/* i2c control */
+#define IMX_I2C_I2SR	0x03	/* i2c status */
+#define IMX_I2C_I2DR	0x04	/* i2c transfer data */
+
+#define IMX_I2C_REGSHIFT	2
 
 /* Bits of IMX I2C registers */
 #define I2SR_RXAK	0x01
@@ -163,13 +172,13 @@ static inline int is_imx1_i2c(struct imx_i2c_struct *i2c_imx)
 static inline void imx_i2c_write_reg(unsigned int val,
 		struct imx_i2c_struct *i2c_imx, unsigned int reg)
 {
-	writeb(val, i2c_imx->base + reg);
+	writeb(val, i2c_imx->base + (reg << IMX_I2C_REGSHIFT));
 }
 
 static inline unsigned char imx_i2c_read_reg(struct imx_i2c_struct *i2c_imx,
 		unsigned int reg)
 {
-	return readb(i2c_imx->base + reg);
+	return readb(i2c_imx->base + (reg << IMX_I2C_REGSHIFT));
 }
 
 /** Functions for IMX I2C adapter driver ***************************************
-- 
1.8.0
