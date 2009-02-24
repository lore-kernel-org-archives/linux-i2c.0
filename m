From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/3] i2c/pca-platform: use defaults if no platform_data given
Date: Tue, 24 Feb 2009 17:22:16 +0100
Message-ID: <1235492536-31695-4-git-send-email-w.sang@pengutronix.de>
References: <1235492536-31695-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1235492536-31695-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-pca-platform.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index df5e593..7b23891 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -177,10 +177,20 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 		 (unsigned long) res->start);
 	i2c->adap.algo_data = &i2c->algo_data;
 	i2c->adap.dev.parent = &pdev->dev;
-	i2c->adap.timeout = platform_data->timeout;
 
-	i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
+	if (platform_data) {
+		i2c->adap.timeout = platform_data->timeout;
+		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
+		i2c->gpio = platform_data->gpio;
+	} else {
+		i2c->adap.timeout = HZ;
+		i2c->algo_data.i2c_clock = 59000;
+		i2c->gpio = -1;
+	}
+
 	i2c->algo_data.data = i2c;
+	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
+	i2c->algo_data.reset_chip = i2c_pca_pf_dummyreset;
 
 	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
@@ -198,11 +208,6 @@ static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
 		break;
 	}
 
-	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
-
-	i2c->gpio = platform_data->gpio;
-	i2c->algo_data.reset_chip = i2c_pca_pf_dummyreset;
-
 	/* Use gpio_is_valid() when in mainline */
 	if (i2c->gpio > -1) {
 		ret = gpio_request(i2c->gpio, i2c->adap.name);
-- 
1.5.6.5
