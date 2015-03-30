From: Ioan Nicu <ioan.nicu.ext@nokia.com>
Subject: [PATCH v2] i2c: i2c-mux-gpio: remove error messages for probe
 deferrals
Date: Mon, 30 Mar 2015 15:03:38 +0200
Message-ID: <20150330130338.GB5933@ulegcpding.emea.nsn-net.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>, Mathias Rulf <mathias.rulf@nokia.com>
List-Id: linux-i2c@vger.kernel.org

Probe deferral is not an error case. It happens only when
the necessary dependencies are not there yet.

The driver core is already printing a message when a driver
requests probe deferral, so this can be traced in the logs
without these error prints.

This patch removes the error messages for these deferral cases.

Signed-off-by: Ionut Nicu <ioan.nicu.ext@nokia.com>
---
 drivers/i2c/muxes/i2c-mux-gpio.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index f5798eb..70db992 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -76,10 +76,9 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
 		return -ENODEV;
 	}
 	adapter = of_find_i2c_adapter_by_node(adapter_np);
-	if (!adapter) {
-		dev_err(&pdev->dev, "Cannot find parent bus\n");
+	if (!adapter)
 		return -EPROBE_DEFER;
-	}
+
 	mux->data.parent = i2c_adapter_id(adapter);
 	put_device(&adapter->dev);
 
@@ -177,11 +176,8 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
 	}
 
 	parent = i2c_get_adapter(mux->data.parent);
-	if (!parent) {
-		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
-			mux->data.parent);
+	if (!parent)
 		return -EPROBE_DEFER;
-	}
 
 	mux->parent = parent;
 	mux->gpio_base = gpio_base;
-- 
1.7.1
