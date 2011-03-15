From: Ilkka Koskinen <ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 1/5] hwmon: lis3: Free regulators if probe() fails.
Date: Tue, 15 Mar 2011 18:02:41 +0200
Message-ID: <1300204965-7209-2-git-send-email-ilkka.koskinen@nokia.com>
References: <1300204965-7209-1-git-send-email-ilkka.koskinen@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300204965-7209-1-git-send-email-ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Ilkka Koskinen <ilkka.koskinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/hwmon/lis3lv02d_i2c.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 8853afc..d834505 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -161,8 +161,13 @@ static int __devinit lis3lv02d_i2c_probe(struct i2c_client *client,
 	if (lis3_dev.reg_ctrl)
 		lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
 
-	if (ret == 0)
-		return 0;
+	if (ret)
+		goto fail2;
+	return 0;
+
+fail2:
+	regulator_bulk_free(ARRAY_SIZE(lis3_dev.regulators),
+				lis3_dev.regulators);
 fail:
 	if (pdata && pdata->release_resources)
 		pdata->release_resources();
-- 
1.7.0.4
