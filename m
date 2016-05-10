From: David Wu <david.wu@rock-chips.com>
Subject: [PATCH v8 1/8] i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
Date: Wed, 11 May 2016 03:24:05 +0800
Message-ID: <1462908252-27016-2-git-send-email-david.wu@rock-chips.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:54171 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbcEKECb (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 00:02:31 -0400
In-Reply-To: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: heiko@sntech.de, wsa@the-dreams.de
Cc: robh+dt@kernel.org, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <david.wu@rock-chips.com>

Signed-off-by: David Wu <david.wu@rock-chips.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Change in v8:
- none

 drivers/i2c/busses/i2c-rk3x.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 80bed02..7e45d51 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -90,6 +90,26 @@ struct rk3x_i2c_soc_data {
 	int grf_offset;
 };
 
+/**
+ * struct rk3x_i2c - private data of the controller
+ * @adap: corresponding I2C adapter
+ * @dev: device for this controller
+ * @soc_data: related soc data struct
+ * @regs: virtual memory area
+ * @clk: clock of i2c bus
+ * @clk_rate_nb: i2c clk rate change notify
+ * @t: I2C known timing information
+ * @lock: spinlock for the i2c bus
+ * @wait: the waitqueue to wait for i2c transfer
+ * @busy: the condition for the event to wait for
+ * @msg: current i2c message
+ * @addr: addr of i2c slave device
+ * @mode: mode of i2c transfer
+ * @is_last_msg: flag determines whether it is the last msg in this transfer
+ * @state: state of i2c transfer
+ * @processed: byte length which has been send or received
+ * @error: error code for i2c transfer
+ */
 struct rk3x_i2c {
 	struct i2c_adapter adap;
 	struct device *dev;
@@ -116,7 +136,7 @@ struct rk3x_i2c {
 
 	/* I2C state machine */
 	enum rk3x_i2c_state state;
-	unsigned int processed; /* sent/received bytes */
+	unsigned int processed;
 	int error;
 };
 
-- 
1.9.1
