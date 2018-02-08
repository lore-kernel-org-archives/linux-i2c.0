From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH] i2c: bcm2835: Set up the rising/falling edge delays
Date: Thu,  8 Feb 2018 14:54:05 +0100
Message-ID: <20180208135405.25446-1-boris.brezillon@bootlin.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44557 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbeBHNyS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 8 Feb 2018 08:54:18 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Eric Anholt <eric@anholt.net>

We were leaving them in the power on state (or the state the firmware
had set up for some client, if we were taking over from them).  The
boot state was 30 core clocks, when we actually want to sample some
time after (to make sure that the new input bit has actually arrived).

Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
Hello,

I'm reviving this patch that has been posted a while ago by Gerd.
It fixes EDID retrieval on some (broken?) HDMI displays, but I'm pretty
sure it will fix other I2C setup.

Note that I also tested the change with a regular I2C device and it
worked just fine.

Regards,

Boris

Changes in v2:
- rebase on 4.15
---
 drivers/i2c/busses/i2c-bcm2835.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index cd07a69e2e93..44deae78913e 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,6 +50,9 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
+#define BCM2835_I2C_FEDL_SHIFT	16
+#define BCM2835_I2C_REDL_SHIFT	0
+
 #define BCM2835_I2C_CDIV_MIN	0x0002
 #define BCM2835_I2C_CDIV_MAX	0xFFFE
 
@@ -81,7 +84,7 @@ static inline u32 bcm2835_i2c_readl(struct bcm2835_i2c_dev *i2c_dev, u32 reg)
 
 static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
 {
-	u32 divider;
+	u32 divider, redl, fedl;
 
 	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk),
 			       i2c_dev->bus_clk_rate);
@@ -100,6 +103,22 @@ static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
+	/*
+	 * Number of core clocks to wait after falling edge before
+	 * outputting the next data bit.  Note that both FEDL and REDL
+	 * can't be greater than CDIV/2.
+	 */
+	fedl = max(divider / 16, 1u);
+
+	/*
+	 * Number of core clocks to wait after rising edge before
+	 * sampling the next incoming data bit.
+	 */
+	redl = max(divider / 4, 1u);
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
+			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
+			   (redl << BCM2835_I2C_REDL_SHIFT));
 	return 0;
 }
 
-- 
2.14.1
