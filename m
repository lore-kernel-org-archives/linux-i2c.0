From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 01/40] i2c: qup: Move bus frequency definitions to i2c.h
Date: Mon, 24 Feb 2020 17:14:51 +0200
Message-ID: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17577 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgBXPPh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:37 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

Move bus frequency definitions to i2c.h for wider use.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-qup.c | 9 ++-------
 include/linux/i2c.h          | 7 +++++++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 2d7dabe12723..b9d48ace9ff2 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -136,13 +136,8 @@
  */
 #define TOUT_MIN			2
 
-/* I2C Frequency Modes */
-#define I2C_STANDARD_FREQ		100000
-#define I2C_FAST_MODE_FREQ		400000
-#define I2C_FAST_MODE_PLUS_FREQ		1000000
-
 /* Default values. Use these if FW query fails */
-#define DEFAULT_CLK_FREQ I2C_STANDARD_FREQ
+#define DEFAULT_CLK_FREQ I2C_STANDARD_MODE_FREQ
 #define DEFAULT_SRC_CLK 20000000
 
 /*
@@ -1861,7 +1856,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	qup->in_fifo_sz = qup->in_blk_sz * (2 << size);
 
 	hs_div = 3;
-	if (clk_freq <= I2C_STANDARD_FREQ) {
+	if (clk_freq <= I2C_STANDARD_MODE_FREQ) {
 		fs_div = ((src_clk_freq / clk_freq) / 2) - 3;
 		qup->clk_ctl = (hs_div << 8) | (fs_div & 0xff);
 	} else {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f834687989f7..708ac1262a0c 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -39,6 +39,13 @@ enum i2c_slave_event;
 typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
 			      enum i2c_slave_event event, u8 *val);
 
+#define HZ_PER_KHZ			1000
+
+/* I2C Frequency Modes */
+#define I2C_STANDARD_MODE_FREQ		(100 * HZ_PER_KHZ)
+#define I2C_FAST_MODE_FREQ		(400 * HZ_PER_KHZ)
+#define I2C_FAST_MODE_PLUS_FREQ		(1000 * HZ_PER_KHZ)
+
 struct module;
 struct property_entry;
 
-- 
2.25.0
