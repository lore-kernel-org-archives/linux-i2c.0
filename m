From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/3] i2c-ocores: Add support for the GRLIB port of the controller.
Date: Thu, 11 Oct 2012 16:11:19 +0200
Message-ID: <1349964679-23244-4-git-send-email-andreas@gaisler.com>
References: <1349964679-23244-1-git-send-email-andreas@gaisler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349964679-23244-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The registers are 32-bit and in big endian byte order. The PRELOW and PREHIGH
registers are merged into one register. The subsequent registers have their
offset decreased accordingly.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |   47 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index de93b2d..1895e8c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -4,6 +4,9 @@
  *
  * Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
  *
+ * Modified by Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> to support the GRLIB port
+ * of the controller.
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
@@ -99,6 +102,40 @@ static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 		return ioread8(i2c->base + (reg << i2c->reg_shift));
 }
 
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
+		return (u8)rd >> 8;
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
 static void ocores_process(struct ocores_i2c *i2c)
 {
 	struct i2c_msg *msg = i2c->msg;
@@ -241,6 +278,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	u32 val;
+	const char *name;
 
 	if (of_property_read_u32(np, "reg-shift", &i2c->reg_shift)) {
 		/* no 'reg-shift', check for deprecated 'regstep' */
@@ -265,6 +303,15 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 
 	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
 				&i2c->reg_io_width);
+
+	name = of_get_property(pdev->dev.of_node, "name", NULL);
+	if (name && (!strcmp(name, "GAISLER_I2CMST") ||
+		     !strcmp(name, "01_028"))) {
+		dev_dbg(&pdev->dev, "GRLIB variant of i2c-ocores\n");
+		i2c->setreg = oc_setreg_grlib;
+		i2c->getreg = oc_getreg_grlib;
+	}
+
 	return 0;
 }
 #else
-- 
1.7.0.4
