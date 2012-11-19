From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: i2c-ocores: Move grlib set/get functions into #ifdef CONFIG_OF block
Date: Mon, 19 Nov 2012 13:17:48 +0100
Message-ID: <1353327468-9407-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This moves the grlib set and get functions into the #ifdef CONFIG_OF block to
avoid warnings of unimplemented functions when compiling with -Wunused-function
when CONFIG_OF is not defined.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
To be applied to the for-next tree

 drivers/i2c/busses/i2c-ocores.c |   68 +++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 2ef318b..3ea2ee7 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -109,40 +109,6 @@ static inline u8 oc_getreg_32(struct ocores_i2c *i2c, int reg)
 	return ioread32(i2c->base + (reg << i2c->reg_shift));
 }
 
-/* Read and write functions for the GRLIB port of the controller. Registers are
- * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
-static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
-{
-	u32 rd;
-	int rreg = reg;
-	if (reg != OCI2C_PRELOW)
-		rreg--;
-	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
-	if (reg == OCI2C_PREHIGH)
-		return (u8)(rd >> 8);
-	else
-		return (u8)rd;
-}
-
-static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
-{
-	u32 curr, wr;
-	int rreg = reg;
-	if (reg != OCI2C_PRELOW)
-		rreg--;
-	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
-		curr = ioread32be(i2c->base + (rreg << i2c->reg_shift));
-		if (reg == OCI2C_PRELOW)
-			wr = (curr & 0xff00) | value;
-		else
-			wr = (((u32)value) << 8) | (curr & 0xff);
-	} else {
-		wr = value;
-	}
-	iowrite32be(wr, i2c->base + (rreg << i2c->reg_shift));
-}
-
 static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	i2c->setreg(i2c, reg, value);
@@ -303,6 +269,40 @@ static struct of_device_id ocores_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 
 #ifdef CONFIG_OF
+/* Read and write functions for the GRLIB port of the controller. Registers are
+ * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
+ * register. The subsequent registers has their offset decreased accordingly. */
+static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
+{
+	u32 rd;
+	int rreg = reg;
+	if (reg != OCI2C_PRELOW)
+		rreg--;
+	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
+	if (reg == OCI2C_PREHIGH)
+		return (u8)(rd >> 8);
+	else
+		return (u8)rd;
+}
+
+static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
+{
+	u32 curr, wr;
+	int rreg = reg;
+	if (reg != OCI2C_PRELOW)
+		rreg--;
+	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
+		curr = ioread32be(i2c->base + (rreg << i2c->reg_shift));
+		if (reg == OCI2C_PRELOW)
+			wr = (curr & 0xff00) | value;
+		else
+			wr = (((u32)value) << 8) | (curr & 0xff);
+	} else {
+		wr = value;
+	}
+	iowrite32be(wr, i2c->base + (rreg << i2c->reg_shift));
+}
+
 static int ocores_i2c_of_probe(struct platform_device *pdev,
 				struct ocores_i2c *i2c)
 {
-- 
1.7.0.4
