From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 14/15] i2c: octeon,thunderx: Move register offsets to struct
Date: Mon, 25 Apr 2016 16:33:43 +0200
Message-ID: <1461594824-7215-15-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

The register offsets are different between Octeon and ThunderX so move
them into the algorithm struct and get rid of the define.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.c        | 28 +++++++++++++--------------
 drivers/i2c/busses/i2c-cavium.h        | 35 +++++++++++++++++-----------------
 drivers/i2c/busses/i2c-octeon-core.c   |  4 ++++
 drivers/i2c/busses/i2c-thunderx-core.c |  4 ++++
 4 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cavium.c b/drivers/i2c/busses/i2c-cavium.c
index ac37ae1..6ac9d63 100644
--- a/drivers/i2c/busses/i2c-cavium.c
+++ b/drivers/i2c/busses/i2c-cavium.c
@@ -99,7 +99,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 
 static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 {
-	return (__raw_readq(i2c->twsi_base + SW_TWSI) & SW_TWSI_V) == 0;
+	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
 static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
@@ -443,12 +443,12 @@ static int octeon_i2c_hlc_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 	else
 		cmd |= SW_TWSI_OP_7;
 
-	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI);
+	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI(i2c));
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
 
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
 		return -EAGAIN;
 
@@ -456,7 +456,7 @@ static int octeon_i2c_hlc_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 		msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
 
 	if (msgs[0].len > 4) {
-		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT(i2c));
 		for (i = 0; i  < msgs[0].len - 4 && i < 4; i++, j--)
 			msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
 	}
@@ -493,15 +493,15 @@ static int octeon_i2c_hlc_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 		for (i = 0; i < msgs[0].len - 4 && i < 4; i++, j--)
 			ext |= (u64) msgs[0].buf[j] << (8 * i);
-		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT);
+		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT(i2c));
 	}
 
-	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI);
+	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI(i2c));
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
 
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
 		return -EAGAIN;
 
@@ -536,18 +536,18 @@ static int octeon_i2c_hlc_comp_read(struct octeon_i2c *i2c, struct i2c_msg *msgs
 		cmd |= SW_TWSI_EIA;
 		ext = (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
 		cmd |= (u64) msgs[0].buf[1] << SW_TWSI_IA_SHIFT;
-		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT);
+		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT(i2c));
 	} else
 		cmd |= (u64) msgs[0].buf[0] << SW_TWSI_IA_SHIFT;
 
 	octeon_i2c_hlc_int_clear(i2c);
-	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI);
+	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI(i2c));
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
 
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
 		return -EAGAIN;
 
@@ -555,7 +555,7 @@ static int octeon_i2c_hlc_comp_read(struct octeon_i2c *i2c, struct i2c_msg *msgs
 		msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
 
 	if (msgs[1].len > 4) {
-		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT);
+		cmd = __raw_readq(i2c->twsi_base + SW_TWSI_EXT(i2c));
 		for (i = 0; i  < msgs[1].len - 4 && i < 4; i++, j--)
 			msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
 	}
@@ -601,16 +601,16 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
 		set_ext = true;
 	}
 	if (set_ext)
-		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT);
+		octeon_i2c_writeq_flush(ext, i2c->twsi_base + SW_TWSI_EXT(i2c));
 
 	octeon_i2c_hlc_int_clear(i2c);
-	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI);
+	octeon_i2c_writeq_flush(cmd, i2c->twsi_base + SW_TWSI(i2c));
 
 	ret = octeon_i2c_hlc_wait(i2c);
 	if (ret)
 		goto err;
 
-	cmd = __raw_readq(i2c->twsi_base + SW_TWSI);
+	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
 		return -EAGAIN;
 
diff --git a/drivers/i2c/busses/i2c-cavium.h b/drivers/i2c/busses/i2c-cavium.h
index 33c7e1f..ad57b03 100644
--- a/drivers/i2c/busses/i2c-cavium.h
+++ b/drivers/i2c/busses/i2c-cavium.h
@@ -7,17 +7,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 
-/* Register offsets */
-#if IS_ENABLED(CONFIG_I2C_THUNDERX)
-	#define SW_TWSI			0x1000
-	#define TWSI_INT		0x1010
-	#define SW_TWSI_EXT		0x1018
-#else
-	#define SW_TWSI			0x00
-	#define TWSI_INT		0x10
-	#define SW_TWSI_EXT		0x18
-#endif
-
 /* Controller command patterns */
 #define SW_TWSI_V		BIT_ULL(63)	/* Valid bit */
 #define SW_TWSI_EIA		BIT_ULL(61)	/* Extended internal address */
@@ -97,9 +86,21 @@
 
 #define I2C_OCTEON_EVENT_WAIT 80 /* microseconds */
 
+/* Register offsets */
+struct octeon_i2c_reg_offset {
+	unsigned int sw_twsi;
+	unsigned int twsi_int;
+	unsigned int sw_twsi_ext;
+};
+
+#define SW_TWSI(x)	(x->roff.sw_twsi)
+#define TWSI_INT(x)	(x->roff.twsi_int)
+#define SW_TWSI_EXT(x)	(x->roff.sw_twsi_ext)
+
 struct octeon_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
+	struct octeon_i2c_reg_offset roff;
 	struct clk *clk;
 	int irq;
 	int hlc_irq;		/* For cn7890 only */
@@ -139,9 +140,9 @@ static inline void octeon_i2c_reg_write(struct octeon_i2c *i2c, u64 eop_reg, u8
 {
 	u64 tmp;
 
-	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI);
+	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + SW_TWSI(i2c));
 	do {
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	} while ((tmp & SW_TWSI_V) != 0);
 }
 
@@ -163,9 +164,9 @@ static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
 {
 	u64 tmp;
 
-	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI);
+	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base + SW_TWSI(i2c));
 	do {
-		tmp = __raw_readq(i2c->twsi_base + SW_TWSI);
+		tmp = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	} while ((tmp & SW_TWSI_V) != 0);
 
 	return tmp & 0xFF;
@@ -186,7 +187,7 @@ static inline u8 octeon_i2c_reg_read(struct octeon_i2c *i2c, u64 eop_reg)
  */
 static inline u64 octeon_i2c_read_int(struct octeon_i2c *i2c)
 {
-	return __raw_readq(i2c->twsi_base + TWSI_INT);
+	return __raw_readq(i2c->twsi_base + TWSI_INT(i2c));
 }
 
 /**
@@ -196,7 +197,7 @@ static inline u64 octeon_i2c_read_int(struct octeon_i2c *i2c)
  */
 static inline void octeon_i2c_write_int(struct octeon_i2c *i2c, u64 data)
 {
-	octeon_i2c_writeq_flush(data, i2c->twsi_base + TWSI_INT);
+	octeon_i2c_writeq_flush(data, i2c->twsi_base + TWSI_INT(i2c));
 }
 
 /* Prototypes */
diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index fec4306..038007d 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -163,6 +163,10 @@ static int octeon_i2c_probe(struct platform_device *pdev)
 	}
 	i2c->dev = &pdev->dev;
 
+	i2c->roff.sw_twsi = 0x00;
+	i2c->roff.twsi_int = 0x10;
+	i2c->roff.sw_twsi_ext = 0x18;
+
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2c->twsi_base = devm_ioremap_resource(&pdev->dev, res_mem);
 	if (IS_ERR(i2c->twsi_base)) {
diff --git a/drivers/i2c/busses/i2c-thunderx-core.c b/drivers/i2c/busses/i2c-thunderx-core.c
index 656b405..8fcd26c 100644
--- a/drivers/i2c/busses/i2c-thunderx-core.c
+++ b/drivers/i2c/busses/i2c-thunderx-core.c
@@ -134,6 +134,10 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	if (!i2c)
 		return -ENOMEM;
 
+	i2c->roff.sw_twsi = 0x1000;
+	i2c->roff.twsi_int = 0x1010;
+	i2c->roff.sw_twsi_ext = 0x1018;
+
 	i2c->dev = dev;
 	pci_set_drvdata(pdev, i2c);
 	ret = pci_enable_device(pdev);
-- 
1.9.1
