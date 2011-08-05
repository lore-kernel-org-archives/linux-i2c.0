From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: tegra: Add CONFIG_OF guards for device tree bits
Date: Fri, 05 Aug 2011 15:05:21 +0800
Message-ID: <1312527921.21955.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, John Bonesio <bones-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The device tree bits need to be protected by CONFIG_OF guards.
This patch fixes below build error with "make tegra_defconfig;make".

  CC      drivers/i2c/busses/i2c-tegra.o
drivers/i2c/busses/i2c-tegra.c: In function 'tegra_i2c_probe':
drivers/i2c/busses/i2c-tegra.c:615: error: implicit declaration of function 'of_get_property'
drivers/i2c/busses/i2c-tegra.c:616: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/i2c/busses/i2c-tegra.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-tegra.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 0c6e840..1bfe85e 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -548,7 +548,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	struct clk *clk;
 	struct clk *i2c_clk;
-	const unsigned int *prop;
 	void *base;
 	int irq;
 	int ret = 0;
@@ -611,11 +610,15 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	if (pdata) {
 		i2c_dev->bus_clk_rate = pdata->bus_clk_rate;
 
+#ifdef CONFIG_OF
 	} else if (i2c_dev->dev->of_node) {    /* if there is a device tree node ... */
+		const unsigned int *prop;
+
 		prop = of_get_property(i2c_dev->dev->of_node,
 				"clock-frequency", NULL);
 		if (prop)
 			i2c_dev->bus_clk_rate = be32_to_cpup(prop);
+#endif
 	}
 
 	if (pdev->id == 3)
-- 
1.7.4.1
