From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 4/5] i2c: octeon,thunderx: Check bus state before starting a transaction
Date: Wed, 21 Sep 2016 08:51:05 +0200
Message-ID: <21b1db0af4c62a53dc2fcec1e0b1f7b412e6f1be.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34820 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcIUGvm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 02:51:42 -0400
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Add an additional status check before starting a transaction and,
if required, trigger the recovery if the check fails.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 5e63b17..b21aa3e 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -630,6 +630,22 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
 	return ret;
 }
 
+static int octeon_i2c_check_bus(struct octeon_i2c *i2c)
+{
+	int stat, lines;
+
+	stat = octeon_i2c_stat_read(i2c);
+
+	/* get I2C line state */
+	lines = octeon_i2c_read_int(i2c) & (TWSI_INT_SCL | TWSI_INT_SDA);
+
+	if (stat == STAT_IDLE && lines == (TWSI_INT_SCL | TWSI_INT_SDA))
+		return 0;
+
+	/* bus check failed, try to recover */
+	return octeon_i2c_recovery(i2c);
+}
+
 /**
  * octeon_i2c_xfer - The driver's master_xfer function
  * @adap: Pointer to the i2c_adapter structure
@@ -643,6 +659,10 @@ int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
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
