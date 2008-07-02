From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] rtc-pcf8563: Remove client validation
Date: Wed, 2 Jul 2008 13:32:14 +0200
Message-ID: <200807021332.15495.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Rod Whitby <rod-wR+KslBqWDsXC2x5gXVKYQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Validating clients with black magic register checks doesn't make much sense
for new-style i2c driver and has been known to fail on valid NXP pcf8563 chips.
This patch removes the client validation code.

Signed-off-by: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
---
 drivers/rtc/rtc-pcf8563.c |   58 ---------------------------------------------
 1 files changed, 0 insertions(+), 58 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 0fc4c36..59ab8b4 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -179,58 +179,6 @@ struct pcf8563_limit
 	unsigned char max;
 };
 
-static int pcf8563_validate_client(struct i2c_client *client)
-{
-	int i;
-
-	static const struct pcf8563_limit pattern[] = {
-		/* register, mask, min, max */
-		{ PCF8563_REG_SC,	0x7F,	0,	59	},
-		{ PCF8563_REG_MN,	0x7F,	0,	59	},
-		{ PCF8563_REG_HR,	0x3F,	0,	23	},
-		{ PCF8563_REG_DM,	0x3F,	0,	31	},
-		{ PCF8563_REG_MO,	0x1F,	0,	12	},
-	};
-
-	/* check limits (only registers with bcd values) */
-	for (i = 0; i < ARRAY_SIZE(pattern); i++) {
-		int xfer;
-		unsigned char value;
-		unsigned char buf = pattern[i].reg;
-
-		struct i2c_msg msgs[] = {
-			{ client->addr, 0, 1, &buf },
-			{ client->addr, I2C_M_RD, 1, &buf },
-		};
-
-		xfer = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
-
-		if (xfer != ARRAY_SIZE(msgs)) {
-			dev_err(&client->dev,
-				"%s: could not read register 0x%02X\n",
-				__func__, pattern[i].reg);
-
-			return -EIO;
-		}
-
-		value = BCD2BIN(buf & pattern[i].mask);
-
-		if (value > pattern[i].max ||
-			value < pattern[i].min) {
-			dev_dbg(&client->dev,
-				"%s: pattern=%d, reg=%x, mask=0x%02x, min=%d, "
-				"max=%d, value=%d, raw=0x%02X\n",
-				__func__, i, pattern[i].reg, pattern[i].mask,
-				pattern[i].min, pattern[i].max,
-				value, buf);
-
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
 static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	return pcf8563_get_datetime(to_i2c_client(dev), tm);
@@ -262,12 +210,6 @@ static int pcf8563_probe(struct i2c_client *client,
 	if (!pcf8563)
 		return -ENOMEM;
 
-	/* Verify the chip is really an PCF8563 */
-	if (pcf8563_validate_client(client) < 0) {
-		err = -ENODEV;
-		goto exit_kfree;
-	}
-
 	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
 
 	pcf8563->rtc = rtc_device_register(pcf8563_driver.driver.name,
-- 
1.5.0


-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
