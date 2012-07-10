From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 4/4] i2c: i2c-ocores: support for 16bit and 32bit IO
Date: Tue, 10 Jul 2012 11:40:58 +0530
Message-ID: <1341900658-7698-5-git-send-email-jayachandranc@netlogicmicro.com>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341900658-7698-1-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org
Cc: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Some architectures supports only 16-bit or 32-bit read/write access to
their IO space. Add a 'reg-io-width' platform and OF parameter which
specifies the IO width to support these platforms.

reg-io-width can be specified as 1, 2 or 4, and has a default value
of 1 if it is unspecified.

Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-ocores.txt         |    2 ++
 drivers/i2c/busses/i2c-ocores.c                    |   21 ++++++++++++++++++--
 include/linux/i2c-ocores.h                         |    1 +
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 1c9334b..c15781f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -10,6 +10,7 @@ Required properties:
 
 Optional properties:
 - reg-shift       : device register offsets are shifted by this value
+- reg-io-width    : io register width in bytes (1, 2 or 4)
 - regstep         : deprecated, use reg-shift above
 
 Example:
@@ -23,6 +24,7 @@ Example:
 		clock-frequency = <20000000>;
 
 		reg-shift = <0>;	/* 8 bit registers */
+		reg-io-width = <1>;	/* 8 bit read/write */
 
 		dummy@60 {
 			compatible = "dummy";
diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 9617ec1..034d1d5 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -30,6 +30,7 @@
 struct ocores_i2c {
 	void __iomem *base;
 	int reg_shift;
+	int reg_io_width;
 	wait_queue_head_t wait;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
@@ -72,12 +73,22 @@ struct ocores_i2c {
 
 static inline void oc_setreg(struct ocores_i2c *i2c, int reg, u8 value)
 {
-	iowrite8(value, i2c->base + (reg << i2c->reg_shift));
+	if (i2c->reg_io_width == 4)
+		iowrite32(value, i2c->base + (reg << i2c->reg_shift));
+	else if (i2c->reg_io_width == 2)
+		iowrite16(value, i2c->base + (reg << i2c->reg_shift));
+	else
+		iowrite8(value, i2c->base + (reg << i2c->reg_shift));
 }
 
 static inline u8 oc_getreg(struct ocores_i2c *i2c, int reg)
 {
-	return ioread8(i2c->base + (reg << i2c->reg_shift));
+	if (i2c->reg_io_width == 4)
+		return ioread32(i2c->base + (reg << i2c->reg_shift));
+	else if (i2c->reg_io_width == 2)
+		return ioread16(i2c->base + (reg << i2c->reg_shift));
+	else
+		return ioread8(i2c->base + (reg << i2c->reg_shift));
 }
 
 static void ocores_process(struct ocores_i2c *i2c)
@@ -244,6 +255,8 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	}
 	i2c->clock_khz = val / 1000;
 
+	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
+				&i2c->reg_io_width);
 	return 0;
 }
 #else
@@ -286,6 +299,7 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 	pdata = pdev->dev.platform_data;
 	if (pdata) {
 		i2c->reg_shift = pdata->reg_shift;
+		i2c->reg_io_width = pdata->reg_io_width;
 		i2c->clock_khz = pdata->clock_khz;
 	} else {
 		ret = ocores_i2c_of_probe(pdev, i2c);
@@ -293,6 +307,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
 			return ret;
 	}
 
+	if (i2c->reg_io_width == 0)
+		i2c->reg_io_width = 1; /* Set to default value */
+
 	ocores_init(i2c);
 
 	init_waitqueue_head(&i2c->wait);
diff --git a/include/linux/i2c-ocores.h b/include/linux/i2c-ocores.h
index bb58c7d..1d99ebd 100644
--- a/include/linux/i2c-ocores.h
+++ b/include/linux/i2c-ocores.h
@@ -13,6 +13,7 @@
 
 struct ocores_i2c_platform_data {
 	u32 reg_shift;		/* register offset shift value */
+	u32 reg_io_width;	/* register io read/write width */
 	u32 clock_khz;		/* input clock in kHz */
 	u8 num_devices;		/* number of devices in the devices list */
 	struct i2c_board_info const *devices; /* devices connected to the bus */
-- 
1.7.9.5
