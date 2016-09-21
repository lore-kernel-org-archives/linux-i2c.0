From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 3/5] i2c: octeon,thunderx: Fix high-level controller status check
Date: Wed, 21 Sep 2016 08:51:04 +0200
Message-ID: <3d2e2e4e91e2245318a278b19f22e9b1af3204d1.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33695 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbcIUGvl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 21 Sep 2016 02:51:41 -0400
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
In-Reply-To: <cover.1474439371.git.jglauber@cavium.com>
References: <cover.1474439371.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

In case the high-level controller (HLC) is used the status code is
reported at a different location. Check that location after HLC
write operations if the ready bit is not set and return an appropriate
error code instead of always returning -EAGAIN.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 7d4df83..5e63b17 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -215,7 +215,16 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 
 static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 {
-	u8 stat = octeon_i2c_stat_read(i2c);
+	u8 stat;
+
+	/*
+	 * This is ugly... in HLC mode the status is not in the status register
+	 * but in the lower 8 bits of SW_TWSI.
+	 */
+	if (i2c->hlc_enabled)
+		stat = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
+	else
+		stat = octeon_i2c_stat_read(i2c);
 
 	switch (stat) {
 	/* Everything is fine */
@@ -453,7 +462,7 @@ static int octeon_i2c_hlc_read(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
+		return octeon_i2c_check_status(i2c, false);
 
 	for (i = 0, j = msgs[0].len - 1; i  < msgs[0].len && i < 4; i++, j--)
 		msgs[0].buf[j] = (cmd >> (8 * i)) & 0xff;
@@ -506,9 +515,7 @@ static int octeon_i2c_hlc_write(struct octeon_i2c *i2c, struct i2c_msg *msgs)
 
 	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-
-	ret = octeon_i2c_check_status(i2c, false);
+		return octeon_i2c_check_status(i2c, false);
 
 err:
 	return ret;
@@ -553,7 +560,7 @@ static int octeon_i2c_hlc_comp_read(struct octeon_i2c *i2c, struct i2c_msg *msgs
 
 	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
+		return octeon_i2c_check_status(i2c, false);
 
 	for (i = 0, j = msgs[1].len - 1; i  < msgs[1].len && i < 4; i++, j--)
 		msgs[1].buf[j] = (cmd >> (8 * i)) & 0xff;
@@ -617,9 +624,7 @@ static int octeon_i2c_hlc_comp_write(struct octeon_i2c *i2c, struct i2c_msg *msg
 
 	cmd = __raw_readq(i2c->twsi_base + SW_TWSI(i2c));
 	if ((cmd & SW_TWSI_R) == 0)
-		return -EAGAIN;
-
-	ret = octeon_i2c_check_status(i2c, false);
+		return octeon_i2c_check_status(i2c, false);
 
 err:
 	return ret;
-- 
1.9.1
