From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: octeon: Remove zero-length message support
Date: Tue, 26 Apr 2016 16:26:52 +0200
Message-ID: <1461680812-10237-1-git-send-email-jglauber@cavium.com>
References: <20160426125342.GB23679@katana>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32894 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbcDZOnN (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 26 Apr 2016 10:43:13 -0400
In-Reply-To: <20160426125342.GB23679@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>

Zero-length message support (SMBUS QUICK or i2c) never worked with
the Octeon hardware. Disable SMBUS QUICK support and bail out in
case of a zero-length i2c request.

After this change 'i2c-detect -q' will return an error on Octeon but
the previously reported results were wrong anyway.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index 9f11e19..e8a65f5 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -837,9 +837,6 @@ static int octeon_i2c_read(struct octeon_i2c *i2c, int target,
 	int i, result, length = *rlength;
 	bool final_read = false;
 
-	if (length < 1)
-		return -EINVAL;
-
 	octeon_i2c_data_write(i2c, (target << 1) | 1);
 	octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB);
 
@@ -925,6 +922,12 @@ static int octeon_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	for (i = 0; ret == 0 && i < num; i++) {
 		struct i2c_msg *pmsg = &msgs[i];
 
+		/* zero-length messages are not supported */
+		if (!pmsg->len) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
+
 		ret = octeon_i2c_start(i2c);
 		if (ret)
 			return ret;
@@ -998,7 +1001,7 @@ static struct i2c_bus_recovery_info octeon_i2c_recovery_info = {
 
 static u32 octeon_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
+	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK) |
 	       I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_SMBUS_BLOCK_PROC_CALL;
 }
 
-- 
1.9.1
