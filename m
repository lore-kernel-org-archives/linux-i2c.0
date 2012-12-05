From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
Date: Wed,  5 Dec 2012 22:42:12 +0100
Message-ID: <1354743732-11581-1-git-send-email-manabian@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Hi,

AT91RM9200 is gaining DT support now so let's add an id to the i2c driver.

Tested on custom RM9200 board. Since the driver doesn't support pinctrl
muxing yet I had to add pinctrl hogs for the i2c pins in my dts for it
to work.

regards
Joachim Eastwood

 drivers/i2c/busses/i2c-at91.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index b4575ee..c504aa8 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -584,6 +584,9 @@ static const struct platform_device_id at91_twi_devtypes[] = {
 #if defined(CONFIG_OF)
 static const struct of_device_id atmel_twi_dt_ids[] = {
 	{
+		.compatible = "atmel,at91rm9200-i2c",
+		.data = &at91rm9200_config,
+	} , {
 		.compatible = "atmel,at91sam9260-i2c",
 		.data = &at91sam9260_config,
 	} , {
-- 
1.8.0
