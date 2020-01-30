From: Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 16/17] i2c: cros-ec-tunnel: Use cros_ec_send_cmd_msg()
Date: Thu, 30 Jan 2020 12:31:08 -0800
Message-ID: <20200130203106.201894-17-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41419 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgA3Ug1 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 30 Jan 2020 15:36:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so1781061plr.8
        for <linux-i2c@vger.kernel.org>; Thu, 30 Jan 2020 12:36:27 -0800 (PST)
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prashant Malani <pmalani@chromium.org>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Wolfram Sang <wsa@the-dreams.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Akshu Agrawal <akshu.agrawal@amd.com>, "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>

Replace cros_ec_cmd_xfer_status() calls with the new function
cros_ec_send_cmd_msg() which takes care of the EC message struct setup
and subsequent cleanup (which is a common pattern among users of
cros_ec_cmd_xfer_status).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985d9..50161dff912298 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -179,9 +179,8 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 	const u16 bus_num = bus->remote_bus;
 	int request_len;
 	int response_len;
-	int alloc_size;
 	int result;
-	struct cros_ec_command *msg;
+	void *ec_buf;
 
 	request_len = ec_i2c_count_message(i2c_msgs, num);
 	if (request_len < 0) {
@@ -196,36 +195,32 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 		return response_len;
 	}
 
-	alloc_size = max(request_len, response_len);
-	msg = kmalloc(sizeof(*msg) + alloc_size, GFP_KERNEL);
-	if (!msg)
+	ec_buf = kmalloc(max(request_len, response_len), GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	result = ec_i2c_construct_message(msg->data, i2c_msgs, num, bus_num);
+	result = ec_i2c_construct_message(ec_buf, i2c_msgs, num, bus_num);
 	if (result) {
 		dev_err(dev, "Error constructing EC i2c message %d\n", result);
 		goto exit;
 	}
 
-	msg->version = 0;
-	msg->command = EC_CMD_I2C_PASSTHRU;
-	msg->outsize = request_len;
-	msg->insize = response_len;
-
-	result = cros_ec_cmd_xfer_status(bus->ec, msg);
+	result = cros_ec_send_cmd_msg(bus->ec, 0, EC_CMD_I2C_PASSTHRU,
+				      ec_buf, request_len,
+				      ec_buf, response_len);
 	if (result < 0) {
 		dev_err(dev, "Error transferring EC i2c message %d\n", result);
 		goto exit;
 	}
 
-	result = ec_i2c_parse_response(msg->data, i2c_msgs, &num);
+	result = ec_i2c_parse_response(ec_buf, i2c_msgs, &num);
 	if (result < 0)
 		goto exit;
 
 	/* Indicate success by saying how many messages were sent */
 	result = num;
 exit:
-	kfree(msg);
+	kfree(ec_buf);
 	return result;
 }
 
-- 
2.25.0.341.g760bfbb309-goog
