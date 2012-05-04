From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/15] drivers/mfd: db8500-prcmu: Add support for regulator supply for nmk-i2c.4
Date: Fri,  4 May 2012 19:23:20 +0100
Message-ID: <1336155805-18554-11-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This applies a supply alias for the db8500's fifth Nomadik i2c port.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mfd/db8500-prcmu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 9bc75a8..d534449 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2720,6 +2720,7 @@ static struct regulator_consumer_supply db8500_vape_consumers[] = {
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.1"),
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.2"),
 	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.3"),
+	REGULATOR_SUPPLY("v-i2c", "nmk-i2c.4"),
 	/* "v-mmc" changed to "vcore" in the mainline kernel */
 	REGULATOR_SUPPLY("vcore", "sdi0"),
 	REGULATOR_SUPPLY("vcore", "sdi1"),
-- 
1.7.9.5
