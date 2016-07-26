From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3] i2c: i2c-cros-ec-tunnel: Reduce logging noise
Date: Tue, 26 Jul 2016 15:34:01 -0700
Message-ID: <1469572441-25026-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dianders@chromium.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-i2c@vger.kernel.org

If an i2c access through i2c-cros-ec-tunnel returns an error, the following
log message is seen on the console.

cros-ec-i2c-tunnel ff200000.spi:ec@0:i2c-tunnel:
			Error parsing EC i2c message -121

This can happen a lot if, for example, the i2c-detect command is executed.

Since it is perfectly normal for an i2c controller to report an error,
drop the message. Also, report -ENXIO instead of -EREMOTEIO if the access
error is due to NAK from the device, and return -EIO instead of -EREMOTEIO
for other errors, as suggested in Documentation/i2c/fault-codes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Do not assume that unknown status bits reflect an error.
v2: Drop message entirely instead of replacing it with dev_dbg,
    and return -EIO instead of -EREMOTEIO for unknown errors.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index a0d95ff682ae..0e9653852069 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -154,8 +154,10 @@ static int ec_i2c_parse_response(const u8 *buf, struct i2c_msg i2c_msgs[],
 	resp = (const struct ec_response_i2c_passthru *)buf;
 	if (resp->i2c_status & EC_I2C_STATUS_TIMEOUT)
 		return -ETIMEDOUT;
+	else if (resp->i2c_status & EC_I2C_STATUS_NAK)
+		return -ENXIO;
 	else if (resp->i2c_status & EC_I2C_STATUS_ERROR)
-		return -EREMOTEIO;
+		return -EIO;
 
 	/* Other side could send us back fewer messages, but not more */
 	if (resp->num_msgs > *num)
@@ -222,10 +224,8 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 	}
 
 	result = ec_i2c_parse_response(msg->data, i2c_msgs, &num);
-	if (result < 0) {
-		dev_err(dev, "Error parsing EC i2c message %d\n", result);
+	if (result < 0)
 		goto exit;
-	}
 
 	/* Indicate success by saying how many messages were sent */
 	result = num;
-- 
2.5.0
