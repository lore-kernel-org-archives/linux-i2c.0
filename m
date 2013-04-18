From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 3/3] i2c: designware-pci: drop superfluous {get|put}_device
Date: Thu, 18 Apr 2013 19:13:38 +0200
Message-ID: <1366305218-22817-4-git-send-email-wsa@the-dreams.de>
References: <1366305218-22817-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366305218-22817-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, manishv.b-l0cyMroinI0@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Driver core already takes care of refcounting, no need to do this on
driver level again.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index c8797e2..f6ed06c 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -288,9 +288,6 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 		return r;
 	}
 
-	/* Increase reference counter */
-	get_device(&pdev->dev);
-
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
@@ -307,7 +304,6 @@ static void i2c_dw_pci_remove(struct pci_dev *pdev)
 	pm_runtime_get_noresume(&pdev->dev);
 
 	i2c_del_adapter(&dev->adapter);
-	put_device(&pdev->dev);
 }
 
 /* work with hotplug and coldplug */
-- 
1.7.10.4
