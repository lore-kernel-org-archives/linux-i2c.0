From: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Subject: [PATCH] i2c-gpio: OF gpio code does not handle defered probe case
Date: Thu, 13 Mar 2014 14:37:38 +0000
Message-ID: <1394721458-23585-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When using device-tree and the i2c-gpio driver is called before the
GPIO node has been probed then it needs to correctly defer the probe
instead of returning a permanent error that the gpio numbers are not
valid.

This fixes the following error:
	/i2c@2: invalid GPIO pins, sda=-517/scl=-517

Signed-off-by: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index d9f7e18..02d2d4a 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -94,6 +94,9 @@ static int of_i2c_gpio_get_pins(struct device_node *np,
 	*sda_pin = of_get_gpio(np, 0);
 	*scl_pin = of_get_gpio(np, 1);
 
+	if (*sda_pin == -EPROBE_DEFER || *scl_pin == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
 	if (!gpio_is_valid(*sda_pin) || !gpio_is_valid(*scl_pin)) {
 		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
 		       np->full_name, *sda_pin, *scl_pin);
-- 
1.9.0
