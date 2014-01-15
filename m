From: Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
Subject: [PATCH repost] at91: dt: i2c: add a new compatibility string for the at91sam9261
Date: Wed, 15 Jan 2014 14:17:13 +0100
Message-ID: <1389791833-7572-1-git-send-email-jjhiblot@traphandler.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, b.brezillon-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 8edba9d..843d012 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -589,6 +589,9 @@ static const struct of_device_id atmel_twi_dt_ids[] = {
 		.compatible = "atmel,at91sam9260-i2c",
 		.data = &at91sam9260_config,
 	} , {
+		.compatible = "atmel,at91sam9261-i2c",
+		.data = &at91sam9261_config,
+	} , {
 		.compatible = "atmel,at91sam9g20-i2c",
 		.data = &at91sam9g20_config,
 	} , {
-- 
1.8.5.2
