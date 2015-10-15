From: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape platforms
Date: Thu, 15 Oct 2015 20:12:57 +0800
Message-ID: <1444911181-21696-2-git-send-email-B48286@freescale.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444911181-21696-1-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Modify watchdog/Kconfig file to support Layerscape platforms.

Signed-off-by: Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
This patch has been acked in V3 by Guenter Roeck [linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org].

V4: V3 V2
 - No change.

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79e1aa1..448dbaf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || ARCH_LAYERSCAPE
 	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
