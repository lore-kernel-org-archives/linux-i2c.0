From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/5] i2c: sirf: reset i2c controller early after we get a noack
Date: Tue, 13 Aug 2013 17:11:27 +0800
Message-ID: <1376385091-30597-2-git-send-email-Baohua.Song@csr.com>
References: <1376385091-30597-1-git-send-email-Baohua.Song@csr.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376385091-30597-1-git-send-email-Baohua.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>

Due to hardware ANOMALY, we need to reset I2C earlier after
we get NOACK while accessing non-existing clients, otherwise
we will get errors even we access existing clients later

Signed-off-by: Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index a63c7d5..055210e 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -65,6 +65,8 @@
 #define SIRFSOC_I2C_START		BIT(7)
 
 #define SIRFSOC_I2C_DEFAULT_SPEED 100000
+#define SIRFSOC_I2C_ERR_NOACK      1
+#define SIRFSOC_I2C_ERR_TIMEOUT    2
 
 struct sirfsoc_i2c {
 	void __iomem *base;
@@ -143,14 +145,24 @@ static irqreturn_t i2c_sirfsoc_irq(int irq, void *dev_id)
 
 	if (i2c_stat & SIRFSOC_I2C_STAT_ERR) {
 		/* Error conditions */
-		siic->err_status = 1;
+		siic->err_status = SIRFSOC_I2C_ERR_NOACK;
 		writel(SIRFSOC_I2C_STAT_ERR, siic->base + SIRFSOC_I2C_STATUS);
 
 		if (i2c_stat & SIRFSOC_I2C_STAT_NACK)
-			dev_err(&siic->adapter.dev, "ACK not received\n");
+			dev_dbg(&siic->adapter.dev, "ACK not received\n");
 		else
 			dev_err(&siic->adapter.dev, "I2C error\n");
 
+		/*
+		 * Due to hardware ANOMALY, we need to reset I2C earlier after
+		 * we get NOACK while accessing non-existing clients, otherwise
+		 * we will get errors even we access existing clients later
+		 */
+		writel(readl(siic->base + SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
+				siic->base + SIRFSOC_I2C_CTRL);
+		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
+			cpu_relax();
+
 		complete(&siic->done);
 	} else if (i2c_stat & SIRFSOC_I2C_STAT_CMD_DONE) {
 		/* CMD buffer execution complete */
@@ -191,7 +203,6 @@ static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
 	u32 regval = readl(siic->base + SIRFSOC_I2C_CTRL);
 	/* timeout waiting for the xfer to finish or fail */
 	int timeout = msecs_to_jiffies((msg->len + 1) * 50);
-	int ret = 0;
 
 	i2c_sirfsoc_set_address(siic, msg);
 
@@ -200,7 +211,7 @@ static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
 	i2c_sirfsoc_queue_cmd(siic);
 
 	if (wait_for_completion_timeout(&siic->done, timeout) == 0) {
-		siic->err_status = 1;
+		siic->err_status = SIRFSOC_I2C_ERR_TIMEOUT;
 		dev_err(&siic->adapter.dev, "Transfer timeout\n");
 	}
 
@@ -208,16 +219,14 @@ static int i2c_sirfsoc_xfer_msg(struct sirfsoc_i2c *siic, struct i2c_msg *msg)
 		siic->base + SIRFSOC_I2C_CTRL);
 	writel(0, siic->base + SIRFSOC_I2C_CMD_START);
 
-	if (siic->err_status) {
+	/* i2c control doesn't response, reset it */
+	if (siic->err_status == SIRFSOC_I2C_ERR_TIMEOUT) {
 		writel(readl(siic->base + SIRFSOC_I2C_CTRL) | SIRFSOC_I2C_RESET,
 			siic->base + SIRFSOC_I2C_CTRL);
 		while (readl(siic->base + SIRFSOC_I2C_CTRL) & SIRFSOC_I2C_RESET)
 			cpu_relax();
-
-		ret = -EIO;
 	}
-
-	return ret;
+	return siic->err_status ? -EIO : 0;
 }
 
 static u32 i2c_sirfsoc_func(struct i2c_adapter *adap)
-- 
1.8.2.3
