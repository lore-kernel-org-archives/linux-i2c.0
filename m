From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH/RFT 6/6] i2c: recovery: remove bogus check if SDA GPIO is set to output
Date: Fri, 13 Jul 2018 23:09:18 +0200
Message-ID: <20180713210920.3648-7-wsa+renesas@sang-engineering.com>
References: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713210920.3648-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel@pengutronix.de, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This check did not work as intended. I2C is open drain, so this function
will likely always have presented the GPIO as input because
gpiod_get_direction doesn't know about open drain states. Remove this
check for now. We can add it again once we know how to get more precise
information about the GPIO.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 301285c54603..7c5f012f561c 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -261,9 +261,7 @@ static void i2c_init_recovery(struct i2c_adapter *adap)
 		bri->set_scl = set_scl_gpio_value;
 		if (bri->sda_gpiod) {
 			bri->get_sda = get_sda_gpio_value;
-			/* FIXME: add proper flag instead of '0' once available */
-			if (gpiod_get_direction(bri->sda_gpiod) == 0)
-				bri->set_sda = set_sda_gpio_value;
+			bri->set_sda = set_sda_gpio_value;
 		}
 		return;
 	}
-- 
2.11.0
