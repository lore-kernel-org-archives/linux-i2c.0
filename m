From: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: [PATCH 6/6] i2c: Xilinx IIC: add DT Endianness support
Date: Fri, 31 Jul 2015 14:00:34 +0200
Message-ID: <1438344034-20211-8-git-send-email-rabel@cit-ec.uni-bielefeld.de>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-1-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 6a834bc..ab040a5 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -76,6 +76,8 @@ enum xilinx_i2c_reason {
  * @state:   Current controller state
  * @reasons: Reason for entering STATE_ERROR.
  *           Only valid while in STATE_ERROR.
+ * @getreg32: Register Read function, respects DT endianness.
+ * @setreg32: Register Write function, respects DT endianness.
  */
 struct xiic_i2c {
 	void __iomem *         base;
@@ -87,6 +89,8 @@ struct xiic_i2c {
 	unsigned int           nmsgs;
 	enum xilinx_i2c_state  state;
 	enum xilinx_i2c_reason reason;
+	u32                    (*getreg32)(const volatile void __iomem *addr);
+	void                   (*setreg32)(u32 value, volatile void __iomem *addr);
 };
 
 
@@ -175,8 +179,28 @@ struct xiic_i2c {
 static void xiic_enqueue_msg(struct xiic_i2c *i2c);
 
 #define xiic_msg_space(i2c) ((i2c)->msg->len - (i2c)->pos)
-#define xiic_getreg32(i2c, reg)        ioread32(i2c->base + reg)
-#define xiic_setreg32(i2c, reg, value) iowrite32(value, i2c->base + reg)
+#define xiic_getreg32(i2c, reg)        (i2c->getreg32(i2c->base + reg))
+#define xiic_setreg32(i2c, reg, value) (i2c->setreg32(value, i2c->base + reg))
+
+static u32 xiic_getreg32le(const volatile void __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static void xiic_setreg32le(u32 value, volatile void __iomem *addr)
+{
+	iowrite32(value, addr);
+}
+
+static u32 xiic_getreg32be(const volatile void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void xiic_setreg32be(u32 value, volatile void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
 
 static inline void xiic_irq_dis(struct xiic_i2c *i2c, u32 mask)
 {
@@ -1114,6 +1138,16 @@ static int xiic_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		return ret;
 	}
+	
+	i2c->getreg32 = xiic_getreg32le;
+	i2c->setreg32 = xiic_setreg32le;
+
+#if defined(CONFIG_OF)
+	if (of_device_is_big_endian(pdev->dev.of_node)) {
+		i2c->getreg32 = xiic_getreg32be;
+		i2c->setreg32 = xiic_setreg32be;
+	}
+#endif
 
 	xiic_reinit(i2c);
 
-- 
2.5.0
