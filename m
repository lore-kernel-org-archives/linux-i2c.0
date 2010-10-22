From: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/12] hwmon: lis3: restore axis enabled bits
Date: Fri, 22 Oct 2010 14:57:28 +0300
Message-ID: <1287748654-2626-7-git-send-email-samu.p.onkalo@nokia.com>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

All axis enable bits are set to 0 at module remove.
Restore reset default value at init.

Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/hwmon/lis3lv02d_i2c.c |    2 +-
 drivers/hwmon/lis3lv02d_spi.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d_i2c.c b/drivers/hwmon/lis3lv02d_i2c.c
index 98983cc..36171bf 100644
--- a/drivers/hwmon/lis3lv02d_i2c.c
+++ b/drivers/hwmon/lis3lv02d_i2c.c
@@ -83,7 +83,7 @@ static int lis3_i2c_init(struct lis3lv02d *lis3)
 	if (ret < 0)
 		return ret;
 
-	reg |= CTRL1_PD0;
+	reg |= CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
 	return lis3->write(lis3, CTRL_REG1, reg);
 }
 
diff --git a/drivers/hwmon/lis3lv02d_spi.c b/drivers/hwmon/lis3lv02d_spi.c
index b9be5e3..778885d 100644
--- a/drivers/hwmon/lis3lv02d_spi.c
+++ b/drivers/hwmon/lis3lv02d_spi.c
@@ -50,7 +50,7 @@ static int lis3_spi_init(struct lis3lv02d *lis3)
 	if (ret < 0)
 		return ret;
 
-	reg |= CTRL1_PD0;
+	reg |= CTRL1_PD0 | CTRL1_Xen | CTRL1_Yen | CTRL1_Zen;
 	return lis3->write(lis3, CTRL_REG1, reg);
 }
 
-- 
1.6.0.4
