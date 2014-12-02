From: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/4] i2c: cadence: Set the hardware time-out register to maximum value
Date: Tue,  2 Dec 2014 15:35:47 +0530
Message-ID: <1417514749-24319-3-git-send-email-harinik@xilinx.com>
References: <1417514749-24319-1-git-send-email-harinik@xilinx.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417514749-24319-1-git-send-email-harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>

Cadence I2C controller has bug wherein it generates invalid read transactions
after time-out in master receiver mode. This driver does not use the HW
timeout and this interrupt is disabled but the feature itself cannot be
disabled. Hence, this patch writes the maximum value (0xFF) to this register.
This is one of the workarounds to this bug and it will not avoid the issue
completely but reduce the chances of error.

Signed-off-by: Vishnu Motghare <vishnum-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-cadence.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index e54899e..8065205 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -111,6 +111,8 @@
 #define CDNS_I2C_DIVA_MAX	4
 #define CDNS_I2C_DIVB_MAX	64
 
+#define CDNS_I2C_TIMEOUT_MAX	0xFF
+
 #define cdns_i2c_readreg(offset)       readl_relaxed(id->membase + offset)
 #define cdns_i2c_writereg(val, offset) writel_relaxed(val, id->membase + offset)
 
@@ -858,6 +860,8 @@ static int cdns_i2c_probe(struct platform_device *pdev)
 		goto err_clk_dis;
 	}
 
+	cdns_i2c_writereg(CDNS_I2C_TIMEOUT_MAX, CDNS_I2C_TIME_OUT_OFFSET);
+
 	dev_info(&pdev->dev, "%u kHz mmio %08lx irq %d\n",
 		 id->i2c_clk / 1000, (unsigned long)r_mem->start, id->irq);
 
-- 
1.7.9.5
