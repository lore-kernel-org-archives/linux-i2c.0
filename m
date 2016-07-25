From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] i2c: i2c-cros-ec-tunnel: Reduce logging noise
Date: Mon, 25 Jul 2016 13:11:04 -0700
Message-ID: <1469477464-28735-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34787 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcGYULM (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 25 Jul 2016 16:11:12 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dianders@chromium.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

If an i2c access through i2c-cros-ec-tunnel returns an error, the following
log message is seen on the console.

cros-ec-i2c-tunnel ff200000.spi:ec@0:i2c-tunnel:
			Error parsing EC i2c message -121

This can happen a lot if, for example, the i2c-detect command is executed.

Since it is perfectly normal for an i2c controller to report an error,
replace the error message with a debug message. Also, report -ENXIO
instead of -EREMOTEIO if the access error is due to NAK from the device,
as suggested in Documentation/i2c/fault-codes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index a0d95ff682ae..95f26fecc6e9 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -154,7 +154,9 @@ static int ec_i2c_parse_response(const u8 *buf, struct i2c_msg i2c_msgs[],
 	resp = (const struct ec_response_i2c_passthru *)buf;
 	if (resp->i2c_status & EC_I2C_STATUS_TIMEOUT)
 		return -ETIMEDOUT;
-	else if (resp->i2c_status & EC_I2C_STATUS_ERROR)
+	else if (resp->i2c_status & EC_I2C_STATUS_NAK)
+		return -ENXIO;
+	else if (resp->i2c_status)
 		return -EREMOTEIO;
 
 	/* Other side could send us back fewer messages, but not more */
@@ -223,7 +225,7 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 
 	result = ec_i2c_parse_response(msg->data, i2c_msgs, &num);
 	if (result < 0) {
-		dev_err(dev, "Error parsing EC i2c message %d\n", result);
+		dev_dbg(dev, "Error parsing EC i2c message %d\n", result);
 		goto exit;
 	}
 
-- 
2.5.0
