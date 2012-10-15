From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] i2c: i2c-gpio: fix name issue when i2c gpio node GT 1
Date: Mon, 15 Oct 2012 15:51:17 +0800
Message-ID: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When i2c-gpio node number is greater than 1, the name for each is same
So add the patch to fix it.

The adap->name printing information is add by myself

without this patch the log information is as following
---<8---
adap->name = i2c-gpio-1
i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
adap->name = i2c-gpio-1
i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
--->8---

with this patch, the log information is as following
---<8---
adap->name = i2c.2
i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
adap->name = i2c.3
i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
--->8---

Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-gpio.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
index e62d2d9..257299a 100644
--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -184,7 +184,11 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
 	bit_data->data = pdata;
 
 	adap->owner = THIS_MODULE;
-	snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
+	if (pdev->dev.of_node)
+		strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name));
+	else
+		snprintf(adap->name, sizeof(adap->name), "i2c-gpio%d", pdev->id);
+
 	adap->algo_data = bit_data;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
 	adap->dev.parent = &pdev->dev;
-- 
1.7.9.5
