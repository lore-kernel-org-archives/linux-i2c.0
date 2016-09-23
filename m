From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v2 1/2] i2c: octeon: thunderx: Check bus state before starting a transaction
Date: Fri, 23 Sep 2016 11:40:38 +0200
Message-ID: <ccf553c14d5220f3f9233ac7695d27ee0d55bcc7.1474565039.git.jglauber@cavium.com>
References: <cover.1474565039.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34557 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757333AbcIWJky (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Sep 2016 05:40:54 -0400
In-Reply-To: <cover.1474565039.git.jglauber@cavium.com>
In-Reply-To: <cover.1474565039.git.jglauber@cavium.com>
References: <cover.1474565039.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>, Jan Glauber <jglauber@cavium.com>

Add an additional status check before starting a transaction. If the
check fails wait for some time to tolerate multi-master mode. After the
timeout expires trigger the recovery.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5e63b17..f526511 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -630,6 +630,31 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
 	return ret;
 }
 
+static int octeon_i2c_check_bus(struct octeon_i2c *i2c)
+{
+	u64 end = get_jiffies_64() + i2c->adap.timeout;
+	int stat, lines;
+
+	while (time_before64(get_jiffies_64(), end)) {
+		stat = octeon_i2c_stat_read(i2c);
+
+		/* get I2C line state */
+		lines = octeon_i2c_read_int(i2c) & (TWSI_INT_SCL | TWSI_INT_SDA);
+
+		if (stat == STAT_IDLE && lines == (TWSI_INT_SCL | TWSI_INT_SDA))
+			return 0;
+
+		if (stat == STAT_LOST_ARB_38 || stat == STAT_LOST_ARB_68 ||
+		    stat == STAT_LOST_ARB_78 || stat == STAT_LOST_ARB_B0)
+			break;
+
+		usleep_range(I2C_OCTEON_EVENT_WAIT / 2, I2C_OCTEON_EVENT_WAIT);
+	}
+
+	/* bus check failed, try to recover */
+	return octeon_i2c_recovery(i2c);
+}
+
 /**
  * octeon_i2c_xfer - The driver's master_xfer function
  * @adap: Pointer to the i2c_adapter structure
@@ -643,6 +668,10 @@ int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 	int i, ret = 0;
 
+	ret = octeon_i2c_check_bus(i2c);
+	if (ret)
+		goto out;
+
 	if (num == 1) {
 		if (msgs[0].len > 0 && msgs[0].len <= 8) {
 			if (msgs[0].flags & I2C_M_RD)
-- 
1.9.1
