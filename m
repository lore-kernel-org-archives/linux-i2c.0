From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 1/6] i2c: Xilinx IIC: remove Endianness hack
Date: Fri, 31 Jul 2015 14:00:29 +0200
Message-ID: <1438344034-20211-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 60 +++++--------------------------------------
 1 file changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 59b035c..dd897b5 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -46,11 +46,6 @@ enum xilinx_i2c_state {
 	STATE_START
 };
 
-enum xiic_endian {
-	LITTLE,
-	BIG
-};
-
 /**
  * struct xiic_i2c - Internal representation of the XIIC I2C bus
  * @base:	Memory base of the HW registers
@@ -75,15 +70,13 @@ struct xiic_i2c {
 	enum xilinx_i2c_state	state;
 	struct i2c_msg		*rx_msg;
 	int			rx_pos;
-	enum xiic_endian	endianness;
 };
 
 
 #define XIIC_REG_OFFSET 0x100
 
 /*
- * Register offsets in bytes from RegisterBase. Three is added to the
- * base offset to access LSB (IBM style) of the word
+ * Register offsets in bytes from RegisterBase.
  */
 #define XIIC_CR_REG   (0x00+XIIC_REG_OFFSET)	/* Control Register   */
 #define XIIC_SR_REG   (0x04+XIIC_REG_OFFSET)	/* Status Register    */
@@ -175,58 +168,29 @@ struct xiic_i2c {
 static void xiic_start_xfer(struct xiic_i2c *i2c);
 static void __xiic_start_xfer(struct xiic_i2c *i2c);
 
-/*
- * For the register read and write functions, a little-endian and big-endian
- * version are necessary. Endianness is detected during the probe function.
- * Only the least significant byte [doublet] of the register are ever
- * accessed. This requires an offset of 3 [2] from the base address for
- * big-endian systems.
- */
-
 static inline void xiic_setreg8(struct xiic_i2c *i2c, int reg, u8 value)
 {
-	if (i2c->endianness == LITTLE)
-		iowrite8(value, i2c->base + reg);
-	else
-		iowrite8(value, i2c->base + reg + 3);
+	iowrite8(value, i2c->base + reg);
 }
 
 static inline u8 xiic_getreg8(struct xiic_i2c *i2c, int reg)
 {
-	u8 ret;
-
-	if (i2c->endianness == LITTLE)
-		ret = ioread8(i2c->base + reg);
-	else
-		ret = ioread8(i2c->base + reg + 3);
-	return ret;
+	return ioread8(i2c->base + reg);
 }
 
 static inline void xiic_setreg16(struct xiic_i2c *i2c, int reg, u16 value)
 {
-	if (i2c->endianness == LITTLE)
-		iowrite16(value, i2c->base + reg);
-	else
-		iowrite16be(value, i2c->base + reg + 2);
+	iowrite16(value, i2c->base + reg);
 }
 
 static inline void xiic_setreg32(struct xiic_i2c *i2c, int reg, int value)
 {
-	if (i2c->endianness == LITTLE)
-		iowrite32(value, i2c->base + reg);
-	else
-		iowrite32be(value, i2c->base + reg);
+	iowrite32(value, i2c->base + reg);
 }
 
 static inline int xiic_getreg32(struct xiic_i2c *i2c, int reg)
 {
-	u32 ret;
-
-	if (i2c->endianness == LITTLE)
-		ret = ioread32(i2c->base + reg);
-	else
-		ret = ioread32be(i2c->base + reg);
-	return ret;
+	return ioread32(i2c->base + reg);
 }
 
 static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
@@ -759,18 +723,6 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Detect endianness
-	 * Try to reset the TX FIFO. Then check the EMPTY flag. If it is not
-	 * set, assume that the endianness was wrong and swap.
-	 */
-	i2c->endianness = LITTLE;
-	xiic_setreg32(i2c, XIIC_CR_REG, XIIC_CR_TX_FIFO_RESET_MASK);
-	/* Reset is cleared in xiic_reinit */
-	sr = xiic_getreg32(i2c, XIIC_SR_REG);
-	if (!(sr & XIIC_SR_TX_FIFO_EMPTY_MASK))
-		i2c->endianness = BIG;
-
 	xiic_reinit(i2c);
 
 	/* add i2c adapter to i2c tree */
-- 
2.5.0
