From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 2/3] i2c: octeon: Add retry logic after receiving STAT_RXADDR_NAK
Date: Wed,  8 Jun 2016 08:51:18 +0200
Message-ID: <2cc75a97f920146edc7af389870e271a8a056dd1.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34040 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbcFHGvv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Jun 2016 02:51:51 -0400
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
In-Reply-To: <cover.1465304877.git.jglauber@cavium.com>
References: <cover.1465304877.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Steven.Hill@caviumnetworks.com, Jan Glauber <jglauber@cavium.com>

The controller specification states that when receiving STAT_RXADDR_NAK
the START should be sent again. Retry several times before finally
failing with -ENXIO.

Without this change the IPMI SSIF driver fails executing several commands
like 'ipmitool fru' on ThunderX.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 1922e4a..8ade7fb 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -880,6 +880,10 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 {
 	int i, result;
 
+	result = octeon_i2c_start(i2c);
+	if (result)
+		return result;
+
 	octeon_i2c_data_write(i2c, target << 1);
 	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
@@ -918,9 +922,14 @@ static int octeon_i2c_write(struct octeon_i2c *i2c, int target,
 static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 			   u8 *data, u16 *rlength, bool recv_len)
 {
-	int i, result, length = *rlength;
+	int i, result, length = *rlength, retries = 10;
 	bool final_read = false;
 
+restart:
+	result = octeon_i2c_start(i2c);
+	if (result)
+		return result;
+
 	octeon_i2c_data_write(i2c, (target << 1) | 1);
 	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
@@ -930,8 +939,17 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 
 	/* address OK ? */
 	result = octeon_i2c_check_status(i2c, false);
-	if (result)
-		return result;
+	if (result) {
+		/*
+		 * According to controller specification on STAT_RXADDR_NAK
+		 * the START should be repeated so retry several times before
+		 * giving up with -ENXIO.
+		 */
+		if (result == -ENXIO && --retries > 0)
+			goto restart;
+		else
+			return result;
+	}
 
 	for (i = 0; i < length; i++) {
 		/*
@@ -1019,10 +1037,6 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			break;
 		}
 
-		ret = octeon_i2c_start(i2c);
-		if (ret)
-			return ret;
-
 		if (pmsg->flags & I2C_M_RD)
 			ret = octeon_i2c_read(i2c, pmsg->addr, pmsg->buf,
 					      &pmsg->len, pmsg->flags & I2C_M_RECV_LEN);
-- 
2.9.0.rc0.21.g7777322
