From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH/RFT 1/6] i2c: designware: use open drain for recovery GPIO
Date: Fri, 13 Jul 2018 23:09:13 +0200
Message-ID: <20180713210920.3648-2-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

I2C is open drain, so set up the GPIO accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index fc7c255c80af..a546db80f53e 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -665,7 +665,7 @@ static int i2c_dw_init_recovery_info(struct dw_i2c_dev *dev)
 	struct gpio_desc *gpio;
 	int r;
 
-	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH_OPEN_DRAIN);
 	if (IS_ERR(gpio)) {
 		r = PTR_ERR(gpio);
 		if (r == -ENOENT || r == -ENOSYS)
-- 
2.11.0
