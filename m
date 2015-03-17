From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH] i2c-gpio: add board_info to pdata
Date: Tue, 17 Mar 2015 12:14:55 +0000
Message-ID: <1426594495-31844-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add board_info so that the i2c-gpio driver can probe devices on probe
so that i2c_register_board_info() does not need to be used. This is
preferable for devices that get hotplugged as otherwise we need to do
i2c_unregister_board_info() which would be more code.

Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c | 8 ++++++++
 include/linux/i2c-gpio.h      | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index 34cfc0e..d1050bd 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -232,6 +232,14 @@ static int i2c_gpio_probe(struct platform_device *pdev)
 		 pdata->scl_is_output_only
 		 ? ", no clock stretching" : "");
 
+	if (pdata->board_info) {
+		struct i2c_board_info const *info = pdata->board_info;
+		int nr;
+
+		for (nr = 0; nr <  pdata->board_size; info++, nr++)
+			i2c_new_device(adap, info);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/i2c-gpio.h b/include/linux/i2c-gpio.h
index c1bcb1f..b4d2505 100644
--- a/include/linux/i2c-gpio.h
+++ b/include/linux/i2c-gpio.h
@@ -17,6 +17,8 @@
  * @udelay: signal toggle delay. SCL frequency is (500 / udelay) kHz
  * @timeout: clock stretching timeout in jiffies. If the slave keeps
  *	SCL low for longer than this, the transfer will time out.
+ * @board_size: The number of entries in the board_info field.
+ * @board_info: List of devices to be added by this i2c bus at probe time.
  * @sda_is_open_drain: SDA is configured as open drain, i.e. the pin
  *	isn't actively driven high when setting the output value high.
  *	gpio_get_value() must return the actual pin state even if the
@@ -30,6 +32,8 @@ struct i2c_gpio_platform_data {
 	unsigned int	scl_pin;
 	int		udelay;
 	int		timeout;
+	int		board_size;
+	struct i2c_board_info *board_info;
 	unsigned int	sda_is_open_drain:1;
 	unsigned int	scl_is_open_drain:1;
 	unsigned int	scl_is_output_only:1;
-- 
2.1.4
